USE [Shop LV-608.db];


IF OBJECT_ID('dbo.vw_PurchaseOrders', 'V') IS NOT NULL
    DROP VIEW dbo.vw_PurchaseOrders
GO

CREATE VIEW dbo.vw_PurchaseOrders AS
SELECT
	PO.PurchaseOrderID,
	PO.SuplierID 'SupplierID',
	PO.EmployeeID,
	PO.DeliveryDate,
	POD.ProductID,
	POD.Quantity,
	POD.Price
FROM [Shop LV-608.db].[dbo].[PurchaseOrders] AS PO
INNER JOIN [Shop LV-608.db].[dbo].[PurchaseOrderDetails] AS POD
ON PO.PurchaseOrderID = POD.PurchaseOrderDetailID
GO

SELECT * FROM dbo.vw_PurchaseOrders


IF OBJECT_ID('dbo.vw_FullPurchaseOrders', 'V') IS NOT NULL
    DROP VIEW dbo.vw_FullPurchaseOrders
GO
	CREATE VIEW dbo.vw_FullPurchaseOrders AS
	SELECT
		PO.PurchaseOrderID,
		P.ProductID,
		P.ProductName 'ProdName',
		P.SalesPrice 'ProdSalesPrice',
		P.TypeProduct 'ProdType',
		B.BrandName 'ProdBrandName',
		PO.DeliveryDate,
		POD.Quantity,
		POD.Price, 
		S.SupplierID,
		S.AddressID 'SupAddressID',
		S.ContactName 'SupContactName',
		S.Phone 'SupPhone',
		S.Email 'SupEmail',
		E.EmployeeID,
		E.FirstName +' ' + E.LastName 'EmpContactName', 
		E.Position 'EmpPosition',
		E.AddressID 'EmpAddressID',
		E.Phone 'EmpPhone',
		E.Email 'EmpEmail'
	FROM [Shop LV-608.db].[dbo].[PurchaseOrders] AS PO
	INNER JOIN [Shop LV-608.db].[dbo].[PurchaseOrderDetails] AS POD
	ON PO.PurchaseOrderID = POD.PurchaseOrderDetailID
	INNER JOIN [Shop LV-608.db].[dbo].[Products] AS P
	ON POD.ProductID = P.ProductID
	LEFT JOIN [Shop LV-608.db].[dbo].[Brands] AS B
	ON P.BrandID = B.BrandID
	LEFT JOIN [Shop LV-608.db].[dbo].[Suppliers] S
	ON PO.SuplierID = S.SupplierID
	LEFT JOIN [Shop LV-608.db].[dbo].[Employees] AS E
	ON PO.EmployeeID = E.EmployeeID
GO

SELECT * FROM dbo.vw_FullPurchaseOrders


-- Get top N Suppliers 
SELECT TOP 3 
	S.SupplierID,
	S.AddressID 'SupAddressID',
	S.ContactName 'SupContactName',
	S.Phone 'SupPhone',
	S.Email 'SupEmail',
	SUM(POD.Quantity * POD.Price) 'TotalDealSum'
FROM [Shop LV-608.db].[dbo].[PurchaseOrders] PO
	INNER JOIN [Shop LV-608.db].[dbo].[PurchaseOrderDetails] AS POD
	ON PO.PurchaseOrderID = POD.PurchaseOrderDetailID
	INNER JOIN [Shop LV-608.db].[dbo].[Suppliers] AS S
	ON PO.SuplierID = S.SupplierID
	GROUP BY S.SupplierID,
		S.AddressID,
		S.ContactName,
		S.Phone,
		S.Email
	ORDER BY TotalDealSum DESC


-- Select cumulative deal size for each Supplier 
SELECT
	PO.SuplierID 'SupplierID',
	PO.DeliveryDate,
	POD.Quantity,
	POD.Price,
	SUM(POD.Quantity * POD.Price) OVER (PARTITION BY PO.SuplierID ORDER BY PO.DeliveryDate) 'CumulativeDeal'
FROM [Shop LV-608.db].[dbo].[PurchaseOrders] PO
INNER JOIN [Shop LV-608.db].[dbo].[PurchaseOrderDetails] POD
ON PO.PurchaseOrderID = POD.PurchaseOrderDetailID
ORDER BY PO.SuplierID, DeliveryDate


-- Delete repeated rows in table in optimal way
IF OBJECT_ID(N'dbo.spr_RemovePurchaseOrdersDuplicates', N'P') IS NOT NULL
	DROP PROCEDURE dbo.spr_RemovePurchaseOrdersDuplicates;
GO
CREATE PROCEDURE dbo.spr_RemovePurchaseOrdersDuplicates
AS
BEGIN
SET NOCOUNT ON

;WITH numbered AS (
	SELECT
		PurchaseOrderID,
		SuplierID 'SupplierID',
		EmployeeID, 
		DeliveryDate,
		row_number() OVER (
			PARTITION BY PurchaseOrderID 
			ORDER BY PurchaseOrderID
		) row_num
	FROM [Shop LV-608.db].[dbo].[PurchaseOrders]
)
DELETE FROM numbered
WHERE row_num <> 1 
END

EXEC spr_RemovePurchaseOrdersDuplicates


-- Stored procedure to insert values into PurchaseOrders and PurchaseOrderDetails table
IF OBJECT_ID(N'dbo.spr_InsertPurchaseOrders', N'P') IS NOT NULL
	DROP PROCEDURE dbo.spr_InsertPurchaseOrders;
GO
CREATE PROCEDURE dbo.spr_InsertPurchaseOrders
(@SupplierID INT, @EmployeeID INT, @DeliveryDate DATE, @ProductID INT, @Quantity INT, @Price NUMERIC)
AS
BEGIN
SET NOCOUNT ON

DECLARE @ErrorMessage NVARCHAR(4000)

EXEC dbo.[spr_LogProcess] 'spr_InsertPurchaseOrders', 'Start'

BEGIN TRY
	-- Insert values into PurchaseOrders
	INSERT INTO [Shop LV-608.db].[dbo].[PurchaseOrders] (
			SuplierID, 
			EmployeeID, 
			DeliveryDate
		)
		VALUES (
			@SupplierID,
			@EmployeeID, 
			@DeliveryDate
		)

	-- Get inserted row ID
	DECLARE @PurchaseOrderID INT;
	SET @PurchaseOrderID = (
		SELECT MAX(PurchaseOrderID)
		FROM [Shop LV-608.db].[dbo].[PurchaseOrders]
		WHERE SuplierID = @SupplierID
		AND EmployeeID = @EmployeeID
		AND DeliveryDate = @DeliveryDate
	)

	-- Insert values into PurchaseOrderDetails
	INSERT INTO [Shop LV-608.db].[dbo].[PurchaseOrderDetails] (
			PurchaseOrderID,
			ProductID,
			Quantity, 
			Price
		)
		VALUES (
			@PurchaseOrderID,
			@ProductID,
			@Quantity,
			@Price
		)
END TRY
BEGIN CATCH  
    SELECT 
        @ErrorMessage = ERROR_MESSAGE()

	EXEC dbo.[spr_LogProcess] 'spr_InsertPurchaseOrders', 'Fatal', @ErrorDescription = @ErrorMessage 
END CATCH

EXEC dbo.[spr_LogProcess] 'spr_InsertPurchaseOrders', 'Stop', @TableName = 'PurchaseOrders', @InsertedCount = 1
END

EXEC dbo.spr_InsertPurchaseOrders 
	@SupplierID = 1,
	@EmployeeID = 1,
	@DeliveryDate = '2021-01-01',
	@ProductID = 1,
	@Quantity = 0,
	@Price = 1.
GO
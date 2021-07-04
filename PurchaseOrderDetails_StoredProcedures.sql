

CREATE PROCEDURE GetPurchaseOrders
AS
BEGIN
SET NOCOUNT ON
 
SELECT PO.PurchaseOrderID, PO.SuplierID 'SupplierID', PO.EmployeeID, PO.DeliveryDate,
	POD.ProductID, POD.Quantity, POD.Price
FROM PurchaseOrders PO
INNER JOIN PurchaseOrderDetails POD
ON PO.PurchaseOrderID = POD.PurchaseOrderDetailID
 
END


CREATE PROCEDURE GetPurchaseOrderByID
(@PurchaseOrderID INT)
AS
BEGIN
SET NOCOUNT ON
 
SELECT PO.PurchaseOrderID, PO.SuplierID 'SupplierID', PO.EmployeeID, PO.DeliveryDate,
	POD.ProductID, POD.Quantity, POD.Price
FROM PurchaseOrders PO
INNER JOIN PurchaseOrderDetails POD
ON PO.PurchaseOrderID = POD.PurchaseOrderDetailID
WHERE PO.PurchaseOrderID =@PurchaseOrderID
 
END


CREATE PROCEDURE GetFullPurchaseOrders
AS
BEGIN
SET NOCOUNT ON
 
SELECT PO.PurchaseOrderID,
	P.ProductID, P.ProductName 'ProdName', P.SalesPrice 'ProdSalesPrice', P.TypeProduct 'ProdType',
	B.BrandName 'ProdBrandName',
	PO.DeliveryDate, POD.Quantity, POD.Price, 
	S.SupplierID, S.AddressID 'SupAddressID', S.ContactName 'SupContactName', S.Phone 'SupPhone', S.Email 'SupEmail',
	E.EmployeeID, E.FirstName +' ' + E.LastName 'EmpContactName', E.Position 'EmpPosition', E.AddressID 'EmpAddressID', E.Phone 'EmpPhone', E.Email 'EmpEmail'
FROM PurchaseOrders PO
INNER JOIN PurchaseOrderDetails POD
ON PO.PurchaseOrderID = POD.PurchaseOrderDetailID
INNER JOIN Products P
ON POD.ProductID = P.ProductID
LEFT JOIN Brands B
ON P.BrandID = B.BrandID
LEFT JOIN Suppliers S
ON PO.SuplierID = S.SupplierID
LEFT JOIN Employees E
ON PO.EmployeeID = E.EmployeeID
 
END


CREATE PROCEDURE GetFullPurchaseOrdersByID
(@PurOrderID INT)
AS
BEGIN
SET NOCOUNT ON
 
SELECT PO.PurchaseOrderID,
	P.ProductID, P.ProductName 'ProdName', P.SalesPrice 'ProdSalesPrice', P.TypeProduct 'ProdType',
	B.BrandName 'ProdBrandName',
	PO.DeliveryDate, POD.Quantity, POD.Price, 
	S.SupplierID, S.AddressID 'SupAddressID', S.ContactName 'SupContactName', S.Phone 'SupPhone', S.Email 'SupEmail',
	E.EmployeeID, E.FirstName +' ' + E.LastName 'EmpContactName', E.Position 'EmpPosition', E.AddressID 'EmpAddressID', E.Phone 'EmpPhone', E.Email 'EmpEmail'
FROM PurchaseOrders PO
INNER JOIN PurchaseOrderDetails POD
ON PO.PurchaseOrderID = POD.PurchaseOrderDetailID
INNER JOIN Products P
ON POD.ProductID = P.ProductID
LEFT JOIN Brands B
ON P.BrandID = B.BrandID
LEFT JOIN Suppliers S
ON PO.SuplierID = S.SupplierID
LEFT JOIN Employees E
ON PO.EmployeeID = E.EmployeeID
WHERE PO.PurchaseOrderID = @PurOrderID
 
END


CREATE PROCEDURE GetFullPurchaseOrdersByProductID
(@ProductID INT)
AS
BEGIN
SET NOCOUNT ON
 
SELECT PO.PurchaseOrderID,
	P.ProductID, P.ProductName 'ProdName', P.SalesPrice 'ProdSalesPrice', P.TypeProduct 'ProdType',
	B.BrandName 'ProdBrandName',
	PO.DeliveryDate, POD.Quantity, POD.Price, 
	S.SupplierID, S.AddressID 'SupAddressID', S.ContactName 'SupContactName', S.Phone 'SupPhone', S.Email 'SupEmail',
	E.EmployeeID, E.FirstName +' ' + E.LastName 'EmpContactName', E.Position 'EmpPosition', E.AddressID 'EmpAddressID', E.Phone 'EmpPhone', E.Email 'EmpEmail'
FROM PurchaseOrders PO
INNER JOIN PurchaseOrderDetails POD
ON PO.PurchaseOrderID = POD.PurchaseOrderDetailID
INNER JOIN Products P
ON POD.ProductID = P.ProductID
LEFT JOIN Brands B
ON P.BrandID = B.BrandID
LEFT JOIN Suppliers S
ON PO.SuplierID = S.SupplierID
LEFT JOIN Employees E
ON PO.EmployeeID = E.EmployeeID
WHERE P.ProductID = @ProductID
 
END


CREATE PROCEDURE GetFullPurchaseOrdersBySupplierID
(@SupplierID INT)
AS
BEGIN
SET NOCOUNT ON
 
SELECT PO.PurchaseOrderID,
	P.ProductID, P.ProductName 'ProdName', P.SalesPrice 'ProdSalesPrice', P.TypeProduct 'ProdType',
	B.BrandName 'ProdBrandName',
	PO.DeliveryDate, POD.Quantity, POD.Price, 
	S.SupplierID, S.AddressID 'SupAddressID', S.ContactName 'SupContactName', S.Phone 'SupPhone', S.Email 'SupEmail',
	E.EmployeeID, E.FirstName +' ' + E.LastName 'EmpContactName', E.Position 'EmpPosition', E.AddressID 'EmpAddressID', E.Phone 'EmpPhone', E.Email 'EmpEmail'
FROM PurchaseOrders PO
INNER JOIN PurchaseOrderDetails POD
ON PO.PurchaseOrderID = POD.PurchaseOrderDetailID
INNER JOIN Products P
ON POD.ProductID = P.ProductID
LEFT JOIN Brands B
ON P.BrandID = B.BrandID
LEFT JOIN Suppliers S
ON PO.SuplierID = S.SupplierID
LEFT JOIN Employees E
ON PO.EmployeeID = E.EmployeeID
WHERE S.SupplierID = @SupplierID
 
END


CREATE PROCEDURE GetFullPurchaseOrdersByEmployeeID
(@EmployeeID INT)
AS
BEGIN
SET NOCOUNT ON
 
SELECT PO.PurchaseOrderID,
	P.ProductID, P.ProductName 'ProdName', P.SalesPrice 'ProdSalesPrice', P.TypeProduct 'ProdType',
	B.BrandName 'ProdBrandName',
	PO.DeliveryDate, POD.Quantity, POD.Price, 
	S.SupplierID, S.AddressID 'SupAddressID', S.ContactName 'SupContactName', S.Phone 'SupPhone', S.Email 'SupEmail',
	E.EmployeeID, E.FirstName +' ' + E.LastName 'EmpContactName', E.Position 'EmpPosition', E.AddressID 'EmpAddressID', E.Phone 'EmpPhone', E.Email 'EmpEmail'
FROM PurchaseOrders PO
INNER JOIN PurchaseOrderDetails POD
ON PO.PurchaseOrderID = POD.PurchaseOrderDetailID
INNER JOIN Products P
ON POD.ProductID = P.ProductID
LEFT JOIN Brands B
ON P.BrandID = B.BrandID
LEFT JOIN Suppliers S
ON PO.SuplierID = S.SupplierID
LEFT JOIN Employees E
ON PO.EmployeeID = E.EmployeeID
WHERE E.EmployeeID = @EmployeeID
 
END


CREATE PROCEDURE InsertPurchaseOrders
(@SupplierID INT, @EmployeeID INT, @DeliveryDate DATE, @ProductID INT, @Quantity INT, @Price NUMERIC)
AS
BEGIN
SET NOCOUNT ON

INSERT INTO PurchaseOrders
		(SuplierID, 
		EmployeeID, 
		DeliveryDate)
	VALUES
		(@SupplierID,
		@EmployeeID, 
		@DeliveryDate);

DECLARE @PurchaseOrderID INT;
SET @PurchaseOrderID = (
	SELECT MAX(PurchaseOrderID)
	FROM PurchaseOrders
	WHERE SuplierID = @SupplierID
	AND EmployeeID = @EmployeeID
	AND DeliveryDate = @DeliveryDate
);

INSERT INTO PurchaseOrderDetails
		(PurchaseOrderID,
		ProductID,
		Quantity, 
		Price)
	VALUES
		(@PurchaseOrderID,
		@ProductID,
		@Quantity,
		@Price);
 
END



EXEC GetPurchaseOrders

EXEC GetPurchaseOrderByID 3

EXEC GetFullPurchaseOrders

EXEC GetFullPurchaseOrdersByID 3

EXEC GetFullPurchaseOrdersByProductID 3

EXEC GetFullPurchaseOrdersBySupplierID 2

EXEC GetFullPurchaseOrdersByEmployeeID 122

EXEC InsertPurchaseOrders 
	@SupplierID = 1,
	@EmployeeID = 1,
	@DeliveryDate = '2021-01-01',
	@ProductID = 1,
	@Quantity = 1,
	@Price = 1.1
GO

SELECT *
	FROM PurchaseOrders po
	INNER JOIN PurchaseOrderDetails pod
	ON po.PurchaseOrderID = pod.PurchaseOrderDetailID
	WHERE SuplierID = 1
	AND EmployeeID = 1
	AND DeliveryDate = '2021-01-01'
CREATE TABLE Products (

	ProductID integer PRIMARY KEY IDENTITY (1, 1) NOT NULL
	, ProductName nvarchar (30) NULL
	, QuantityInStock integer NULL
	, SalesPrice numeric NULL
	, TypeProduct nvarchar (30) NULL
	, Gender nvarchar (1) NULL
	, Season nvarchar (10) NULL
	, Size nvarchar (2) NULL
	, BrandID integer
	FOREIGN KEY (BrandID) REFERENCES Brands (BrandID)
	
)

CREATE TABLE Customers(
	CustomerID INT PRIMARY KEY IDENTITY(1, 1) NOT NULL
	, FirstName NVARCHAR (30) NOT NULL
	, LastName NVARCHAR (30) NOT NULL
	, Gender NCHAR (1) NOT NULL
	, DateOfBirth DATE NOT NULL
	, Phone NCHAR (13) NOT NULL
	, Email NVARCHAR (50) NOT NULL
	, AdressID INT
	FOREIGN KEY (Adress_id) REFERENCES Adress (Adress_id)
)

CREATE TABLE Returns(
       Return_ID INT PRIMARY KEY IDENTITY NOT NULL
       , OrderDetail_ID INT NULL
       , ReturnQuantity INT NULL
       , ReturnDate DATE NULL
       , ReturnReason NVARCHAR(50) NULL
       , ReturnStatus NVARCHAR(30) NULL
       FOREIGN KEY (OrderDetailId) REFERENCES OrderDetails (OrderDetailId)
)

CREATE TABLE PurchaseOrders(
	PurchaseOrderID INT PRIMARY KEY IDENTITY NOT NULL,
	SuplierID INT FOREIGN KEY REFERENCES Suppliers(SupplierID),
	EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID),
	DeliveryDate DATE NOT NULL
)

CREATE TABLE PurchaseOrderDetails(
	PurchaseOrderDetailID INT PRIMARY KEY IDENTITY NOT NULL,
	PurchaseOrderID INT FOREIGN KEY REFERENCES PurchaseOrders(PurchaseOrderID),
	ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
	Quantity INT NOT NULL,
	Price NUMERIC NOT NULL
)

CREATE TABLE Adress
(
	AddressID int PRIMARY KEY IDENTITY (1, 1),
	AdressType int NULL,
	Appartament varchar(10) NULL,
	City varchar(30)  NULL,
	Region varchar(25) NULL,
	PostaCode int NULL
)



CREATE TABLE Employees (
      EmployeID INT IDENTITY(1, 1) PRIMARY KEY
    , FirstName NVARCHAR(30) NOT NULL
    , LastName NVARCHAR(30) NOT NULL
    , Position NVARCHAR(30) NOT NULL
    , AddressID INT NOT NULL
    , Hire_date DATE NOT NULL
    , Fire_date DATE 
    , Phone INT NOT NULL
    , Email NVARCHAR(30) NOT NULL
    , FOREIGN KEY (AddressID)  REFERENCES Addresses (AddressID) 
)

GO

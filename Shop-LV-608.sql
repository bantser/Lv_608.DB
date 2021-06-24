CREATE TABLE Products (

	product_id integer PRIMARY KEY IDENTITY (1, 1) NOT NULL,
	productName nvarchar (30) NOT NULL,
	quantityInStock integer NOT NULL,
	salesPrice numeric NOT NULL,
	typeProduct nvarchar (30) NOT NULL,
	gender nvarchar (1) NOT NULL,
	season nvarchar (10) NOT NULL,
	size nvarchar (2) NOT NULL,
	brand_id integer,

	FOREIGN KEY (brand_id) REFERENCES Brands (brand_id),

	CHECK (quantityInStock>=0 AND salesPrice>=0)

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
       , ReturnStatus NVARCHAR(50) NULL
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

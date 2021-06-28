



/****** Object:  Table [dbo].[Table_1]    Script Date: 6/24/2021 2:51:26 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE Addresses
(
	AddressID int PRIMARY KEY IDENTITY (1, 1),
	AddressType int NULL,
	Apartment nvarchar(45) NULL,
	City nvarchar(45)  NULL,
	PostalCode int NULL
)

If Object_ID ('Brands', 'U') IS NOT NULL
DROP TABLE Brands


CREATE TABLE Brands(
   BrandID int NOT NULL PRIMARY KEY IDENTITY(1,1)
  ,BrandName nvarchar(50) NULL 
  ,CountryOfManufacture nvarchar(50)NULL

);

If Object_ID ('Suppliers', 'U') IS NOT NULL
DROP TABLE Suppliers
GO

CREATE TABLE Suppliers(
   SupplID int NOT NULL PRIMARY KEY IDENTITY(1,1)
  ,AdressID int  NULL
  ,ContactName nvarchar(50) NULL
  ,Phone nvarchar(20) NULL
  ,Email nvarchar(50) NULL
);


If Object_ID ('BrandSuppliers', 'U') IS NOT NULL
DROP TABLE BrandSuppliers
GO

CREATE TABLE BrandSuppliers(
  BrandID int FOREIGN KEY REFERENCES Brands(BrandID)
 ,SupplID int FOREIGN KEY REFERENCES Suppliers(SupplID)
 --PRIMARY KEY(BrandID,SupplID)
);




CREATE TABLE Products (

	ProductID integer PRIMARY KEY IDENTITY (1, 1) NOT NULL
	, ProductName nvarchar (100) NULL
	, QuantityInStock integer NULL
	, SalesPrice numeric NULL
	, TypeProduct nvarchar (30) NULL
	, Gender nvarchar (10) NULL
	, Season nvarchar (10) NULL
	, Size nvarchar (5) NULL
	, BrandID integer
	, Color nvarchar (30) NULL
	FOREIGN KEY (BrandID) REFERENCES Brands (BrandID)
	
)


CREATE TABLE Customers(
	CustomerID int PRIMARY KEY IDENTITY(1, 1) NOT NULL
	, FirstName nvarchar (30) NULL
	, LastName nvarchar (30) NULL
	, Gender nchar (1) NULL
	, DateOfBirth date NULL
	, Phone nchar (13) NULL
	, Email nvarchar (50) NULL
	, AddressID int FOREIGN KEY (AddressID) REFERENCES Addresses (AddressID)
)



CREATE TABLE Deliveries(
       DeliveryID INT PRIMARY KEY IDENTITY NOT NULL
       , AddressID INT  FOREIGN KEY (AddressID) REFERENCES Addresses (AddressID)
       , CompanyName NVARCHAR(50) NULL
       , DepartureDate DATE NULL
)


CREATE TABLE Employees (
      EmployeeID INT IDENTITY(1, 1) PRIMARY KEY
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




 CREATE TABLE OrderDetails
 
 (   OrderDetailID int PRIMARY KEY IDENTITY (1,1) NOT NULL ,
     ProductID int NOT NULL ,
     DiscountPerUnit numeric (18,2) NULL,
     PricePerUnit numeric (18,2) NULL,
     Quantity integer NULL,


  FOREIGN KEY(ProductID) REFERENCES Products(ProductID))

CREATE TABLE Orders

(   OrderID int PRIMARY KEY IDENTITY (1,1) NOT NULL ,
    OrderDetailID int  not null,
    CustomerID int NOT NULL ,
    DeliveryID int NOT NULL,
    TotalCost numeric (18,2) NULL,
    TotalDiscount numeric(18,2) NULL,
    EmployeeID int not NULL ,
    OrderData datetime NULL,
    InvoiceData datetime NULL,
    PaymentMethod nvarchar (100) NULL,
    ReturnID INT,

 FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID),
 FOREIGN KEY(DeliveryID) REFERENCES Deliveries(DeliveryID),
 FOREIGN KEY(OrderDetailID) REFERENCES OrderDetails(OrderDetailID),
 FOREIGN KEY (ReturnID) REFERENCES Returns (ReturnID),
 FOREIGN KEY(EmployeeID) REFERENCES Employees(EmployeeID))


  CREATE TABLE Returns(
       ReturnID INT PRIMARY KEY IDENTITY NOT NULL
       , Quantity int NULL
       , Date date NULL
       , Reason nvarchar(50) NULL
       , Status nvarchar(30) NULL

)

CREATE TABLE PurchaseOrders(
	PurchaseOrderID INT PRIMARY KEY IDENTITY NOT NULL,
	SuplierID INT FOREIGN KEY REFERENCES Suppliers(SupplID),
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


 ON [PRIMARY]
GO



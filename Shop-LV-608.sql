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
	CustomerID int PRIMARY KEY IDENTITY(1, 1) NOT NULL
	, FirstName nvarchar (30) NULL
	, LastName nvarchar (30) NULL
	, Gender nchar (1) NULL
	, DateOfBirth date NULL
	, Phone nchar (13) NULL
	, Email nvarchar (50) NULL
	, AdressID int FOREIGN KEY (Adress_id) REFERENCES Adress (Adress_id)
)

CREATE TABLE Returns(
       Return_ID INT PRIMARY KEY IDENTITY NOT NULL
       , OrderDetail_ID int NULL
       , ReturnQuantity int NULL
       , ReturnDate date NULL
       , ReturnReason nvarchar(50) NULL
       , ReturnStatus nvarchar(30) NULL
       FOREIGN KEY (OrderDetailId) REFERENCES OrderDetails (OrderDetailId)
)

CREATE TABLE Brands(
       BrandID int NOT NULL PRIMARY KEY IDENTITY(1,1)
      ,BrandName nvarchar(50) NULL 
      ,CountryOfManufacture nvarchar(50)NULL

);


CREATE TABLE Suppliers(
     SupplID int NOT NULL PRIMARY KEY IDENTITY(1,1)
    ,AdressID int NOT NULL
    ,ContactName nvarchar(50) NULL
    ,Phone int NULL
    ,Email nvarchar(50) NULL,
    HomePage nvarchar(50)

);


CREATE TABLE BrandSuppliers(
   BrandID int NOT NULL FOREIGN KEY REFERENCES Brands(BrandID)
  ,SupplID int NOT NULL FOREIGN KEY REFERENCES Suppliers(SupplID)
  PRIMARY KEY(BrandID,SupplID)
);



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

CREATE TABLE Orders

(   Orders_id int PRIMARY KEY IDENTITY (1,1) NOT NULL  ,
    Customer_id int NOT NULL ,
    Delivery_id int NOT NULL,
    TotalCost numeric (18,2) NULL,
    TotalDiscount numeric(18,2) NULL,
    Empl_id int not NULL ,
    OrderData datetime NULL,
    InvoiceData datetime NULL,
    PaymentMethod nvarchar (100) NULL,

 FOREIGN KEY(Customer_id) REFERENCES Customers(Customer_id),
 FOREIGN KEY(Delivery_id) REFERENCES Delivery(Delivery_id),
 FOREIGN KEY(Empl_id) REFERENCES Employees(Empl_id))

 CREATE TABLE OrderDetails
 
 (   OrderDetail_id int PRIMARY KEY IDENTITY (1,1) NOT NULL ,
     Order_id int NOT NULL,
     Product_id int NOT NULL ,
     DiscountPerUnit numeric (18,2) NULL,
     PricePerUnit numeric (18,2) NULL,
     Quantity integer NULL,

  FOREIGN KEY(Orders-id) REFERENCES Orders(Orders_id),
  FOREIGN KEY(Product_id) REFERENCES Products(Product_id))
  
CREATE TABLE Deliveries(
       DeliveryID INT PRIMARY KEY IDENTITY NOT NULL
       , AddressID INT  FOREIGN KEY (AddressID) REFERENCES Address (AddressID)
       , CompanyName NVARCHAR(50) NULL
       , DepartureDate DATE NULL
)

GO

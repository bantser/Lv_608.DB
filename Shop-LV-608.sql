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
       Return_ID INT NOT NULL PRIMARY KEY
       , OrderDetail_ID INT NOT NULL
       , ReturnQuantity INT NOT NULL
       , ReturnDate DATE NOT NULL
       , ReturnReason NVARCHAR(50) NULL
       , ReturnStatus NVARCHAR(50) NOT NULL
)

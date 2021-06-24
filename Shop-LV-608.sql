
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
       Return_ID int Not Null Primary Key
       , OrderDetail_ID int Not Null
       , ReturnQuantity int Not Null
       , ReturnDate date Not null
       , ReturnReason nvarchar(50) Null
       , ReturnStatus nvarchar(50) Not Null
)

CREATE TABLE Adress
(
	AddressID int PRIMARY KEY IDENTITY,
	AdressType int NOT NULL,
	Appartament Varchar(10) NOT NULL,
	City Varchar(30) NOT NULL,
	Region Varchar(25)NOT NULL,
	PostaCode int NOT NULL
)
GO

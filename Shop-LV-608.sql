
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
       ReturnID int Not Null Primary Key
       , OrderDetailID int Not Null
       , ReturnQuantity int Not Null
       , ReturnDate date Not null
       , ReturnReason nvarchar(50) Null
       , ReturnStatus nvarchar(50) Not Null
)

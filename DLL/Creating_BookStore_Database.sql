
IF NOT EXISTS (
	SELECT name FROM sys.databases WHERE name = 'BookStore'
)
CREATE DATABASE BookStore;
GO

USE BookStore;

-- Books table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'Books' and xtype = 'U')
CREATE TABLE Books (
    BookID INT PRIMARY KEY IDENTITY,
    Title NVARCHAR(100) NOT NULL,
    AuthorID INT,
    PublisherID INT,
    PublicationYear INT NOT NULL,
    Price INT NOT NULL,
    Genre NVARCHAR(100) NOT NULL
);

-- Authors table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name  = 'Authors' and xtype = 'U')
CREATE TABLE Authors(
    AuthorID INT PRIMARY KEY IDENTITY,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    DateOfBirth DATETIME
);

-- Publishers table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'Publishers' AND xtype = 'U')
CREATE TABLE Publishers(
    PublisherID INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(100) NOT NULL,
    Address NVARCHAR(100) NOT NULL,
    Website NVARCHAR(100) NOT NULL
);

-- Adding foreign keys to Books table
IF EXISTS (SELECT * FROM sysobjects WHERE name='Books' AND xtype='U')
BEGIN
ALTER TABLE Books
ADD FOREIGN KEY(AuthorID) REFERENCES Authors(AuthorID);

ALTER TABLE Books
ADD FOREIGN KEY(PublisherID) REFERENCES Publishers(PublisherID);
END

-- Customers table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'Customers' AND xtype = 'U')
CREATE TABLE Customers(
    CustomerID INT PRIMARY KEY IDENTITY,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(100) NOT NULL
);

-- Orders table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'Orders' AND xtype = 'U')
CREATE TABLE Orders(
    OrderID INT PRIMARY KEY IDENTITY,
    CustomerID INT REFERENCES Customers(CustomerID),
    BookID INT REFERENCES Books(BookID),
    Quantity INT NOT NULL,
    OrderDate DATE
);

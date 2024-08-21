USE BookStore;

-- Write a query that combines the names of all authors and publishers into a single list. 
-- The result should include all author names and all publisher names in a single column named Name.
SELECT CONCAT(FirstName ,' ',LastName) AS Name FROM Authors 
UNION 
SELECT Name FROM Publishers;

-- Find the names of all customers who have placed an order and all authors who have published at least one book. 
-- Combine the results into a single list with a column named Name.

-- Customers who have placed at least one order
SELECT CONCAT(c.FirstName, ' ', c.LastName) AS Name
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID

UNION

-- Authors who have published at least one book
SELECT CONCAT(a.FirstName, ' ', a.LastName) AS Name
FROM Authors a
JOIN Books b ON a.AuthorID = b.AuthorID;

-- Write a query to list all first names of authors and customers in a single column named FirstName
SELECT FirstName FROM Authors 
UNION
SELECT FirstName FROM Customers;

-- Combine the book titles from the Books table with customer names from the Customers table into a single list. 
-- The result should have a column named BookOrCustomerName.
SELECT Title AS BookOrCustomerName FROM Books
UNION
SELECT CONCAT(FirstName, ' ', LastName) AS BookOrCustomerName FROM Customers;

-- Create a query that lists all order dates from the Orders table and all book titles from the Books table.
-- The combined result should be in a single column named DateOrTitle
SELECT CONVERT(NVARCHAR(100), OrderDate, 120) AS DateOrTitle FROM Orders 
UNION 
SELECT Title AS DateOrTitle FROM Books;

-- Write a query to combine all last names of authors with all last names of customers into a single list. The column in the result should be named LastName.
SELECT LastName AS LastName FROM Authors
UNION
SELECT LastName AS LastName FROM Customers;

-- Write a query that combines the email addresses of all customers and the website URLs of all publishers into a single list.
-- The result should be in a single column named ContactInfo
SELECT Email AS ContactInfo FROM Customers
UNION
SELECT Website AS ContactInfo FROM Publishers;

--  Write a query that combines the genres of all books and the first names of all authors into a single list.
-- The result should be in a single column named Info
SELECT Genre AS Info FROM Books
UNION
SELECT FirstName AS Info FROM Authors;

-- Write a query to list all publication years from the Books table and all order quantities from the Orders table.
-- The combined result should be in a single column named YearOrQuantity
SELECT CAST(PublicationYear AS NVARCHAR(100)) AS YearOrQuantity FROM Books
UNION
SELECT CAST(Quantity AS NVARCHAR(100)) AS YearOrQuantity FROM Orders;

-- Write a query that combines the addresses of all publishers and the phone numbers of all customers into a single list.
-- The result should be in a single column named ContactDetails.
SELECT Address AS ContactDetails FROM Publishers
UNION
SELECT Phone AS ContactDetails FROM Customers;
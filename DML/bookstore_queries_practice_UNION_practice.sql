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
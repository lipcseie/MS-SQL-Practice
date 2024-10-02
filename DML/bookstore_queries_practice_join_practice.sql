USE BookStore;

-- 1. List all books along with their authors' names and publication years.
SELECT B.Title, B.PublicationYear, A.FirstName, A.LastName
FROM Books B
JOIN Authors A ON B.AuthorID = A.AuthorID;

-- 2. Find all orders placed by customers, including the customer's full name, the book title, and the quantity ordered.
SELECT C.FirstName AS CustomerFirstName, C.LastName AS CustomerLastName, 
B.Title, O.Quantity
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN  Books B ON O.BookID = B.BookID

-- 3. Retrieve a list of all books along with their publishers' names and addresses.
SELECT B.Title AS BookTitle, P.Name AS PublisherName, P.Address AS PublisherAdress
FROM Books B
JOIN Publishers P ON B.PublisherID = P.PublisherID;

-- 4. Show the total quantity ordered for each book, including the book title and the total quantity ordered.
SELECT B.Title, SUM(O.Quantity) AS TotalQuantityOrder
FROM Books B
LEFT JOIN Orders O ON B.BookID = O.BookID
GROUP BY B.Title;

-- 5. Get a list of authors who have written books published by 'Hogwarts Press'. Include the author’s first and last name, and the book titles.
SELECT A.FirstName AS AuthorFirstName, A.LastName AS AuthorLastName, B.Title
FROM Authors A
JOIN Books B ON A.AuthorID = B.AuthorID
JOIN Publishers P ON B.PublisherID = P.PublisherID
WHERE Name = 'Hogwarts Press';

-- 6. Find all books ordered by 'Bruce Wayne', including the book title, the quantity ordered, and the publication year.
SELECT B.Title, B.PublicationYear,  O.Quantity as QuantityOrderd
FROM Books B
JOIN Orders O ON B.BookID = O.BookID
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE C.FirstName = 'Bruce' AND
C.LastName = 'Wayne';

-- 7. List all customers who have ordered books published by 'Valyrian Books'. Include the customer’s full name and email.
SELECT C.FirstName AS CustomerFirstName, 
	   C.LastName AS CustomerLastName, 
	   C.Email
FROM Customers C 
	JOIN Orders O ON C.CustomerID = O.CustomerID
	JOIN Books B ON B.BookID = B.BookID
	JOIN Publishers P ON B.PublisherID = P.PublisherID
WHERE 
	P.Name = 'Valyrian Books';

-- 8. List all authors who share the same last name. Show their full names and the full names of their colleagues with the same last name.
SELECT A.FirstName AS FisrtName1, A.LastName AS LastName1, 
	   B.FirstName AS FirstName2, B.LastName AS LastName2
FROM Authors A
JOIN Authors B ON A.LastName = B.LastName AND
A.AuthorID != B.AuthorID;

-- 9. Show the most recent book orders including the customer's name, book title, order date, and quantity.
SELECT C.FirstName, C.LastName, B.Title, O.OrderDate, O.Quantity
From Customers C
JOIN Orders O ON C.CustomerID = O.OrderID
JOIN Books B ON O.BookID = B.BookID
ORDER BY OrderDate DESC;

-- Find all books and their authors where the author's last name starts with 'S'.
SELECT B.Title, A.LastName 
FROM Books B
JOIN Authors A ON B.AuthorID = A.AuthorID
WHERE A.LastName LIKE 'S%';

-- List all publishers and the count of books they have published, including publishers with no books.
SELECT COUNT(B.BookID) AS BooksTheyPublished, P.Name
FROM Books B
LEFT JOIN Publishers P ON B.PublisherID = P.PublisherID
GROUP BY P.PublisherID,P.Name;

-- Retrieve the details of all orders along with the book titles and customer names.
SELECT O.OrderID, O.Quantity, O.OrderDate, B.Title AS BookTitle, C.FirstName AS CustomerFirstName, C.LastName AS CustomerLastName
FROM Orders O
JOIN Books B ON O.BookID = B.BookID
JOIN Customers C ON O.CustomerID = C.CustomerID;

-- Get a list of all customers who have ordered books in the year 2023. Include their full names and the titles of the books they ordered.
SELECT C.FirstName AS CustomerFirstName, C.LastName AS CustomerLastName, O.OrderDate, B.Title
FROM Customers C
JOIN Orders O ON C.CustomerID = O.OrderID
JOIN Books B ON O.BookID = B.BookID
WHERE YEAR(O.OrderDate) = 2023;

-- Find all books with their corresponding publisher names and prices that are above $20.
SELECT P.Name AS PublisherName, B.Title AS BookTitle, B.Price
FROM Publishers P
JOIN Books B ON P.PublisherID = B.PublisherID
WHERE B.Price > 20;

-- List all authors who have written more than 2 books and include their full names and the number of books they have written.
SELECT A.FirstName AS AuthorFirstName,A.LastName AS AuthorLastName, COUNT(B.BookID) AS BooksWritten
FROM Authors A
JOIN Books B ON A.AuthorID = B.AuthorID
GROUP BY A.FirstName, A.LastName
HAVING COUNT(B.BookID) > 2;

-- Show the total revenue generated from orders for each book. Include the book title and total revenue in the results.
SELECT B.Title AS BookTitle, 
	   SUM(B.Price * O.Quantity) AS TotalRevenue
FROM Books B
JOIN Orders O ON B.BookID = O.BookID
GROUP BY B.Title;

-- Find the oldest book (earliest publication year) and its author.
SELECT TOP 1 b.Title,
	   B.PublicationYear,
	   A.FirstName AS AuthorFirstName,
	   A.LastName AS AuthorLastName
FROM Books B
JOIN Authors A ON B.AuthorID = A.AuthorID
ORDER BY B.PublicationYear ASC;

-- List all customers who have ordered more than2 books in total, showing their full names and the total number of books ordered.
SELECT C.FirstName AS CustomerFirstName,
	   C.LastName AS CustomerLastName,
	   SUM(O.Quantity) AS TotalNumberOdBooksOrderd
FROm Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName, C.LastName
HAVING SUM(O.Quantity) > 2;

-- Retrieve a list of books and their genres where the genre is not 'Science Fiction' and display the title, genre, and the author's last name.
SELECT B.Title AS BookTitle,
	   B.Genre,
	   A.LastName
FROM Books B
JOIN Authors A ON B.AuthorID = A.AuthorID
WHERE B.Genre != 'Science Fiction';

-- Retrieve the total number of books sold by each author, grouped by author and sorted by the total number of books sold in descending order.
SELECT A.FirstName, A.LastName, SUM(O.Quantity) AS TotalBooksSold
FROM Authors A
JOIN Books B ON A.AuthorID = B.AuthorID
JOIN Orders O ON B.BookID = O.BookID
GROUP BY A.FirstName, A.LastName
ORDER BY TotalBooksSold DESC;

-- Retrieve the number of customers who have placed more than one order, grouped by customer.
SELECT C.FirstName, C.LastName, COUNT(O.OrderID) AS NumberOfOrders
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName
HAVING COUNT(O.OrderID) > 1;

-- Retrieve the number of orders placed for each publisher, grouped by publisher and sorted by the number of orders in descending order.
SELECT P.Name AS PublisherName, COUNT(O.OrderID) AS NumberOfOrders
FROM Publishers P
JOIN Books B ON P.PublisherID = B.PublisherID
JOIN Orders O ON B.BookID = O.BookID
GROUP BY P.Name
ORDER BY NumberOfOrders DESC;
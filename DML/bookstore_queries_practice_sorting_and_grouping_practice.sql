USE BookStore;

-- Retrieve a list of books sorted first by genre (alphabetically), and finally by price (ascending).
SELECT Title, Genre, Price
FROM Books
ORDER BY Genre ASC, Price ASC;

-- Retrieve a list of customers sorted by the number of orders they have placed, in descending order.
SELECT C.FirstName, C.LastName, COUNT(O.OrderID) AS NumberOfOrders
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName
ORDER BY NumberOfOrders DESC;

-- Retrieve a list of orders sorted by the total value of the order (Quantity * Price), in descending order.
SELECT O.OrderID, B.Title, (O.Quantity * B.Price) AS TotalValueOfTheOrder
FROM Orders O
JOIN Books B ON O.BookID = B.BookID
ORDER BY TotalValueOfTheOrder DESC;

-- Retrieve a list of publishers sorted by the number of books they have published, in descending order.
SELECT P.Name AS PublisherName, COUNT(B.BookID) AS NumberOfBookSTheyPublished
FROM Publishers P
JOIN Books B ON P.PublisherID = B.PublisherID
GROUP BY P.Name
ORDER BY NumberOfBookSTheyPublished DESC;

-- Retrieve the total sales (quantity * price) for each book genre.
SELECT B.Genre, SUM(O.Quantity * B.Price) AS TotalSales
FROM Books B
JOIN Orders O ON B.BookID = O.BookID
GROUP BY B.Genre;

-- Retrieve a list of publishers with the names of authors who have books published by each publisher.
SELECT P.Name AS PublisherName, A.FirstName, A.LastName 
FROM Publishers P
JOIN Books B ON P.PublisherID = B.PublisherID
JOIN Authors A ON B.AuthorID = A.AuthorID;

-- Retrieve the number of books ordered on each date, grouped by order date.
SELECT SUM(Quantity) AS BooksOrdered, OrderDate FROM Orders
GROUP BY OrderDate;

-- Sort Books by Publication Year and then by Title (alphabetically).
SELECT PublicationYear, Title 
FROM Books
ORDER BY PublicationYear ASC,
Title ASC;

-- Retrieve a list of authors grouped by the number of books they have written, sorted by the number of books in descending order.
SELECT A.FirstName, A.LastName, COUNT(B.Title) AS NumberOfBooks
FROM Authors A
JOIN Books B ON A.AuthorID = B.AuthorID
GROUP BY A.FirstName, A.LastName
ORDER BY NumberOfBooks DESC;

-- List all customers, sorted by their last name, and then by their first name.
SELECT FirstName, LastName
FROM Customers
ORDER BY LastName ASC,
FirstName ASC;

-- Retrieve the average price of books, grouped by genre and sorted by the average price in descending order.
SELECT Genre, AVG(Price) AS AvaragePrice
FROM Books
GROUP BY Genre
ORDER BY AvaragePrice DESC;

-- List all publishers, sorted by the average price of books they publish, from highest to lowest.
SELECT P.Name, AVG(B.Price) AS AveragePrice
FROM Publishers P
JOIN Books B ON P.PublisherID = B.PublisherID
GROUP BY P.Name
ORDER BY AveragePrice DESC;

-- Retrieve a list of orders, grouped by customer, and sorted by the total quantity of books ordered by each customer in descending order.
SELECT C.LastName, SUM(O.Quantity) AS TotalQuantity
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY C.LastName
ORDER BY TotalQuantity DESC;

-- Retrieve the total number of orders and total sales value for each book, sorted by the total sales value in descending order.
SELECT B.Title, COUNT(O.OrderID) AS TotalNumberOfOrders, SUM(B.Price * O.Quantity) AS TotalSales
FROM Orders O
JOIN Books B ON O.BookID = B.BookID
GROUP BY B.Title
ORDER BY TotalSales DESC;

-- Sort authors by their date of birth, from oldest to youngest, and then by their last name alphabetically.
SELECT DateOfBirth, LastName FROM Authors
ORDER BY DateOfBirth ASC, LastName ASC;

-- Retrieve the number of books available for each genre and sort the results by the number of books in descending order.
SELECT COUNT(Title) AS NumberOfBooks, Genre 
FROM Books
GROUP BY Genre
ORDER BY NumberOfBooks DESC;



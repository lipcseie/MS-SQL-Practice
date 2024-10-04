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

-- Retrieve the titles of books along with their authors, sorted by the author's last name, then by the book title alphabetically.
SELECT B.Title, A.LastName, A.FirstName
FROM Books B
JOIN Authors A ON B.AuthorID = A.AuthorID
ORDER BY A.LastName ASC, B.Title ASC;

-- Retrieve a list of customers sorted by the number of orders they have placed, in descending order.
SELECT C.FirstName, C.LastName, COUNT(O.OrderID) AS NumberOfOrders
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName
ORDER BY NumberOfOrders DESC;

-- Retrieve a list of books sorted by the number of orders placed for each book, in descending order.
SELECT B.Title, COUNT(O.OrderID) AS NumberOfOrders
FROM Books B
JOIN Orders O ON B.BookID = O.BookID
GROUP BY B.Title
ORDER BY NumberOfOrders DESC;

-- Retrieve the names of customers who have placed at least one order, grouped by customer name and sorted by their total spending in descending order.
SELECT C.FirstName, C.LastName, SUM(O.Quantity * B.Price) AS TotalSpent
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN Books B ON O.BookID = B.BookID
GROUP BY C.FirstName, C.LastName
ORDER BY TotalSpent DESC;

-- Retrieve the list of genres along with the number of distinct authors who have written in each genre, sorted by the number of authors in descending order.
SELECT B.Genre, COUNT(DISTINCT A.AuthorID) AS NumberOfAuthors
FROM Books B
JOIN Authors A ON B.AuthorID = A.AuthorID
GROUP BY B.Genre
ORDER BY NumberOfAuthors DESC;

-- Retrieve the titles of books and the total quantity ordered for each book, grouped by title and sorted by total quantity in ascending order.
SELECT B.Title, SUM(O.Quantity) AS TotalQuantityOrdered
FROM Books B
JOIN Orders O ON B.BookID = O.BookID
GROUP BY B.Title
ORDER BY TotalQuantityOrdered ASC;

-- Retrieve the names of authors and the total number of genres they have written in, grouped by author and sorted by the number of genres in descending order.
SELECT A.FirstName, A.LastName, COUNT(DISTINCT B.Genre) AS NumberOfGenres
FROM Authors A
JOIN Books B ON A.AuthorID = B.AuthorID
GROUP BY A.FirstName, A.LastName
ORDER BY NumberOfGenres DESC;

-- Retrieve the number of books published per year, grouped by publication year and sorted in descending order of book count.
SELECT B.PublicationYear, COUNT(B.BookID) AS NumberOfBooksPublished
FROM Books B
GROUP BY B.PublicationYear
ORDER BY NumberOfBooksPublished DESC;

-- Retrieve a list of publishers and the total number of authors they have worked with, sorted by the number of authors in descending order.
SELECT P.Name AS PublisherName, COUNT(DISTINCT A.AuthorID) AS NumberOfAuthors
FROM Publishers P
JOIN Books B ON P.PublisherID = B.PublisherID
JOIN Authors A ON B.AuthorID = A.AuthorID
GROUP BY P.Name
ORDER BY NumberOfAuthors DESC;

-- Retrieve the total sales value for each customer, grouped by customer and sorted by total sales in ascending order.
SELECT C.FirstName, C.LastName, SUM(O.Quantity * B.Price) AS TotalSales
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN Books B ON O.BookID = B.BookID
GROUP BY C.FirstName, C.LastName
ORDER BY TotalSales ASC;

-- Retrieve the number of distinct publishers each author has worked with, grouped by author and sorted by the number of publishers in descending order.
SELECT A.FirstName, A.LastName, COUNT(DISTINCT P.PublisherID) AS NumberOfPublishers
FROM Authors A
JOIN Books B ON A.AuthorID = B.AuthorID
JOIN Publishers P ON B.PublisherID = P.PublisherID
GROUP BY A.FirstName, A.LastName
ORDER BY NumberOfPublishers DESC;

-- Retrieve the total sales value for each genre, grouped by genre and sorted by total sales in ascending order.
SELECT B.Genre, SUM(O.Quantity * B.Price) AS TotalSales
FROM Books B
JOIN Orders O ON B.BookID = O.BookID
GROUP BY B.Genre
ORDER BY TotalSales ASC;

-- Retrieve the number of distinct genres for which each author has written, grouped by author and sorted by the number of genres in descending order.
SELECT A.FirstName, A.LastName, COUNT(DISTINCT B.Genre) AS NumberOfGenres
FROM Authors A
JOIN Books B ON A.AuthorID = B.AuthorID
GROUP BY A.FirstName, A.LastName
ORDER BY NumberOfGenres DESC;
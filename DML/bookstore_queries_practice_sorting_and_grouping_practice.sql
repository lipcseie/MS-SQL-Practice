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

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

-- Retrieve the total sales (quantity * price) for each book genre.

-- Retrieve the number of books ordered on each date, grouped by order date.

-- Retrieve a list of publishers with the names of authors who have books published by each publisher.
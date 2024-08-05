-- Retrieve all books: Write a query to retrieve all the books from the Books table.
USE BookStore;

SELECT * FROM dbo.Books;

-- Count of books by genre: Write a query to count the number of books in each genre.

SELECT Genre, COUNT(*) as NumberOfBooks
	FROM Books
	GROUP BY Genre;

-- Authors with most books: Write a query to find the author who has written the most books.
SELECT TOP 1 A.FirstName, A.LastName, COUNT(*) as NumberOfBooks
	FROM Books B
	JOIN Authors A ON B.AuthorID = A.AuthorID
	GROUP BY A.FirstName, A.LastName
	ORDER BY NumberOfBooks DESC;

-- Average book price: Write a query to calculate the average price of all the books.
SELECT AVG(Price) as Average_Price_Of_All_Books
FROM Books;

-- Books published in a specific year: Write a query to find all the books published in the year 2024.
SELECT * FROM Books
	WHERE PublicationYear = 2024;

-- Customers who made orders: Write a query to find all customers who have made at least one order.
SELECT C.FirstName, C.LastName
	FROM Customers C
	JOIN Orders O ON C.CustomerID = O.CustomerID
	GROUP BY C.FirstName, C.LastName;

-- Total orders for a specific book: Write a query to find the total number of orders for ‘The Sorcerer’s Stone’.
SELECT B.Title, SUM(O.Quantity) as TotalQuantity
	FROM Books B
	JOIN Orders O ON B.BookID = O.BookID
	WHERE B.Title = 'The Sorcerer’s Stone'
	GROUP BY B.Title;

-- Most popular book: Write a query to find the book with the highest number of orders.
SELECT TOP 1 B.Title, MAX(O.Quantity) as HighestOrders
	FROM Books B
	JOIN Orders O ON B.BookID = O.BookID
	GROUP BY B.Title
	ORDER BY HighestOrders DESC;
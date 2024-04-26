USE BookStore;

-- Joining tables: Write a query to join the Books and Authors tables and select the title of the book along with the name of the author.
SELECT A.FirstName, A.LastName, B.Title
	FROM Books B
	JOIN Authors A ON B.AuthorID = A.AuthorID;

-- Books by Specific Author: Write a query to find all the books written by an author with the AuthorID of 5.
SELECT A.FirstName, A.LastName, B.Title
	FROM Books B
	JOIN Authors A ON B.AuthorID = A.AuthorID
	WHERE A.AuthorID = 5;

-- Orders in a Date Range: Write a query to find all orders placed between January 1, 2024, and December 31, 2024.
SELECT C.FirstName, C.LastName, O.OrderDate
	FROM Customers C
	JOIN Orders O ON C.CustomerID = O.CustomerID
	WHERE O.OrderDate BETWEEN '2024-01-01' AND '2024-12-12';

-- Customers with Multiple Orders: Write a query to find customers who have placed more than 2 orders.
SELECT C.FirstName, C.LastName, O.Quantity as Number_Of_Books
	FROM Customers C
	JOIN Orders O ON C.CustomerID = O.CustomerID
	WHERE O.Quantity >= 2;

-- Latest Published Books: Write a query to find the 5 most recently published books.
SELECT TOP 5 Title, PublicationYear as Latest_Pubished_Books
	FROM Books
	ORDER BY PublicationYear DESC;

-- Joining Multiple Tables: Write a query to join the Books, Authors, and Publishers tables and select the title of the book, the name of the author, and the name of the publisher.
SELECT B.Title, A.FirstName, A.LastName, P.Name as Publisher_Name
	FROM Books B
	JOIN Authors A ON B.AuthorID = A.AuthorID
	JOIN Publishers P ON B.PublisherID = P.PublisherID;
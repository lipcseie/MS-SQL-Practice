USE BookStore

-- Find books with a price higher than the average price of all books.
SELECT * FROM Books
WHERE price > (SELECT AVG(price) FROM Books);

-- Retrieve book titles with a price less than the highest price of books in the "Fantasy" genre.
SELECT Title FROM Books
WHERE price < (SELECT MAX(price) FROM Books WHERE genre = 'Fantasy');

-- Get titles of books published in the same year as "The Two Towers".
SELECT Title FROM Books
WHERE PublicationYear = (SELECT PublicationYear FROM Books WHERE Title = 'The Two Towers');

-- Identify author IDs who have written more than one book.
SELECT DISTINCT AuthorID FROM Books
WHERE AuthorID IN(
	SELECT AuthorID
	FROM Books
	GROUP BY AuthorID
	HAVING COUNT(BookID) > 1
	);

-- Retrieve details of the least expensive book within each genre.
SELECT * FROM Books
WHERE Price IN(
	SELECT MIN(price) FROM Books
	GROUP BY Genre
	);

-- Find books priced higher than the least expensive book.
SELECT Title FROM Books
WHERE Price > (
	SELECT MIN(price) FROM Books);


-- Identify the genre with the highest average book price and list book titles from that genre.
SELECT Title FROM Books
WHERE Genre = (
	SELECT TOP 1 Genre
	FROM Books
	GROUP BY Genre
	ORDER BY AVG(Price) DESC
	);

-- List books with prices equal to the average price of "Epic" genre books.
SELECT Title FROM Books
WHERE Price = (
	SELECT AVG(Price) 
	FROM Books
	WHERE Genre = 'Epic'
	);

-- Retrieve the names of publishers who are associated with books from more than one genre.
SELECT Name AS PublisherName
FROM Publishers
WHERE PublisherID IN (
    SELECT PublisherID
    FROM Books
    GROUP BY PublisherID
    HAVING COUNT(DISTINCT Genre) > 1
	);

-- Retrieve the title and price of the most expensive book published by each publisher..
SELECT B.Title, B.Price
FROM Books B
JOIN Publishers P ON B.PublisherID = P.PublisherID
WHERE B.Price = (
    SELECT MAX(B2.Price)
    FROM Books B2
    WHERE B2.PublisherID = B.PublisherID
	);

-- Write a query to retrieve the names of authors who have published the most expensive book within their respective genres.
SELECT A.FirstName, A.LastName, B.Genre, B.Title, B.Price
FROM Books B
JOIN Authors A ON B.AuthorID = A.AuthorID
WHERE B.Price = (
    SELECT MAX(B2.Price)
    FROM Books B2
    WHERE B2.Genre = B.Genre
);

-- Write a query to find the names of publishers who have published books in the same genre as the book titled "The Sorcerer’s Stone".
SELECT P.Name, B.Genre 
FROM Publishers P
JOIN Books B ON P.PublisherID = B.PublisherID
WHERE B.Genre = (
	SELECT B2.Genre
	FROM Books B2
	WHERE B2.Title = 'The Sorcerer’s Stone'
	);

-- Write a query to list the names of customers who have placed orders for books written by the same author.
SELECT C.FirstName AS CustomerFirstName, C.LastName AS CustomerLastName
FROM Customers C
WHERE C.CustomerID IN (
    SELECT O.CustomerID
    FROM Orders O
    JOIN Books B ON O.BookID = B.BookID
    GROUP BY O.CustomerID
    HAVING COUNT(DISTINCT B.AuthorID) = 1
);

-- Write a query to retrieve titles of books that are priced lower than the average price of all books written by the same author
SELECT B.Title, B.Price, A.FirstName, A.LastName
FROM Books B
JOIN Authors A ON B.AuthorID = A.AuthorID
WHERE B.Price < (
    SELECT AVG(B2.Price)
    FROM Books B2
    WHERE B2.AuthorID = B.AuthorID
);

-- Write a query to find the names of authors who have not published any books after the year 2020.
SELECT A.FirstName, A.LastName
FROM Authors A
WHERE A.AuthorID NOT IN (
    SELECT B.AuthorID
    FROM Books B
    WHERE B.PublicationYear > 2020
);

-- Write a query to list the titles of books written by authors who were born before the year 1980.
SELECT B.Title, A.FirstName AS AuthorFirstName, A.LastName AS AuthorLastName
FROM Books B
JOIN Authors A ON B.AuthorID = A.AuthorID
WHERE A.AuthorID IN (
    SELECT AuthorID
    FROM Authors
    WHERE DateOfBirth IS NOT NULL AND DateOfBirth < '1980-01-01'
);

SELECT B.Title, A.FirstName AS AuthorFirstName, A.LastName AS AuthorLastName
FROM Books B
JOIN Authors A ON B.AuthorID = A.AuthorID
WHERE A.DateOfBirth < '1980-01-01';

-- Write a query to find the first and last names of customers who have ordered more than 2 books
SELECT C.FirstName AS CustumerFirstName, C.LastName AS CustomerLastName, O.Quantity
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.Quantity > 2;

SELECT C.FirstName AS CustomerFirstName, C.LastName AS CustomerLastName
FROM Customers C
WHERE C.CustomerID IN (
    SELECT O.CustomerID
    FROM Orders O
    GROUP BY O.CustomerID
    HAVING SUM(O.Quantity) > 2
);

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


-- Write a query to list the titles of books that are priced higher than the average price of all books in the "Dystopian" genre.
SELECT Title, Genre
FROM Books
WHERE Price > (
	SELECT AVG(Price)
	FROM Books
	WHERE Genre = 'Dystopian'
	);

-- Write a query to retrieve the names of publishers who have published at least 3 different books.
SELECT Name
FROM Publishers
WHERE PublisherID IN (
    SELECT PublisherID
    FROM Books
    GROUP BY PublisherID
    HAVING COUNT(BookID) >= 3
);

-- Write a query to retrieve the name and website of publishers who have published a book with the title "Peter Pan".
SELECT P.Name, P.Website
FROM Publishers P
WHERE P.PublisherID IN (
    SELECT B.PublisherID
    FROM Books B
    WHERE B.Title = 'Peter Pan'
);

-- Write a query to find the first and last names of authors who have not written any books in the "Fantasy" genre.
SELECT A.FirstName, A.LastName
FROM Authors A
WHERE A.AuthorID NOT IN (
    SELECT B.AuthorID
    FROM Books B
    WHERE B.Genre = 'Fantasy'
);

-- Write a query to find the name of the publisher with the highest number of published books.
SELECT P.Name
FROM Publishers P
WHERE P.PublisherID = (
    SELECT TOP 1 B.PublisherID
    FROM Books B
    GROUP BY B.PublisherID
    ORDER BY COUNT(B.BookID) DESC
);

-- Write a query to list the titles of books that were published after the most recent book written by Frodo Baggins
SELECT Title
FROM Books
WHERE PublicationYear > (
    SELECT MAX(B.PublicationYear)
    FROM Books B
    JOIN Authors A ON B.AuthorID = A.AuthorID
    WHERE A.FirstName = 'Frodo' AND A.LastName = 'Baggins'
);

-- Find customers who have placed an order for a book with the title "1984".
SELECT C.FirstName, C.LastName 
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN Books B ON O.BookID = B.BookID
WHERE B.BookID IN (
    SELECT B2.BookID
    FROM Books B2
    WHERE B2.Title = '1984'
);

-- Retrieve the titles of books written by the author with the most published books.
SELECT Title
FROM Books
WHERE AuthorID = (
    SELECT TOP 1 AuthorID
    FROM Books
    GROUP BY AuthorID
    ORDER BY COUNT(BookID) DESC
);

-- List the names of authors who have never written a book in the "Science Fiction" genre.
SELECT A.FirstName, A.LastName
FROM Authors A
WHERE A.AuthorID NOT IN (
    SELECT B.AuthorID
    FROM Books B
    WHERE B.Genre = 'Science Fiction'
);

-- Find the titles of books that are priced lower than the least expensive book published by "Hogwarts Press".
SELECT B.Title
FROM Books B
JOIN Publishers P ON B.PublisherID = P.PublisherID
WHERE B.Price < (
    SELECT MIN(B2.Price)
    FROM Books B2
    JOIN Publishers P2 ON P2.PublisherID = P2.PublisherID
    WHERE P2.Name = 'Hogwarts Press'
);

-- Get the names of customers who have ordered more books than the customer named "Tony Stark".
SELECT C.FirstName, C.LastName
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName, C.LastName
HAVING COUNT(O.BookID) > (
    SELECT COUNT(O2.BookID)
    FROM Customers C2
    JOIN Orders O2 ON C2.CustomerID = O2.CustomerID
    WHERE C2.FirstName = 'Tony' AND
		  C2.LastName = 'Stark'
);

-- Retrieve the genres of books that have an average price lower than the overall average price of all books.
SELECT Genre
FROM Books
GROUP BY Genre
HAVING AVG(Price) < (
    SELECT AVG(Price)
    FROM Books
);

-- List the titles of books written by authors who have written books in more than one genre.
SELECT Title
FROM Books
WHERE AuthorID IN (
    SELECT AuthorID
    FROM Books
    GROUP BY AuthorID
    HAVING COUNT(DISTINCT Genre) > 1
);

-- Find the names of authors who have written the least expensive book in the "Fantasy" genre.
SELECT FirstName, Lastname
FROM Authors A
JOIN Books B ON A.AuthorID = B.AuthorID
WHERE B.Genre = 'Fantasy'
AND B.Price = (
    SELECT MIN(Price)
    FROM Books
    WHERE Genre = 'Fantasy'
);

-- Get the titles of books that were published before the earliest book written by "Katniss Everdeen".
SELECT Title
FROM Books
WHERE PublicationYear < (
    SELECT MIN(PublicationYear)
    FROM Books
    WHERE AuthorID = (
        SELECT AuthorID
        FROM Authors
        WHERE FirstName = 'Katniss' AND
			LastName = 'Everdeen'
    )
);

-- Retrieve the names of publishers who have published books more recently than the publisher "Shire Scrolls".
-- with JOIN
SELECT P.Name AS PublisherName
FROM Publishers P
JOIN Books B ON P.PublisherID = B.PublisherID
GROUP BY P.Name
HAVING MAX(B.PublicationYear) > (
    SELECT MAX(B2.PublicationYear)
    FROM Books B2
    JOIN Publishers P2 ON B2.PublisherID = P2.PublisherID
    WHERE P2.Name = 'Shire Scrolls'
);

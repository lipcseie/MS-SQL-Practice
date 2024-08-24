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
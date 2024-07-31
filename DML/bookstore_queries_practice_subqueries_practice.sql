USE BookStore
-- Find books with a price higher than the average price of all books.
SELECT * FROM Books
WHERE price > (SELECT AVG(price) FROM Books);

-- Retrieve book titles with a price less than the highest price of books in the "Fantasy" genre.
SELECT Title FROM Books
WHERE price < (SELECT MAX(price) FROM Books WHERE genre = 'Fantasy');
-- Get titles of books published in the same year as "The Two Towers".


-- Identify author IDs who have written more than one book.


-- Retrieve details of the least expensive book within each genre.


-- Find books priced higher than the least expensive book.


-- Identify the genre with the highest average book price and list book titles from that genre.


-- List books with prices equal to the average price of "Epic" genre books.


-- Find the highest-priced book(s) and list titles of books with prices greater than this highest price.

-- Determine the publisher ID with the most books published and list all book titles from that publisher.

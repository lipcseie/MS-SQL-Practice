USE BookStore;

-- 1. List all books along with their authors' names and publication years.
SELECT B.Title, B.PublicationYear, A.FirstName, A.LastName
FROM Books B
JOIN Authors A ON B.AuthorID = A.AuthorID;

-- 2. Find all orders placed by customers, including the customer's full name, the book title, and the quantity ordered.
SELECT C.FirstName AS CustomerFirstName, C.LastName AS CustomerLastName, 
B.Title, O.Quantity
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN  Books B ON O.BookID = B.BookID

-- 3. Retrieve a list of all books along with their publishers' names and addresses.
SELECT B.Title AS BookTitle, P.Name AS PublisherName, P.Address AS PublisherAdress
FROM Books B
JOIN Publishers P ON B.PublisherID = P.PublisherID;

-- 4. Show the total quantity ordered for each book, including the book title and the total quantity ordered.
SELECT B.Title, SUM(O.Quantity) AS TotalQuantityOrder
FROM Books B
LEFT JOIN Orders O ON B.BookID = O.BookID
GROUP BY B.Title;

-- 5. Get a list of authors who have written books published by 'Hogwarts Press'. Include the authorís first and last name, and the book titles.
SELECT A.FirstName AS AuthorFirstName, A.LastName AS AuthorLastName, B.Title
FROM Authors A
JOIN Books B ON A.AuthorID = B.AuthorID
JOIN Publishers P ON B.PublisherID = P.PublisherID
WHERE Name = 'Hogwarts Press';

-- 6. Find all books ordered by 'Bruce Wayne', including the book title, the quantity ordered, and the publication year.
SELECT B.Title, B.PublicationYear,  O.Quantity as QuantityOrderd
FROM Books B
JOIN Orders O ON B.BookID = O.BookID
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE C.FirstName = 'Bruce' AND
C.LastName = 'Wayne';

-- 7. List all customers who have ordered books published by 'Valyrian Books'. Include the customerís full name and email.
SELECT C.FirstName AS CustomerFirstName, 
	   C.LastName AS CustomerLastName, 
	   C.Email
FROM Customers C 
	JOIN Orders O ON C.CustomerID = O.CustomerID
	JOIN Books B ON B.BookID = B.BookID
	JOIN Publishers P ON B.PublisherID = P.PublisherID
WHERE 
	P.Name = 'Valyrian Books';

-- 8. List all authors who share the same last name. Show their full names and the full names of their colleagues with the same last name.
SELECT A.FirstName AS FisrtName1, A.LastName AS LastName1, 
	   B.FirstName AS FirstName2, B.LastName AS LastName2
FROM Authors A
JOIN Authors B ON A.LastName = B.LastName AND
A.AuthorID != B.AuthorID;

-- 9. Show the most recent book orders including the customer's name, book title, order date, and quantity.
SELECT C.FirstName, C.LastName, B.Title, O.OrderDate, O.Quantity
From Customers C
JOIN Orders O ON C.CustomerID = O.OrderID
JOIN Books B ON O.BookID = B.BookID
ORDER BY OrderDate DESC;

-- Find all books and their authors where the author's last name starts with 'S'.
SELECT B.Title, A.LastName 
FROM Books B
JOIN Authors A ON B.AuthorID = A.AuthorID
WHERE A.LastName LIKE 'S%';

-- List all publishers and the count of books they have published, including publishers with no books.
SELECT COUNT(B.BookID) AS BooksTheyPublished, P.Name
FROM Books B
LEFT JOIN Publishers P ON B.PublisherID = P.PublisherID
GROUP BY P.PublisherID,P.Name;

-- Retrieve the details of all orders along with the book titles and customer names.
SELECT O.OrderID, O.Quantity, O.OrderDate, B.Title AS BookTitle, C.FirstName AS CustomerFirstName, C.LastName AS CustomerLastName
FROM Orders O
JOIN Books B ON O.BookID = B.BookID
JOIN Customers C ON O.CustomerID = C.CustomerID;

-- Get a list of all customers who have ordered books in the year 2023. Include their full names and the titles of the books they ordered.
SELECT C.FirstName AS CustomerFirstName, C.LastName AS CustomerLastName, O.OrderDate, B.Title
FROM Customers C
JOIN Orders O ON C.CustomerID = O.OrderID
JOIN Books B ON O.BookID = B.BookID
WHERE YEAR(O.OrderDate) = 2023;

-- Find all books with their corresponding publisher names and prices that are above $20.
SELECT P.Name AS PublisherName, B.Title AS BookTitle, B.Price
FROM Publishers P
JOIN Books B ON P.PublisherID = B.PublisherID
WHERE B.Price > 20;

-- List all authors who have written more than 2 books and include their full names and the number of books they have written.
SELECT A.FirstName AS AuthorFirstName,A.LastName AS AuthorLastName, COUNT(B.BookID) AS BooksWritten
FROM Authors A
JOIN Books B ON A.AuthorID = B.AuthorID
GROUP BY A.FirstName, A.LastName
HAVING COUNT(B.BookID) > 2;

-- Show the total revenue generated from orders for each book. Include the book title and total revenue in the results.
SELECT B.Title AS BookTitle, 
	   SUM(B.Price * O.Quantity) AS TotalRevenue
FROM Books B
JOIN Orders O ON B.BookID = O.BookID
GROUP BY B.Title;

-- Find the oldest book (earliest publication year) and its author.
SELECT TOP 1 b.Title,
	   B.PublicationYear,
	   A.FirstName AS AuthorFirstName,
	   A.LastName AS AuthorLastName
FROM Books B
JOIN Authors A ON B.AuthorID = A.AuthorID
ORDER BY B.PublicationYear ASC;

-- List all customers who have ordered more than2 books in total, showing their full names and the total number of books ordered.
SELECT C.FirstName AS CustomerFirstName,
	   C.LastName AS CustomerLastName,
	   SUM(O.Quantity) AS TotalNumberOdBooksOrderd
FROm Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName, C.LastName
HAVING SUM(O.Quantity) > 2;

-- Retrieve a list of books and their genres where the genre is not 'Science Fiction' and display the title, genre, and the author's last name.
SELECT B.Title AS BookTitle,
	   B.Genre,
	   A.LastName
FROM Books B
JOIN Authors A ON B.AuthorID = A.AuthorID
WHERE B.Genre != 'Science Fiction';

-- Retrieve the total number of books sold by each author, grouped by author and sorted by the total number of books sold in descending order.
SELECT A.FirstName, A.LastName, SUM(O.Quantity) AS TotalBooksSold
FROM Authors A
JOIN Books B ON A.AuthorID = B.AuthorID
JOIN Orders O ON B.BookID = O.BookID
GROUP BY A.FirstName, A.LastName
ORDER BY TotalBooksSold DESC;

-- Retrieve the number of customers who have placed more than one order, grouped by customer.
SELECT C.FirstName, C.LastName, COUNT(O.OrderID) AS NumberOfOrders
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName
HAVING COUNT(O.OrderID) > 1;

-- Retrieve the number of orders placed for each publisher, grouped by publisher and sorted by the number of orders in descending order.
SELECT P.Name AS PublisherName, COUNT(O.OrderID) AS NumberOfOrders
FROM Publishers P
JOIN Books B ON P.PublisherID = B.PublisherID
JOIN Orders O ON B.BookID = O.BookID
GROUP BY P.Name
ORDER BY NumberOfOrders DESC;

-- Retrieve the most recent book published by each author, grouped by author and sorted by the publication year in descending order.
SELECT A.FirstName, A.LastName, MAX(B.PublicationYear) AS MostRecentBook
FROM Authors A
JOIN Books B ON A.AuthorID = B.AuthorID
GROUP BY A.FirstName, A.LastName
ORDER BY MostRecentBook DESC;

-- Retrieve the total quantity of books ordered per order, grouped by order and sorted by the total quantity in descending order.
SELECT O.OrderID, SUM(O.Quantity) AS TotalQuantity
FROM Orders O
GROUP BY O.OrderID
ORDER BY TotalQuantity DESC;

-- Retrieve the average price of books sold by each publisher, grouped by publisher and sorted by the average price in ascending order.
SELECT P.Name AS PublisherName, AVG(B.Price) AS AveragePrice
FROM Publishers P
JOIN Books B ON P.PublisherID = B.PublisherID
GROUP BY P.Name
ORDER BY AveragePrice ASC;

-- Retrieve a list of customers who have spent more than the average total spending of all customers, sorted by their total spending.
SELECT C.FirstName, C.LastName, SUM(O.Quantity * B.Price) AS TotalSpent
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN Books B ON O.BookID = B.BookID
GROUP BY C.FirstName, C.LastName
HAVING SUM(O.Quantity * B.Price) > (SELECT AVG(O.Quantity * B.Price) FROM Orders O JOIN Books B ON O.BookID = B.BookID)
ORDER BY TotalSpent DESC;

-- Retrieve the titles of books that have never been ordered, grouped by book title and sorted alphabetically.
SELECT B.Title
FROM Books B
LEFT JOIN Orders O ON B.BookID = O.BookID
WHERE O.OrderID IS NULL
ORDER BY B.Title ASC;

-- Retrieve the number of distinct genres for which each author has written, grouped by author and sorted by the number of genres in descending order.
SELECT A.FirstName, A.LastName, COUNT(DISTINCT B.Genre) AS NumberOfGenres
FROM Authors A
JOIN Books B ON A.AuthorID = B.AuthorID
GROUP BY A.FirstName, A.LastName
ORDER BY NumberOfGenres DESC;

-- Retrieve the names of customers who have ordered books from more than three different genres, grouped by customer name and sorted by their first name.
SELECT C.FirstName, C.LastName, COUNT(DISTINCT B.Genre) AS NumberOfGenres
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN Books B ON O.BookID = B.BookID
GROUP BY C.FirstName, C.LastName
HAVING COUNT(DISTINCT B.Genre) > 3
ORDER BY C.FirstName ASC;

-- Retrieve the total number of books each author has written, sorted by author name in ascending order.
SELECT A.FirstName, A.LastName, COUNT(B.BookID) AS NumberOfBooks
FROM Authors A
JOIN Books B ON A.AuthorID = B.AuthorID
GROUP BY A.FirstName, A.LastName
ORDER BY A.LastName ASC, A.FirstName ASC;

-- Retrieve the number of books published by each publisher in each year, grouped by publisher and publication year, and sorted by the publisher's name and year.
SELECT P.Name AS PublisherName, B.PublicationYear, COUNT(B.BookID) AS BooksPublished
FROM Publishers P
JOIN Books B ON P.PublisherID = B.PublisherID
GROUP BY P.Name, B.PublicationYear
ORDER BY P.Name ASC, B.PublicationYear ASC;

-- Retrieve a list of customers who have placed more than 5 orders, grouped by customer and sorted by the number of orders in descending order.
SELECT C.FirstName, C.LastName, COUNT(O.OrderID) AS NumberOfOrders
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName, C.LastName
HAVING COUNT(O.OrderID) > 5
ORDER BY NumberOfOrders DESC;

-- Retrieve the total number of distinct genres each publisher has published, sorted by publisher name in ascending order.
SELECT P.Name AS PublisherName, COUNT(DISTINCT B.Genre) AS NumberOfGenres
FROM Publishers P
JOIN Books B ON P.PublisherID = B.PublisherID
GROUP BY P.Name
ORDER BY P.Name ASC;

-- Retrieve a list of books published after the year 2000, sorted by the number of orders they have received in descending order.
SELECT B.Title, B.PublicationYear, COUNT(O.OrderID) AS NumberOfOrders
FROM Books B
JOIN Orders O ON B.BookID = O.BookID
WHERE B.PublicationYear > 2000
GROUP BY B.Title, B.PublicationYear
ORDER BY NumberOfOrders DESC;


-- Retrieve the names of publishers who have published more than 10 books, sorted by the number of books in descending order.
SELECT P.Name AS PublisherName, COUNT(B.BookID) AS NumberOfBooksPublished
FROM Publishers P
JOIN Books B ON P.PublisherID = B.PublisherID
GROUP BY P.Name
HAVING COUNT(B.BookID) > 10
ORDER BY NumberOfBooksPublished DESC;

-- Retrieve the titles of books that have been ordered more than 50 times, sorted by the number of orders in ascending order.
SELECT B.Title, COUNT(O.OrderID) AS NumberOfOrders
FROM Books B
JOIN Orders O ON B.BookID = O.BookID
GROUP BY B.Title
HAVING COUNT(O.OrderID) > 50
ORDER BY NumberOfOrders ASC;

-- Retrieve the names of authors who have written books in more than 3 different genres, sorted by the number of genres in descending order.
SELECT A.FirstName, A.LastName, COUNT(DISTINCT B.Genre) AS NumberOfGenres
FROM Authors A
JOIN Books B ON A.AuthorID = B.AuthorID
GROUP BY A.FirstName, A.LastName
HAVING COUNT(DISTINCT B.Genre) > 3
ORDER BY NumberOfGenres DESC;

-- Retrieve the total revenue generated by each publisher, sorted by revenue in descending order.
SELECT P.Name AS PublisherName, SUM(B.Price * O.Quantity) AS TotalRevenue
FROM Publishers P
JOIN Books B ON P.PublisherID = B.PublisherID
JOIN Orders O ON B.BookID = O.BookID
GROUP BY P.Name
ORDER BY TotalRevenue DESC;

-- Retrieve a list of authors who have collaborated with multiple publishers, sorted by the number of publishers in descending order.
SELECT A.FirstName, A.LastName, COUNT(DISTINCT P.PublisherID) AS NumberOfPublishers
FROM Authors A
JOIN Books B ON A.AuthorID = B.AuthorID
JOIN Publishers P ON B.PublisherID = P.PublisherID
GROUP BY A.FirstName, A.LastName
HAVING COUNT(DISTINCT P.PublisherID) > 1
ORDER BY NumberOfPublishers DESC;

-- Retrieve the average price of books for each publication year, sorted by publication year in ascending order.
SELECT B.PublicationYear, AVG(B.Price) AS AveragePrice
FROM Books B
GROUP BY B.PublicationYear
ORDER BY B.PublicationYear ASC;

-- Retrieve the titles of books and the number of times they have been ordered in each genre, grouped by genre and sorted by order count in descending order.
SELECT B.Genre, B.Title, COUNT(O.OrderID) AS OrderCount
FROM Books B
JOIN Orders O ON B.BookID = O.BookID
GROUP BY B.Genre, B.Title
ORDER BY B.Genre ASC, OrderCount DESC;

-- Retrieve the names of customers who have ordered books in every genre available, sorted by last name.
SELECT C.FirstName, C.LastName
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN Books B ON O.BookID = B.BookID
GROUP BY C.CustomerID, C.FirstName, C.LastName
HAVING COUNT(DISTINCT B.Genre) = (SELECT COUNT(DISTINCT Genre) FROM Books)
ORDER BY C.LastName ASC, C.FirstName ASC;

-- Retrieve the total quantity of books ordered by each customer for each genre, sorted by genre and then by quantity in descending order.
SELECT C.FirstName, C.LastName, B.Genre, SUM(O.Quantity) AS TotalQuantity
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN Books B ON O.BookID = B.BookID
GROUP BY C.FirstName, C.LastName, B.Genre
ORDER BY B.Genre ASC, TotalQuantity DESC;


-- Retrieve the list of customers who have ordered the same book more than once, sorted by customer name.
SELECT C.FirstName, C.LastName, B.Title, COUNT(O.OrderID) AS OrderCount
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN Books B ON O.BookID = B.BookID
GROUP BY C.FirstName, C.LastName, B.Title
HAVING COUNT(O.OrderID) > 1
ORDER BY C.LastName ASC, C.FirstName ASC;

-- Retrieve the list of books that have never been ordered, sorted alphabetically by title.
SELECT B.Title
FROM Books B
LEFT JOIN Orders O ON B.BookID = O.BookID
WHERE O.OrderID IS NULL
ORDER BY B.Title ASC;

-- Retrieve the total number of books ordered by each customer, grouped by customer, and sorted by the total number of books in descending order.
SELECT C.FirstName, C.LastName, SUM(O.Quantity) AS TotalBooksOrdered
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName, C.LastName
ORDER BY TotalBooksOrdered DESC;

-- Retrieve the authors who have written books in the highest number of genres, sorted by the number of genres in descending order.
SELECT A.FirstName, A.LastName, COUNT(DISTINCT B.Genre) AS NumberOfGenres
FROM Authors A
JOIN Books B ON A.AuthorID = B.AuthorID
GROUP BY A.FirstName, A.LastName
ORDER BY NumberOfGenres DESC;

-- Retrieve the most expensive book in each genre, showing the genre, title, and price.
SELECT B.Genre, B.Title, B.Price
FROM Books B
JOIN (
    SELECT Genre, MAX(Price) AS MaxPrice
    FROM Books
    GROUP BY Genre
     ) 
AS MaxPriceBooks ON B.Genre = MaxPriceBooks.Genre AND B.Price = MaxPriceBooks.MaxPrice;

-- Retrieve a list of customers who have ordered books worth more than a specific total value (e.g., $500), sorted by total spending.
SELECT C.FirstName, C.LastName, SUM(O.Quantity * B.Price) AS TotalSpent
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN Books B ON O.BookID = B.BookID
GROUP BY C.FirstName, C.LastName
HAVING SUM(O.Quantity * B.Price) > 500
ORDER BY TotalSpent DESC;

-- Retrieve the number of books ordered by each publisher, grouped by publisher, and sorted by the total number of books ordered in descending order.
SELECT P.Name AS PublisherName, SUM(O.Quantity) AS TotalBooksOrdered
FROM Publishers P
JOIN Books B ON P.PublisherID = B.PublisherID
JOIN Orders O ON B.BookID = O.BookID
GROUP BY P.Name
ORDER BY TotalBooksOrdered DESC;

-- Retrieve the average price of books written by each author, grouped by author, and sorted by average price in descending order.
SELECT A.FirstName, A.LastName, AVG(B.Price) AS AverageBookPrice
FROM Authors A
JOIN Books B ON A.AuthorID = B.AuthorID
GROUP BY A.FirstName, A.LastName
ORDER BY AverageBookPrice DESC;

-- Retrieve the total revenue generated by each publisher, grouped by publisher, and sorted by total revenue in descending order.
SELECT P.Name AS PublisherName, SUM(O.Quantity * B.Price) AS TotalRevenue
FROM Publishers P
JOIN Books B ON P.PublisherID = B.PublisherID
JOIN Orders O ON B.BookID = O.BookID
GROUP BY P.Name
ORDER BY TotalRevenue DESC;

-- Retrieve a list of genres where the average book price is higher than the overall average price of all books.
SELECT B.Genre, AVG(B.Price) AS AverageGenrePrice
FROM Books B
GROUP BY B.Genre
HAVING AVG(B.Price) > (SELECT AVG(Price) FROM Books)
ORDER BY AverageGenrePrice DESC;

-- Retrieve the names of customers who have never placed an order.
SELECT C.FirstName, C.LastName
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.OrderID IS NULL;

-- Retrieve the list of books that have never been ordered, sorted by title.
SELECT Title
FROM Books B
LEFT JOIN Orders O ON B.BookID = O.BookID
WHERE O.OrderID IS NULL
ORDER BY B.Title;

SELECT A.FirstName, A.LastName, COUNT(DISTINCT B.Genre) AS NumberOfGenres
FROM Authors A
JOIN Books B ON A.AuthorID = B.AuthorID
GROUP BY A.AuthorID, A.FirstName, A.LastName
HAVING COUNT(DISTINCT B.Genre) > 1
ORDER BY NumberOfGenres DESC;

-- Retrieve a list of customers along with the date of their first order.
SELECT C.FirstName, C.LastName, MIN(O.OrderDate) AS FirstOrderDate
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName
ORDER BY FirstOrderDate ASC;

-- Retrieve the names of authors who have written books in multiple genres, sorted by the number of genres.
SELECT A.FirstName, A.LastName, COUNT(DISTINCT B.Genre) AS NumberOfGenres
FROM Authors A
JOIN Books B ON A.AuthorID = B.AuthorID
GROUP BY A.AuthorID, A.FirstName, A.LastName
HAVING COUNT(DISTINCT B.Genre) > 1
ORDER BY NumberOfGenres DESC;


-- Retrieve the list of customers who have placed orders every month in the current year.
SELECT C.FirstName, C.LastName
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE YEAR(O.OrderDate) = YEAR(GETDATE()) 
GROUP BY C.CustomerID, C.FirstName, C.LastName
HAVING COUNT(DISTINCT MONTH(O.OrderDate)) = 12;

-- Retrieve the total revenue generated by each month of the current year, sorted by month.
SELECT MONTH(O.OrderDate) AS Month, SUM(O.Quantity * B.Price) AS MonthlyRevenue
FROM Orders O
JOIN Books B ON O.BookID = B.BookID
WHERE YEAR(O.OrderDate) = YEAR(GETDATE())
GROUP BY MONTH(O.OrderDate)
ORDER BY Month ASC;

-- Retrieve the list of books that have been ordered by at least 10 different customers.
SELECT B.Title, COUNT(DISTINCT O.CustomerID) AS UniqueCustomers
FROM Books B
JOIN Orders O ON B.BookID = O.BookID
GROUP BY B.BookID, B.Title  
HAVING COUNT(DISTINCT O.CustomerID) >= 10
ORDER BY UniqueCustomers DESC;

-- Retrieve the top 5 most expensive books along with their authors and publishers.
SELECT TOP 5 B.Title, B.Price, A.FirstName AS AuthorFirstName, A.LastName AS AuthorLastName, P.Name AS PublisherName
FROM Books B
JOIN Authors A ON B.AuthorID = A.AuthorID
JOIN Publishers P ON B.PublisherID = P.PublisherID
ORDER BY B.Price DESC;

-- Retrieve a list of genres along with the average book price and the total number of books in each genre, sorted by average price in descending order.
SELECT B.Genre, AVG(B.Price) AS AveragePrice, COUNT(B.BookID) AS TotalBooks
FROM Books B
GROUP BY B.Genre
ORDER BY AveragePrice DESC;

-- Retrieve the top 5 customers who have spent the most on orders, along with the total amount they spent.
SELECT TOP 5 
    C.FirstName, 
    C.LastName, 
    SUM(O.Quantity * B.Price) AS TotalSpent
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN Books B ON O.BookID = B.BookID
GROUP BY C.CustomerID, C.FirstName, C.LastName
ORDER BY TotalSpent DESC;

-- Retrieve the average price of books for each publisher, only including publishers with at least 5 books published, sorted by average price in descending order.
SELECT 
    P.Name AS PublisherName, 
    AVG(B.Price) AS AverageBookPrice
FROM Publishers P
JOIN Books B ON P.PublisherID = B.PublisherID
GROUP BY P.Name
HAVING COUNT(B.BookID) >= 5
ORDER BY AverageBookPrice DESC;

-- Retrieve the list of customers who have ordered the same book more than once, along with the book title and the total number of times it was ordered.
SELECT 
    C.FirstName, 
    C.LastName, 
    B.Title, 
    SUM(O.Quantity) AS TotalQuantityOrdered
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN Books B ON O.BookID = B.BookID
GROUP BY C.CustomerID, B.BookID, C.FirstName, C.LastName, B.Title
HAVING SUM(O.Quantity) > 1
ORDER BY TotalQuantityOrdered DESC;

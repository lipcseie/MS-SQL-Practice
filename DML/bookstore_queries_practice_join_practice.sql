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

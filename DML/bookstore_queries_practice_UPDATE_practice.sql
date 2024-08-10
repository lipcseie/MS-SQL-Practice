USE BookStore;

UPDATE Books
SET PublicationYear = 2012
WHERE BookID IN (1, 2, 3);

UPDATE Books
SET PublicationYear = 1976
WHERE BookID IN (4, 5, 6);

UPDATE Books
SET PublicationYear = 2023
WHERE BookID IN (7, 8, 9);

UPDATE Orders
SET OrderDate = '2023-01-23'
WHERE OrderID IN (1, 2, 3, 9);


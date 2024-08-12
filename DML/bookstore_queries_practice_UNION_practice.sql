USE BookStore;

-- Write a query that combines the names of all authors and publishers into a single list. 
-- The result should include all author names and all publisher names in a single column named Name.
SELECT CONCAT(FirstName ,' ',LastName) AS Name FROM Authors 
UNION 
SELECT Name FROM Publishers;

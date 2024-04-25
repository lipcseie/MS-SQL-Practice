USE BookStore;

-- Insert customers into the Customers table.
INSERT INTO Customers (FirstName, LastName, Email, Phone)
VALUES 
('Bruce', 'Wayne', 'bruce.wayne@gotham.com', '111-222-3333'),
('Clark', 'Kent', 'clark.kent@metropolis.com', '222-333-4444'),
('Peter', 'Parker', 'peter.parker@nyc.com', '333-444-5555'),
('Tony', 'Stark', 'tony.stark@starkindustries.com', '444-555-6666'),
('Diana', 'Prince', 'diana.prince@themyscira.com', '555-666-7777'),
('Steve', 'Rogers', 'steve.rogers@avengers.com', '666-777-8888'),
('Natasha', 'Romanoff', 'natasha.romanoff@shield.com', '777-888-9999'),
('Wanda', 'Maximoff', 'wanda.maximoff@avengers.com', '888-999-1111'),
('Logan', 'Howlett', 'logan.howlett@xmen.com', '999-111-2222'),
('Charles', 'Xavier', 'charles.xavier@xmen.com', '111-222-3333');

-- Insert orders into the Orders table.
INSERT INTO Orders (CustomerID, BookID, Quantity, OrderDate)
VALUES 
(1, 1, 2, '2024-01-01'), -- Bruce Wayne ordered 2 copies of 'The Sorcerer’s Stone'
(2, 2, 1, '2024-01-02'), -- Clark Kent ordered 1 copy of 'The Two Towers'
(3, 3, 3, '2024-01-03'), -- Peter Parker ordered 3 copies of 'A Dance with Dragons'
(4, 4, 1, '2024-01-04'), -- Tony Stark ordered 1 copy of 'There and Back Again'
(5, 5, 2, '2024-01-05'), -- Diana Prince ordered 2 copies of 'The Lion, the Witch and the Wardrobe'
(6, 6, 1, '2024-01-06'), -- Steve Rogers ordered 1 copy of 'The Quest for Camelot'
(7, 7, 3, '2024-01-07'), -- Natasha Romanoff ordered 3 copies of 'The Wizard of Oz'
(8, 8, 2, '2024-01-08'), -- Wanda Maximoff ordered 2 copies of 'Peter Pan'
(9, 9, 1, '2024-01-09'), -- Logan Howlett ordered 1 copy of 'The Hunger Games'
(10, 10, 2, '2024-01-10'); -- Charles Xavier ordered 2 copies of 'The Chronicles of Narnia'

USE BookStore;

-- Insert authors into the Authors table.
INSERT INTO Authors (FirstName, LastName, DateOfBirth)
VALUES 
('Luna', 'Lovegood', '1981-02-13'),
('Gandalf', 'TheGrey', NULL),
('Hermione', 'Granger', '1979-09-19'),
('Bilbo', 'Baggins', NULL),
('Arya', 'Stark', NULL),
('Albus', 'Dumbledore', '1881-07-01'),
('Katniss', 'Everdeen', NULL),
('Frodo', 'Baggins', NULL),
('Daenerys', 'Targaryen', NULL),
('Harry', 'Potter', '1980-07-31');


-- Insert publishers into the Publishers table.
INSERT INTO Publishers (Name, Address, Website)
VALUES 
('Hogwarts Press', 'Hogsmeade, Highland, Scotland', 'www.hogwartspress.com'),
('Middle-Earth Publications', 'Rivendell, Middle-Earth', 'www.middleearthpubs.com'),
('Westeros Publishing House', 'King’s Landing, Westeros', 'www.westerospubhouse.com'),
('Shire Scrolls', 'Hobbiton, The Shire, Middle-Earth', 'www.shirescrolls.com'),
('Valyrian Books', 'Valyria, Essos', 'www.valyrianbooks.com'),
('Panem Prints', 'The Capitol, Panem', 'www.panemprints.com'),
('Narnia Chronicles Co.', 'Cair Paravel, Narnia', 'www.narniachronicles.com'),
('Camelot Texts', 'Camelot, Britannia', 'www.camelottexts.com'),
('Oz Publishing', 'Emerald City, Oz', 'www.ozpublishing.com'),
('Neverland Editions', 'Neverland', 'www.neverlandeditions.com');

-- Insert books into the Books table
INSERT INTO Books (Title, AuthorID, PublisherID, PublicationYear, Price, Genre)
VALUES 
('The Sorcerer’s Stone', 10, 1, 2024, 30, 'Fantasy'),
('The Two Towers', 4, 2, 2024, 25, 'Epic'),
('A Dance with Dragons', 9, 3, 2024, 35, 'Fantasy'),
('There and Back Again', 4, 4, 2024, 22, 'Adventure'),
('The Lion, the Witch and the Wardrobe', 7, 7, 2024, 20, 'Fantasy'),
('The Quest for Camelot', 2, 8, 2024, 28, 'Historical'),
('The Wizard of Oz', 5, 9, 2024, 18, 'Children’s'),
('Peter Pan', 1, 10, 2024, 15, 'Fairy Tale'),
('The Hunger Games', 7, 6, 2024, 24, 'Dystopian'),
('The Chronicles of Narnia', 7, 7, 2024, 30, 'Fantasy');


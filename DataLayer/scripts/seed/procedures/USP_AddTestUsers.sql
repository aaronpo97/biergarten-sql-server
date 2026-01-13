CREATE OR ALTER PROCEDURE dbo.USP_AddTestUsers
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRANSACTION;

    DECLARE @FullNames TABLE 
        (FirstName NVARCHAR(128),
        LastName NVARCHAR(128));

    INSERT INTO @FullNames
        (FirstName, LastName)
    VALUES
        ('Aarya', 'Mathews'),
        ('Aiden', 'Wells'),
        ('Aleena', 'Gonzalez'),
        ('Alessandra', 'Nelson'),
        ('Amari', 'Tucker'),
        ('Ameer', 'Huff'),
        ('Amirah', 'Hicks'),
        ('Analia', 'Dominguez'),
        ('Anne', 'Jenkins'),
        ('Apollo', 'Davis'),
        ('Arianna', 'White'),
        ('Aubree', 'Moore'),
        ('Aubrielle', 'Raymond'),
        ('Aydin', 'Odom'),
        ('Bowen', 'Casey'),
        ('Brock', 'Huber'),
        ('Caiden', 'Strong'),
        ('Cecilia', 'Rosales'),
        ('Celeste', 'Barber'),
        ('Chance', 'Small'),
        ('Clara', 'Roberts'),
        ('Collins', 'Brandt'),
        ('Damir', 'Wallace'),
        ('Declan', 'Crawford'),
        ('Dennis', 'Decker'),
        ('Dylan', 'Lang'),
        ('Eliza', 'Kane'),
        ('Elle', 'Poole'),
        ('Elliott', 'Miles'),
        ('Emelia', 'Lucas'),
        ('Emilia', 'Simpson'),
        ('Emmett', 'Lugo'),
        ('Ethan', 'Stephens'),
        ('Etta', 'Woods'),
        ('Gael', 'Moran'),
        ('Grant', 'Benson'),
        ('Gwen', 'James'),
        ('Huxley', 'Chen'),
        ('Isabella', 'Fisher'),
        ('Ivan', 'Mathis'),
        ('Jamir', 'McMillan'),
        ('Jaxson', 'Shields'),
        ('Jimmy', 'Richmond'),
        ('Josiah', 'Flores'),
        ('Kaden', 'Enriquez'),
        ('Kai', 'Lawson'),
        ('Karsyn', 'Adkins'),
        ('Karsyn', 'Proctor'),
        ('Kayden', 'Henson'),
        ('Kaylie', 'Spears'),
        ('Kinslee', 'Jones'),
        ('Kora', 'Guerra'),
        ('Lane', 'Skinner'),
        ('Laylani', 'Christian'),
        ('Ledger', 'Carroll'),
        ('Leilany', 'Small'),
        ('Leland', 'McCall'),
        ('Leonard', 'Calhoun'),
        ('Levi', 'Ochoa'),
        ('Lillie', 'Vang'),
        ('Lola', 'Sheppard'),
        ('Luciana', 'Poole'),
        ('Maddox', 'Hughes'),
        ('Mara', 'Blackwell'),
        ('Marcellus', 'Bartlett'),
        ('Margo', 'Koch'),
        ('Maurice', 'Gibson'),
        ('Maxton', 'Dodson'),
        ('Mia', 'Parrish'),
        ('Millie', 'Fuentes'),
        ('Nellie', 'Villanueva'),
        ('Nicolas', 'Mata'),
        ('Nicolas', 'Miller'),
        ('Oakleigh', 'Foster'),
        ('Octavia', 'Pierce'),
        ('Paisley', 'Allison'),
        ('Quincy', 'Andersen'),
        ('Quincy', 'Frazier'),
        ('Raiden', 'Roberts'),
        ('Raquel', 'Lara'),
        ('Rudy', 'McIntosh'),
        ('Salvador', 'Stein'),
        ('Samantha', 'Dickson'),
        ('Solomon', 'Richards'),
        ('Sylvia', 'Hanna'),
        ('Talia', 'Trujillo'),
        ('Thalia', 'Farrell'),
        ('Trent', 'Mayo'),
        ('Trinity', 'Cummings'),
        ('Ty', 'Perry'),
        ('Tyler', 'Romero'),
        ('Valeria', 'Pierce'),
        ('Vance', 'Neal'),
        ('Whitney', 'Bell'),
        ('Wilder', 'Graves'),
        ('William', 'Logan'),
        ('Zara', 'Wilkinson'),
        ('Zaria', 'Gibson'),
        ('Zion', 'Watkins'),
        ('Zoie', 'Armstrong');


    INSERT INTO dbo.UserAccount
        (Username, FirstName, LastName, Email, DateOfBirth)
    SELECT
        LEFT(LOWER(CONCAT(fn.FirstName, '.', fn.LastName)), 64) AS Username,
        fn.FirstName,
        fn.LastName,
        LEFT(LOWER(CONCAT(fn.FirstName, '.', fn.LastName, '@example.com')), 128) AS Email,

        -- date of birth: pick age between 18 and 47 (18 + 0..29)
        DATEADD(YEAR, -(19 + ABS(CHECKSUM(NEWID())) % 30), CAST(GETDATE() AS DATE))
    FROM @FullNames AS fn;


    COMMIT TRANSACTION;
END;


USE Biergarten;

-- User Account Variables (30 users)
DECLARE
@user1 UNIQUEIDENTIFIER = NEWID(),
@user2 UNIQUEIDENTIFIER = NEWID(),
@user3 UNIQUEIDENTIFIER = NEWID(),
@user4 UNIQUEIDENTIFIER = NEWID(),
@user5 UNIQUEIDENTIFIER = NEWID(),
@user6 UNIQUEIDENTIFIER = NEWID(),
@user7 UNIQUEIDENTIFIER = NEWID(),
@user8 UNIQUEIDENTIFIER = NEWID(),
@user9 UNIQUEIDENTIFIER = NEWID(),
@user10 UNIQUEIDENTIFIER = NEWID(),
@user11 UNIQUEIDENTIFIER = NEWID(),
@user12 UNIQUEIDENTIFIER = NEWID(),
@user13 UNIQUEIDENTIFIER = NEWID(),
@user14 UNIQUEIDENTIFIER = NEWID(),
@user15 UNIQUEIDENTIFIER = NEWID(),
@user16 UNIQUEIDENTIFIER = NEWID(),
@user17 UNIQUEIDENTIFIER = NEWID(),
@user18 UNIQUEIDENTIFIER = NEWID(),
@user19 UNIQUEIDENTIFIER = NEWID(),
@user20 UNIQUEIDENTIFIER = NEWID(),
@user21 UNIQUEIDENTIFIER = NEWID(),
@user22 UNIQUEIDENTIFIER = NEWID(),
@user23 UNIQUEIDENTIFIER = NEWID(),
@user24 UNIQUEIDENTIFIER = NEWID(),
@user25 UNIQUEIDENTIFIER = NEWID(),
@user26 UNIQUEIDENTIFIER = NEWID(),
@user27 UNIQUEIDENTIFIER = NEWID(),
@user28 UNIQUEIDENTIFIER = NEWID(),
@user29 UNIQUEIDENTIFIER = NEWID(),
@user30 UNIQUEIDENTIFIER = NEWID(),

-- BeerStyle Variables (13 styles)
@ipa UNIQUEIDENTIFIER = NEWID(),
@stout UNIQUEIDENTIFIER = NEWID(),
@lager UNIQUEIDENTIFIER = NEWID(),
@ale UNIQUEIDENTIFIER = NEWID(),
@pilsner UNIQUEIDENTIFIER = NEWID(),
@wheat UNIQUEIDENTIFIER = NEWID(),
@porter UNIQUEIDENTIFIER = NEWID(),
@sour UNIQUEIDENTIFIER = NEWID(),
@belgian UNIQUEIDENTIFIER = NEWID(),
@amber UNIQUEIDENTIFIER = NEWID(),
@saison UNIQUEIDENTIFIER = NEWID(),
@brown UNIQUEIDENTIFIER = NEWID(),
@barleywine UNIQUEIDENTIFIER = NEWID(),

-- Photo Variables (40 photos)
@photo1 UNIQUEIDENTIFIER = NEWID(),
@photo2 UNIQUEIDENTIFIER = NEWID(),
@photo3 UNIQUEIDENTIFIER = NEWID(),
@photo4 UNIQUEIDENTIFIER = NEWID(),
@photo5 UNIQUEIDENTIFIER = NEWID(),
@photo6 UNIQUEIDENTIFIER = NEWID(),
@photo7 UNIQUEIDENTIFIER = NEWID(),
@photo8 UNIQUEIDENTIFIER = NEWID(),
@photo9 UNIQUEIDENTIFIER = NEWID(),
@photo10 UNIQUEIDENTIFIER = NEWID(),
@photo11 UNIQUEIDENTIFIER = NEWID(),
@photo12 UNIQUEIDENTIFIER = NEWID(),
@photo13 UNIQUEIDENTIFIER = NEWID(),
@photo14 UNIQUEIDENTIFIER = NEWID(),
@photo15 UNIQUEIDENTIFIER = NEWID(),
@photo16 UNIQUEIDENTIFIER = NEWID(),
@photo17 UNIQUEIDENTIFIER = NEWID(),
@photo18 UNIQUEIDENTIFIER = NEWID(),
@photo19 UNIQUEIDENTIFIER = NEWID(),
@photo20 UNIQUEIDENTIFIER = NEWID(),
@photo21 UNIQUEIDENTIFIER = NEWID(),
@photo22 UNIQUEIDENTIFIER = NEWID(),
@photo23 UNIQUEIDENTIFIER = NEWID(),
@photo24 UNIQUEIDENTIFIER = NEWID(),
@photo25 UNIQUEIDENTIFIER = NEWID(),
@photo26 UNIQUEIDENTIFIER = NEWID(),
@photo27 UNIQUEIDENTIFIER = NEWID(),
@photo28 UNIQUEIDENTIFIER = NEWID(),
@photo29 UNIQUEIDENTIFIER = NEWID(),
@photo30 UNIQUEIDENTIFIER = NEWID(),
@photo31 UNIQUEIDENTIFIER = NEWID(),
@photo32 UNIQUEIDENTIFIER = NEWID(),
@photo33 UNIQUEIDENTIFIER = NEWID(),
@photo34 UNIQUEIDENTIFIER = NEWID(),
@photo35 UNIQUEIDENTIFIER = NEWID(),
@photo36 UNIQUEIDENTIFIER = NEWID(),
@photo37 UNIQUEIDENTIFIER = NEWID(),
@photo38 UNIQUEIDENTIFIER = NEWID(),
@photo39 UNIQUEIDENTIFIER = NEWID(),
@photo40 UNIQUEIDENTIFIER = NEWID(),

-- BreweryPost Variables (15 breweries)
@brewery1 UNIQUEIDENTIFIER = NEWID(),
@brewery2 UNIQUEIDENTIFIER = NEWID(),
@brewery3 UNIQUEIDENTIFIER = NEWID(),
@brewery4 UNIQUEIDENTIFIER = NEWID(),
@brewery5 UNIQUEIDENTIFIER = NEWID(),
@brewery6 UNIQUEIDENTIFIER = NEWID(),
@brewery7 UNIQUEIDENTIFIER = NEWID(),
@brewery8 UNIQUEIDENTIFIER = NEWID(),
@brewery9 UNIQUEIDENTIFIER = NEWID(),
@brewery10 UNIQUEIDENTIFIER = NEWID(),
@brewery11 UNIQUEIDENTIFIER = NEWID(),
@brewery12 UNIQUEIDENTIFIER = NEWID(),
@brewery13 UNIQUEIDENTIFIER = NEWID(),
@brewery14 UNIQUEIDENTIFIER = NEWID(),
@brewery15 UNIQUEIDENTIFIER = NEWID(),

-- BeerPost Variables (28 beers)
@beer1 UNIQUEIDENTIFIER = NEWID(),
@beer2 UNIQUEIDENTIFIER = NEWID(),
@beer3 UNIQUEIDENTIFIER = NEWID(),
@beer4 UNIQUEIDENTIFIER = NEWID(),
@beer5 UNIQUEIDENTIFIER = NEWID(),
@beer6 UNIQUEIDENTIFIER = NEWID(),
@beer7 UNIQUEIDENTIFIER = NEWID(),
@beer8 UNIQUEIDENTIFIER = NEWID(),
@beer9 UNIQUEIDENTIFIER = NEWID(),
@beer10 UNIQUEIDENTIFIER = NEWID(),
@beer11 UNIQUEIDENTIFIER = NEWID(),
@beer12 UNIQUEIDENTIFIER = NEWID(),
@beer13 UNIQUEIDENTIFIER = NEWID(),
@beer14 UNIQUEIDENTIFIER = NEWID(),
@beer15 UNIQUEIDENTIFIER = NEWID(),
@beer16 UNIQUEIDENTIFIER = NEWID(),
@beer17 UNIQUEIDENTIFIER = NEWID(),
@beer18 UNIQUEIDENTIFIER = NEWID(),
@beer19 UNIQUEIDENTIFIER = NEWID(),
@beer20 UNIQUEIDENTIFIER = NEWID(),
@beer21 UNIQUEIDENTIFIER = NEWID(),
@beer22 UNIQUEIDENTIFIER = NEWID(),
@beer23 UNIQUEIDENTIFIER = NEWID(),
@beer24 UNIQUEIDENTIFIER = NEWID(),
@beer25 UNIQUEIDENTIFIER = NEWID(),
@beer26 UNIQUEIDENTIFIER = NEWID(),
@beer27 UNIQUEIDENTIFIER = NEWID(),
@beer28 UNIQUEIDENTIFIER = NEWID(),

-- Rating Variables (50 ratings)
@rating1 UNIQUEIDENTIFIER = NEWID(),
@rating2 UNIQUEIDENTIFIER = NEWID(),
@rating3 UNIQUEIDENTIFIER = NEWID(),
@rating4 UNIQUEIDENTIFIER = NEWID(),
@rating5 UNIQUEIDENTIFIER = NEWID(),
@rating6 UNIQUEIDENTIFIER = NEWID(),
@rating7 UNIQUEIDENTIFIER = NEWID(),
@rating8 UNIQUEIDENTIFIER = NEWID(),
@rating9 UNIQUEIDENTIFIER = NEWID(),
@rating10 UNIQUEIDENTIFIER = NEWID(),
@rating11 UNIQUEIDENTIFIER = NEWID(),
@rating12 UNIQUEIDENTIFIER = NEWID(),
@rating13 UNIQUEIDENTIFIER = NEWID(),
@rating14 UNIQUEIDENTIFIER = NEWID(),
@rating15 UNIQUEIDENTIFIER = NEWID(),
@rating16 UNIQUEIDENTIFIER = NEWID(),
@rating17 UNIQUEIDENTIFIER = NEWID(),
@rating18 UNIQUEIDENTIFIER = NEWID(),
@rating19 UNIQUEIDENTIFIER = NEWID(),
@rating20 UNIQUEIDENTIFIER = NEWID(),
@rating21 UNIQUEIDENTIFIER = NEWID(),
@rating22 UNIQUEIDENTIFIER = NEWID(),
@rating23 UNIQUEIDENTIFIER = NEWID(),
@rating24 UNIQUEIDENTIFIER = NEWID(),
@rating25 UNIQUEIDENTIFIER = NEWID(),
@rating26 UNIQUEIDENTIFIER = NEWID(),
@rating27 UNIQUEIDENTIFIER = NEWID(),
@rating28 UNIQUEIDENTIFIER = NEWID(),
@rating29 UNIQUEIDENTIFIER = NEWID(),
@rating30 UNIQUEIDENTIFIER = NEWID(),
@rating31 UNIQUEIDENTIFIER = NEWID(),
@rating32 UNIQUEIDENTIFIER = NEWID(),
@rating33 UNIQUEIDENTIFIER = NEWID(),
@rating34 UNIQUEIDENTIFIER = NEWID(),
@rating35 UNIQUEIDENTIFIER = NEWID(),
@rating36 UNIQUEIDENTIFIER = NEWID(),
@rating37 UNIQUEIDENTIFIER = NEWID(),
@rating38 UNIQUEIDENTIFIER = NEWID(),
@rating39 UNIQUEIDENTIFIER = NEWID(),
@rating40 UNIQUEIDENTIFIER = NEWID(),
@rating41 UNIQUEIDENTIFIER = NEWID(),
@rating42 UNIQUEIDENTIFIER = NEWID(),
@rating43 UNIQUEIDENTIFIER = NEWID(),
@rating44 UNIQUEIDENTIFIER = NEWID(),
@rating45 UNIQUEIDENTIFIER = NEWID(),
@rating46 UNIQUEIDENTIFIER = NEWID(),
@rating47 UNIQUEIDENTIFIER = NEWID(),
@rating48 UNIQUEIDENTIFIER = NEWID(),
@rating49 UNIQUEIDENTIFIER = NEWID(),
@rating50 UNIQUEIDENTIFIER = NEWID();

----------------------------------------------------------------------------
-- UserAccount (30 users)
----------------------------------------------------------------------------
BEGIN TRANSACTION;
INSERT INTO dbo.UserAccount
    (UserAccountID, Username, FirstName, LastName, Email, CreatedAt, DateOfBirth)
VALUES
    (@user1, 'john_smith', 'John', 'Smith', 'john.smith@email.com', '2023-01-15', '1990-05-12'),
    (@user2, 'sarah_jones', 'Sarah', 'Jones', 'sarah.jones@email.com', '2023-02-20', '1988-08-23'),
    (@user3, 'mike_brown', 'Mike', 'Brown', 'mike.brown@email.com', '2023-03-10', '1992-11-30'),
    (@user4, 'emily_davis', 'Emily', 'Davis', 'emily.davis@email.com', '2023-04-05', '1995-03-17'),
    (@user5, 'james_wilson', 'James', 'Wilson', 'james.wilson@email.com', '2023-05-12', '1987-07-22'),
    (@user6, 'lisa_moore', 'Lisa', 'Moore', 'lisa.moore@email.com', '2023-06-18', '1991-12-08'),
    (@user7, 'david_taylor', 'David', 'Taylor', 'david.taylor@email.com', '2023-07-22', '1989-04-15'),
    (@user8, 'jessica_anderson', 'Jessica', 'Anderson', 'jessica.anderson@email.com', '2023-08-14', '1993-09-25'),
    (@user9, 'chris_thomas', 'Chris', 'Thomas', 'chris.thomas@email.com', '2023-09-03', '1990-02-18'),
    (@user10, 'amanda_jackson', 'Amanda', 'Jackson', 'amanda.jackson@email.com', '2023-10-11', '1994-06-30'),
    (@user11, 'robert_white', 'Robert', 'White', 'robert.white@email.com', '2023-11-19', '1986-10-12'),
    (@user12, 'jennifer_harris', 'Jennifer', 'Harris', 'jennifer.harris@email.com', '2023-12-07', '1992-01-28'),
    (@user13, 'matthew_martin', 'Matthew', 'Martin', 'matthew.martin@email.com', '2024-01-14', '1991-05-09'),
    (@user14, 'ashley_thompson', 'Ashley', 'Thompson', 'ashley.thompson@email.com', '2024-02-21', '1988-11-14'),
    (@user15, 'daniel_garcia', 'Daniel', 'Garcia', 'daniel.garcia@email.com', '2024-03-16', '1993-08-03'),
    (@user16, 'nicole_martinez', 'Nicole', 'Martinez', 'nicole.martinez@email.com', '2024-04-08', '1995-12-21'),
    (@user17, 'kevin_robinson', 'Kevin', 'Robinson', 'kevin.robinson@email.com', '2024-05-25', '1989-03-27'),
    (@user18, 'lauren_clark', 'Lauren', 'Clark', 'lauren.clark@email.com', '2024-06-13', '1992-07-19'),
    (@user19, 'brian_rodriguez', 'Brian', 'Rodriguez', 'brian.rodriguez@email.com', '2024-07-30', '1990-09-05'),
    (@user20, 'megan_lewis', 'Megan', 'Lewis', 'megan.lewis@email.com', '2024-08-17', '1994-02-11'),
    (@user21, 'steven_lee', 'Steven', 'Lee', 'steven.lee@email.com', '2024-09-09', '1987-06-16'),
    (@user22, 'rachel_walker', 'Rachel', 'Walker', 'rachel.walker@email.com', '2024-10-02', '1991-10-24'),
    (@user23, 'justin_hall', 'Justin', 'Hall', 'justin.hall@email.com', '2024-11-11', '1993-04-07'),
    (@user24, 'heather_allen', 'Heather', 'Allen', 'heather.allen@email.com', '2024-12-20', '1988-12-30'),
    (@user25, 'tyler_young', 'Tyler', 'Young', 'tyler.young@email.com', '2025-01-05', '1996-01-15'),
    (@user26, 'rebecca_king', 'Rebecca', 'King', 'rebecca.king@email.com', '2025-02-14', '1990-08-08'),
    (@user27, 'jason_wright', 'Jason', 'Wright', 'jason.wright@email.com', '2025-03-22', '1992-03-29'),
    (@user28, 'michelle_lopez', 'Michelle', 'Lopez', 'michelle.lopez@email.com', '2025-04-18', '1989-11-11'),
    (@user29, 'brandon_hill', 'Brandon', 'Hill', 'brandon.hill@email.com', '2025-05-27', '1994-05-05'),
    (@user30, 'stephanie_green', 'Stephanie', 'Green', 'stephanie.green@email.com', '2025-06-30', '1991-09-18');
COMMIT TRANSACTION;


----------------------------------------------------------------------------
-- BeerStyle (13 styles)
----------------------------------------------------------------------------
BEGIN TRANSACTION;
INSERT INTO dbo.BeerStyle
    (BeerStyleID, StyleName, Description)
VALUES
    (@ipa, 'India Pale Ale', 'A hoppy beer style within the broader category of pale ale, known for its strong hop flavor and higher alcohol content.'),
    (@stout, 'Stout', 'A dark beer made using roasted malt or roasted barley, hops, water and yeast. Stouts have a rich, creamy texture.'),
    (@lager, 'Lager', 'A type of beer conditioned at low temperature. Lagers are crisp, clean, and refreshing.'),
    (@ale, 'Pale Ale', 'A golden to amber colored beer style brewed with pale malt. The highest proportion of pale malts results in its light color.'),
    (@pilsner, 'Pilsner', 'A type of pale lager that is characterized by its light color, clarity, and refreshing taste with a notable hop character.'),
    (@wheat, 'Wheat Beer', 'A top-fermented beer which is brewed with a large proportion of wheat relative to the amount of malted barley.'),
    (@porter, 'Porter', 'A dark style of beer developed in London, well-hopped and made from brown malt.'),
    (@sour, 'Sour Ale', 'A beer that has an intentionally acidic, tart, or sour taste, achieved through wild yeast and bacteria fermentation.'),
    (@belgian, 'Belgian Ale', 'Traditional Belgian-style ales with complex fruity and spicy yeast character.'),
    (@amber, 'Amber Ale', 'Medium-bodied ale with caramel malt flavor and moderate hop bitterness.'),
    (@saison, 'Saison', 'Farmhouse ale with fruity, spicy, and peppery characteristics.'),
    (@brown, 'Brown Ale', 'Malty beer with nutty, chocolate, and caramel notes.'),
    (@barleywine, 'Barleywine', 'Strong ale with intense malt flavors and high alcohol content.');
COMMIT TRANSACTION;


----------------------------------------------------------------------------
-- UserCredential (28 credentials)
----------------------------------------------------------------------------
BEGIN TRANSACTION;
INSERT INTO dbo.UserCredential
    (UserAccountID, Hash, CreatedAt, Expiry)
VALUES
    (@user1, '$argon2id$v=19$m=65536,t=3,p=4$randomsalt1$hashedpassword1', '2023-01-15', '2025-12-31'),
    (@user2, '$argon2id$v=19$m=65536,t=3,p=4$randomsalt2$hashedpassword2', '2023-02-20', '2025-12-31'),
    (@user3, '$argon2id$v=19$m=65536,t=3,p=4$randomsalt3$hashedpassword3', '2023-03-10', '2025-12-31'),
    (@user4, '$argon2id$v=19$m=65536,t=3,p=4$randomsalt4$hashedpassword4', '2023-04-05', '2025-12-31'),
    (@user5, '$argon2id$v=19$m=65536,t=3,p=4$randomsalt5$hashedpassword5', '2023-05-12', '2025-12-31'),
    (@user6, '$argon2id$v=19$m=65536,t=3,p=4$randomsalt6$hashedpassword6', '2023-06-18', '2025-12-31'),
    (@user7, '$argon2id$v=19$m=65536,t=3,p=4$randomsalt7$hashedpassword7', '2023-07-22', '2025-12-31'),
    (@user8, '$argon2id$v=19$m=65536,t=3,p=4$randomsalt8$hashedpassword8', '2023-08-14', '2025-12-31'),
    (@user9, '$argon2id$v=19$m=65536,t=3,p=4$randomsalt9$hashedpassword9', '2023-09-03', '2025-12-31'),
    (@user10, '$argon2id$v=19$m=65536,t=3,p=4$randomsalt10$hashedpassword10', '2023-10-11', '2025-12-31'),
    (@user11, '$argon2id$v=19$m=65536,t=3,p=4$randomsalt11$hashedpassword11', '2023-11-19', '2025-12-31'),
    (@user12, '$argon2id$v=19$m=65536,t=3,p=4$randomsalt12$hashedpassword12', '2023-12-07', '2025-12-31'),
    (@user13, '$argon2id$v=19$m=65536,t=3,p=4$randomsalt13$hashedpassword13', '2024-01-14', '2025-12-31'),
    (@user14, '$argon2id$v=19$m=65536,t=3,p=4$randomsalt14$hashedpassword14', '2024-02-21', '2025-12-31'),
    (@user16, '$argon2id$v=19$m=65536,t=3,p=4$randomsalt16$hashedpassword16', '2024-04-08', '2025-12-31'),
    (@user17, '$argon2id$v=19$m=65536,t=3,p=4$randomsalt17$hashedpassword17', '2024-05-25', '2025-12-31'),
    (@user18, '$argon2id$v=19$m=65536,t=3,p=4$randomsalt18$hashedpassword18', '2024-06-13', '2025-12-31'),
    (@user19, '$argon2id$v=19$m=65536,t=3,p=4$randomsalt19$hashedpassword19', '2024-07-30', '2025-12-31'),
    (@user21, '$argon2id$v=19$m=65536,t=3,p=4$randomsalt21$hashedpassword21', '2024-09-09', '2025-12-31'),
    (@user22, '$argon2id$v=19$m=65536,t=3,p=4$randomsalt22$hashedpassword22', '2024-10-02', '2025-12-31'),
    (@user23, '$argon2id$v=19$m=65536,t=3,p=4$randomsalt23$hashedpassword23', '2024-11-11', '2025-12-31'),
    (@user24, '$argon2id$v=19$m=65536,t=3,p=4$randomsalt24$hashedpassword24', '2024-12-20', '2025-12-31'),
    (@user25, '$argon2id$v=19$m=65536,t=3,p=4$randomsalt25$hashedpassword25', '2025-01-05', '2025-12-31'),
    (@user26, '$argon2id$v=19$m=65536,t=3,p=4$randomsalt26$hashedpassword26', '2025-02-14', '2025-12-31'),
    (@user27, '$argon2id$v=19$m=65536,t=3,p=4$randomsalt27$hashedpassword27', '2025-03-22', '2025-12-31'),
    (@user28, '$argon2id$v=19$m=65536,t=3,p=4$randomsalt28$hashedpassword28', '2025-04-18', '2025-12-31'),
    (@user29, '$argon2id$v=19$m=65536,t=3,p=4$randomsalt29$hashedpassword29', '2025-05-27', '2025-12-31'),
    (@user30, '$argon2id$v=19$m=65536,t=3,p=4$randomsalt30$hashedpassword30', '2025-06-30', '2025-12-31');
COMMIT TRANSACTION;


----------------------------------------------------------------------------
-- UserVerification (20 verified users)
----------------------------------------------------------------------------
BEGIN TRANSACTION;
INSERT INTO dbo.UserVerification
    (UserAccountID, VerificationDateTime)
VALUES
    (@user1, '2023-01-16'),
    (@user2, '2023-02-21'),
    (@user3, '2023-03-11'),
    (@user4, '2023-04-06'),
    (@user5, '2023-05-13'),
    (@user6, '2023-06-19'),
    (@user7, '2023-07-23'),
    (@user8, '2023-08-15'),
    (@user9, '2023-09-04'),
    (@user10, '2023-10-12'),
    (@user11, '2023-11-20'),
    (@user12, '2023-12-08'),
    (@user13, '2024-01-15'),
    (@user15, '2024-03-17'),
    (@user16, '2024-04-09'),
    (@user17, '2024-05-26'),
    (@user18, '2024-06-14'),
    (@user20, '2024-08-18'),
    (@user22, '2024-10-03'),
    (@user25, '2025-01-06');
COMMIT TRANSACTION;


----------------------------------------------------------------------------
-- UserFollow (40 follow relationships)
----------------------------------------------------------------------------
BEGIN TRANSACTION;
INSERT INTO dbo.UserFollow
    (UserAccountID, FollowingID, CreatedAt)
VALUES
    (@user1, @user2, '2023-02-01'),
    (@user1, @user3, '2023-02-05'),
    (@user1, @user5, '2023-05-20'),
    (@user1, @user10, '2024-01-01'),
    (@user2, @user1, '2023-02-15'),
    (@user2, @user4, '2023-04-10'),
    (@user2, @user12, '2024-02-01'),
    (@user3, @user1, '2023-03-20'),
    (@user3, @user6, '2023-06-25'),
    (@user3, @user14, '2024-03-01'),
    (@user4, @user2, '2023-04-15'),
    (@user5, @user1, '2023-05-25'),
    (@user5, @user7, '2023-07-30'),
    (@user6, @user3, '2023-07-01'),
    (@user7, @user5, '2023-08-05'),
    (@user8, @user1, '2023-08-20'),
    (@user9, @user2, '2023-09-10'),
    (@user10, @user5, '2023-10-20'),
    (@user10, @user8, '2023-11-01'),
    (@user11, @user2, '2023-11-25'),
    (@user12, @user3, '2023-12-15'),
    (@user13, @user5, '2024-01-20'),
    (@user14, @user1, '2024-03-01'),
    (@user14, @user7, '2024-03-05'),
    (@user15, @user2, '2024-03-20'),
    (@user16, @user4, '2024-04-15'),
    (@user17, @user6, '2024-05-30'),
    (@user18, @user8, '2024-06-20'),
    (@user19, @user10, '2024-08-01'),
    (@user20, @user12, '2024-08-25'),
    (@user21, @user14, '2024-09-15'),
    (@user22, @user1, '2024-10-05'),
    (@user23, @user11, '2024-11-15'),
    (@user24, @user13, '2024-12-25'),
    (@user25, @user15, '2025-01-10'),
    (@user26, @user17, '2025-02-20'),
    (@user27, @user19, '2025-03-25'),
    (@user28, @user21, '2025-04-22'),
    (@user29, @user23, '2025-05-30'),
    (@user30, @user25, '2025-07-05');
COMMIT TRANSACTION;

----------------------------------------------------------------------------
-- Photo (40 photos)
----------------------------------------------------------------------------
BEGIN TRANSACTION;
INSERT INTO dbo.Photo
    (PhotoID, Hyperlink, UploadedByID, UploadedAt)
VALUES
    (@photo1, 'https://storage.biergarten.com/photos/avatar1.jpg', @user1, '2023-01-15'),
    (@photo2, 'https://storage.biergarten.com/photos/avatar2.jpg', @user2, '2023-02-20'),
    (@photo3, 'https://storage.biergarten.com/photos/brewery1.jpg', @user1, '2023-03-01'),
    (@photo4, 'https://storage.biergarten.com/photos/brewery2.jpg', @user2, '2023-03-05'),
    (@photo5, 'https://storage.biergarten.com/photos/beer1.jpg', @user3, '2023-04-10'),
    (@photo6, 'https://storage.biergarten.com/photos/beer2.jpg', @user4, '2023-04-15'),
    (@photo7, 'https://storage.biergarten.com/photos/beer3.jpg', @user5, '2023-05-20'),
    (@photo8, 'https://storage.biergarten.com/photos/brewery3.jpg', @user6, '2023-06-01'),
    (@photo9, 'https://storage.biergarten.com/photos/avatar3.jpg', @user3, '2023-06-05'),
    (@photo10, 'https://storage.biergarten.com/photos/beer4.jpg', @user7, '2023-07-10'),
    (@photo11, 'https://storage.biergarten.com/photos/beer5.jpg', @user8, '2023-08-15'),
    (@photo12, 'https://storage.biergarten.com/photos/brewery4.jpg', @user9, '2023-09-01'),
    (@photo13, 'https://storage.biergarten.com/photos/beer6.jpg', @user10, '2023-10-05'),
    (@photo14, 'https://storage.biergarten.com/photos/avatar4.jpg', @user5, '2024-01-10'),
    (@photo15, 'https://storage.biergarten.com/photos/brewery5.jpg', @user11, '2024-02-15'),
    (@photo16, 'https://storage.biergarten.com/photos/beer7.jpg', @user12, '2024-03-20'),
    (@photo17, 'https://storage.biergarten.com/photos/beer8.jpg', @user13, '2024-04-25'),
    (@photo18, 'https://storage.biergarten.com/photos/brewery6.jpg', @user14, '2024-05-30'),
    (@photo19, 'https://storage.biergarten.com/photos/beer9.jpg', @user15, '2024-06-15'),
    (@photo20, 'https://storage.biergarten.com/photos/avatar5.jpg', @user7, '2024-07-20'),
    (@photo21, 'https://storage.biergarten.com/photos/beer10.jpg', @user16, '2024-08-05'),
    (@photo22, 'https://storage.biergarten.com/photos/beer11.jpg', @user17, '2024-08-20'),
    (@photo23, 'https://storage.biergarten.com/photos/brewery7.jpg', @user18, '2024-09-01'),
    (@photo24, 'https://storage.biergarten.com/photos/beer12.jpg', @user19, '2024-09-15'),
    (@photo25, 'https://storage.biergarten.com/photos/avatar6.jpg', @user10, '2024-10-01'),
    (@photo26, 'https://storage.biergarten.com/photos/beer13.jpg', @user20, '2024-10-10'),
    (@photo27, 'https://storage.biergarten.com/photos/brewery8.jpg', @user21, '2024-10-20'),
    (@photo28, 'https://storage.biergarten.com/photos/beer14.jpg', @user22, '2024-11-01'),
    (@photo29, 'https://storage.biergarten.com/photos/beer15.jpg', @user23, '2024-11-15'),
    (@photo30, 'https://storage.biergarten.com/photos/avatar7.jpg', @user15, '2024-12-01'),
    (@photo31, 'https://storage.biergarten.com/photos/brewery9.jpg', @user24, '2024-12-25'),
    (@photo32, 'https://storage.biergarten.com/photos/beer16.jpg', @user25, '2025-01-15'),
    (@photo33, 'https://storage.biergarten.com/photos/beer17.jpg', @user26, '2025-02-20'),
    (@photo34, 'https://storage.biergarten.com/photos/brewery10.jpg', @user27, '2025-03-30'),
    (@photo35, 'https://storage.biergarten.com/photos/beer18.jpg', @user28, '2025-04-25'),
    (@photo36, 'https://storage.biergarten.com/photos/beer19.jpg', @user29, '2025-06-01'),
    (@photo37, 'https://storage.biergarten.com/photos/avatar8.jpg', @user20, '2025-06-15'),
    (@photo38, 'https://storage.biergarten.com/photos/beer20.jpg', @user30, '2025-07-10'),
    (@photo39, 'https://storage.biergarten.com/photos/brewery11.jpg', @user4, '2025-08-01'),
    (@photo40, 'https://storage.biergarten.com/photos/avatar9.jpg', @user25, '2025-09-01');
COMMIT TRANSACTION;


----------------------------------------------------------------------------
-- UserAvatar (9 avatars)
----------------------------------------------------------------------------
BEGIN TRANSACTION;
INSERT INTO dbo.UserAvatar
    (UserAccountID, PhotoID)
VALUES
    (@user1, @photo1),
    (@user2, @photo2),
    (@user3, @photo9),
    (@user5, @photo14),
    (@user7, @photo20),
    (@user10, @photo25),
    (@user15, @photo30),
    (@user20, @photo37),
    (@user25, @photo40);
COMMIT TRANSACTION;


----------------------------------------------------------------------------
-- BreweryPost (15 breweries)
----------------------------------------------------------------------------
BEGIN TRANSACTION;
INSERT INTO dbo.BreweryPost
    (BreweryPostID, PostedByID, Description, CreatedAt)
VALUES
    (@brewery1, @user1, 'Hoppy Trails Brewery - Crafting exceptional IPAs since 2020. Located in the heart of Portland.', '2023-02-01'),
    (@brewery2, @user2, 'Dark Horse Brewing Co. - Specializing in rich stouts and porters. Family owned and operated.', '2023-03-01'),
    (@brewery3, @user3, 'Golden Gate Lager House - Traditional German-style lagers brewed with precision.', '2023-04-01'),
    (@brewery4, @user5, 'Mountain View Ales - High-altitude brewing for unique flavor profiles.', '2023-05-15'),
    (@brewery5, @user6, 'Coastal Wheat Works - Refreshing wheat beers perfect for any season.', '2023-06-20'),
    (@brewery6, @user9, 'Riverside Porter Factory - Classic porters with a modern twist.', '2023-08-10'),
    (@brewery7, @user11, 'Sunset Sour Cellars - Experimental sour ales aged in oak barrels.', '2024-01-20'),
    (@brewery8, @user14, 'Urban Craft Collective - Community-focused brewery with rotating seasonal offerings.', '2024-05-10'),
    (@brewery9, @user4, 'Belgian House - Authentic Belgian brewing traditions in the heart of the city.', '2024-06-01'),
    (@brewery10, @user18, 'Amber Fields Brewery - Celebrating the richness of amber ales and maltier styles.', '2024-08-15'),
    (@brewery11, @user20, 'Farmhouse Funk - Specializing in saisons and wild fermented ales.', '2024-09-20'),
    (@brewery12, @user24, 'Brown Bear Brewing - Cozy taproom featuring award-winning brown ales.', '2025-01-10'),
    (@brewery13, @user27, 'Vintage Vats - Small-batch barleywines and aged strong ales.', '2025-02-25'),
    (@brewery14, @user12, 'Hop Haven - Experimental IPAs and cutting-edge hop varieties.', '2024-10-05'),
    (@brewery15, @user8, 'Barrel & Grain - Farm-to-glass brewery using locally sourced ingredients.', '2024-04-20');
COMMIT TRANSACTION;


----------------------------------------------------------------------------
-- BreweryPostPhoto (11 brewery photos)
----------------------------------------------------------------------------
BEGIN TRANSACTION;
INSERT INTO dbo.BreweryPostPhoto
    (BreweryPostID, PhotoID, LinkedAt)
VALUES
    (@brewery1, @photo3, '2023-03-01'),
    (@brewery2, @photo4, '2023-03-05'),
    (@brewery3, @photo8, '2023-06-01'),
    (@brewery4, @photo12, '2023-09-01'),
    (@brewery5, @photo15, '2024-02-15'),
    (@brewery6, @photo18, '2024-05-30'),
    (@brewery7, @photo23, '2024-09-01'),
    (@brewery8, @photo27, '2024-10-20'),
    (@brewery9, @photo39, '2025-08-01'),
    (@brewery10, @photo31, '2024-12-25'),
    (@brewery11, @photo34, '2025-03-30');
COMMIT TRANSACTION;


----------------------------------------------------------------------------
-- BeerPost (28 beers)
----------------------------------------------------------------------------
BEGIN TRANSACTION;
INSERT INTO dbo.BeerPost
    (BeerPostID, Name, Description, ABV, IBU, PostedByID, BeerStyleID, BrewedByID, CreatedAt)
VALUES
    (@beer1, 'Trail Blazer IPA', 'A bold and hoppy IPA with citrus notes and a crisp finish.', 6.8, 65, @user1, @ipa, @brewery1, '2023-04-01'),
    (@beer2, 'Midnight Stout', 'Rich and creamy stout with notes of chocolate and coffee.', 7.2, 35, @user2, @stout, @brewery2, '2023-04-15'),
    (@beer3, 'Golden Bay Lager', 'Classic German-style lager, clean and refreshing.', 4.8, 22, @user3, @lager, @brewery3, '2023-05-01'),
    (@beer4, 'Summit Pale Ale', 'Balanced pale ale with floral hop aromas.', 5.5, 40, @user5, @ale, @brewery4, '2023-06-10'),
    (@beer5, 'Ocean Wheat', 'Smooth wheat beer with hints of orange peel.', 4.5, 15, @user6, @wheat, @brewery5, '2023-07-01'),
    (@beer6, 'Dark Waters Porter', 'Traditional porter with roasted malt character.', 5.8, 30, @user9, @porter, @brewery6, '2023-09-15'),
    (@beer7, 'Sunset Sour', 'Tart and refreshing sour ale with cherry notes.', 5.2, 10, @user11, @sour, @brewery7, '2024-03-01'),
    (@beer8, 'Urban Pilsner', 'Crisp pilsner with noble hop character.', 5.0, 35, @user14, @pilsner, @brewery8, '2024-06-15'),
    (@beer9, 'Double IPA Extreme', 'Intensely hoppy double IPA for hop lovers.', 8.5, 90, @user1, @ipa, @brewery1, '2024-07-01'),
    (@beer10, 'Vanilla Porter', 'Smooth porter infused with vanilla beans.', 6.2, 28, @user9, @porter, @brewery6, '2024-08-10'),
    (@beer11, 'Hefeweizen Classic', 'Traditional Bavarian wheat beer with banana and clove notes.', 5.4, 12, @user6, @wheat, @brewery5, '2024-09-05'),
    (@beer12, 'Imperial Stout', 'Full-bodied imperial stout aged in bourbon barrels.', 10.5, 50, @user2, @stout, @brewery2, '2024-10-01'),
    (@beer13, 'Belgian Bliss', 'Rich Belgian ale with notes of dark fruit and subtle spice.', 7.5, 25, @user4, @belgian, @brewery9, '2024-07-10'),
    (@beer14, 'Copper Crown', 'Smooth amber ale with caramel sweetness and hop balance.', 5.6, 38, @user18, @amber, @brewery10, '2024-09-05'),
    (@beer15, 'Rustic Revival', 'Farmhouse saison with peppery yeast character.', 6.2, 28, @user20, @saison, @brewery11, '2024-10-15'),
    (@beer16, 'Nutty Brown', 'Classic brown ale with chocolate and hazelnut notes.', 5.3, 22, @user24, @brown, @brewery12, '2025-02-01'),
    (@beer17, 'Old Guardian', 'Aged barleywine with complex malt layers.', 11.2, 60, @user27, @barleywine, @brewery13, '2025-03-15'),
    (@beer18, 'Citrus Bomb IPA', 'Juicy IPA bursting with tropical fruit flavors.', 7.0, 75, @user12, @ipa, @brewery14, '2024-11-01'),
    (@beer19, 'Mosaic Dream', 'Single-hop IPA showcasing Mosaic hops.', 6.5, 68, @user12, @ipa, @brewery14, '2024-11-20'),
    (@beer20, 'Farm Fresh Lager', 'Crisp lager made with local grains.', 4.6, 20, @user8, @lager, @brewery15, '2024-05-15'),
    (@beer21, 'Midnight Express', 'Extra robust stout with espresso notes.', 8.5, 45, @user2, @stout, @brewery2, '2025-01-20'),
    (@beer22, 'Harvest Wheat', 'Seasonal wheat beer with honey and coriander.', 4.9, 18, @user6, @wheat, @brewery5, '2024-10-30'),
    (@beer23, 'Cherry Sunset Sour', 'Kettle sour with fresh cherry puree.', 5.8, 8, @user11, @sour, @brewery7, '2025-04-10'),
    (@beer24, 'Pacific Pale Ale', 'West Coast style pale ale with pine and citrus.', 5.8, 48, @user5, @ale, @brewery4, '2024-12-05'),
    (@beer25, 'Bohemian Pilsner', 'Traditional Czech pilsner with Saaz hops.', 5.2, 40, @user14, @pilsner, @brewery8, '2025-05-20'),
    (@beer26, 'Coffee Porter', 'Rich porter infused with cold brew coffee.', 6.0, 32, @user9, @porter, @brewery6, '2025-06-15'),
    (@beer27, 'Wild Ferment Ale', 'Brett-fermented Belgian ale with funky character.', 7.8, 20, @user4, @belgian, @brewery9, '2025-07-01'),
    (@beer28, 'Session IPA', 'Light and refreshing session IPA for all-day drinking.', 4.2, 45, @user1, @ipa, @brewery1, '2025-08-20');
COMMIT TRANSACTION;


----------------------------------------------------------------------------
-- BeerPostPhoto (20 beer photos)
----------------------------------------------------------------------------
BEGIN TRANSACTION;
INSERT INTO dbo.BeerPostPhoto
    (BeerPostID, PhotoID, LinkedAt)
VALUES
    (@beer1, @photo5, '2023-04-10'),
    (@beer2, @photo6, '2023-04-15'),
    (@beer3, @photo7, '2023-05-20'),
    (@beer4, @photo10, '2023-07-10'),
    (@beer5, @photo11, '2023-08-15'),
    (@beer6, @photo13, '2023-10-05'),
    (@beer7, @photo16, '2024-03-20'),
    (@beer8, @photo17, '2024-06-25'),
    (@beer9, @photo19, '2024-07-15'),
    (@beer10, @photo21, '2024-08-10'),
    (@beer11, @photo22, '2024-09-05'),
    (@beer12, @photo24, '2024-10-01'),
    (@beer13, @photo26, '2024-10-10'),
    (@beer14, @photo28, '2024-11-01'),
    (@beer15, @photo29, '2024-11-15'),
    (@beer16, @photo32, '2025-02-01'),
    (@beer17, @photo33, '2025-03-15'),
    (@beer18, @photo35, '2025-04-25'),
    (@beer19, @photo36, '2025-06-01'),
    (@beer20, @photo38, '2025-07-10');
COMMIT TRANSACTION;


----------------------------------------------------------------------------
-- Rating (50 ratings)
----------------------------------------------------------------------------
BEGIN TRANSACTION;
INSERT INTO dbo.Rating
    (RatingID, Score, RatedByID)
VALUES
    (@rating1, 5, @user2),
    (@rating2, 4, @user3),
    (@rating3, 5, @user4),
    (@rating4, 3, @user5),
    (@rating5, 4, @user6),
    (@rating6, 5, @user7),
    (@rating7, 4, @user8),
    (@rating8, 5, @user9),
    (@rating9, 3, @user10),
    (@rating10, 4, @user11),
    (@rating11, 5, @user12),
    (@rating12, 4, @user13),
    (@rating13, 5, @user14),
    (@rating14, 3, @user15),
    (@rating15, 4, @user16),
    (@rating16, 5, @user17),
    (@rating17, 4, @user18),
    (@rating18, 5, @user19),
    (@rating19, 3, @user20),
    (@rating20, 4, @user21),
    (@rating21, 5, @user22),
    (@rating22, 4, @user23),
    (@rating23, 5, @user24),
    (@rating24, 3, @user25),
    (@rating25, 4, @user26),
    (@rating26, 5, @user27),
    (@rating27, 4, @user28),
    (@rating28, 5, @user29),
    (@rating29, 3, @user30),
    (@rating30, 4, @user1),
    (@rating31, 5, @user3),
    (@rating32, 4, @user4),
    (@rating33, 5, @user6),
    (@rating34, 3, @user8),
    (@rating35, 4, @user9),
    (@rating36, 5, @user10),
    (@rating37, 4, @user11),
    (@rating38, 5, @user13),
    (@rating39, 3, @user14),
    (@rating40, 4, @user15),
    (@rating41, 5, @user16),
    (@rating42, 4, @user17),
    (@rating43, 5, @user18),
    (@rating44, 3, @user19),
    (@rating45, 4, @user20),
    (@rating46, 5, @user21),
    (@rating47, 4, @user22),
    (@rating48, 5, @user23),
    (@rating49, 3, @user24),
    (@rating50, 4, @user25);
COMMIT TRANSACTION;


----------------------------------------------------------------------------
-- BeerPostComment (30 beer comments)
----------------------------------------------------------------------------
BEGIN TRANSACTION;
INSERT INTO dbo.BeerPostComment
    (CommentText, PostedByID, RatingID)
VALUES
    ('This IPA is absolutely fantastic! Perfect balance of hops and malt.', @user2, @rating1),
    ('Love the citrus notes in this beer. Will definitely buy again!', @user3, @rating2),
    ('Rich and smooth stout. The chocolate flavor is amazing.', @user4, @rating3),
    ('Good lager, very refreshing on a hot day.', @user5, @rating4),
    ('Nice pale ale, but could use a bit more hop character.', @user6, @rating5),
    ('Best wheat beer I''ve had in a while!', @user7, @rating6),
    ('Solid porter with great roasted malt flavor.', @user8, @rating7),
    ('This sour ale is perfectly tart and refreshing.', @user9, @rating8),
    ('Decent pilsner, nothing special but drinkable.', @user10, @rating9),
    ('The double IPA lives up to its name - super hoppy!', @user11, @rating10),
    ('Vanilla porter is a unique and delicious combination.', @user12, @rating11),
    ('Classic hefeweizen with authentic Bavarian character.', @user13, @rating12),
    ('Belgian Bliss is truly blissful! Amazing complexity.', @user22, @rating21),
    ('Copper Crown has the perfect amber color and taste.', @user23, @rating22),
    ('This saison is incredibly refreshing and unique.', @user24, @rating23),
    ('Barleywine is a bit too strong for my taste.', @user25, @rating24),
    ('Love the citrus bomb! Perfect for IPA lovers.', @user26, @rating25),
    ('Mosaic Dream lives up to its name - dreamy!', @user27, @rating26),
    ('Farm fresh lager is exactly that - fresh and clean.', @user28, @rating27),
    ('Midnight Express gives me the perfect coffee kick.', @user29, @rating28),
    ('Harvest wheat is okay, but I prefer traditional wheats.', @user30, @rating29),
    ('Cherry sunset sour is perfectly balanced.', @user1, @rating30),
    ('Pacific Pale Ale brings back West Coast memories.', @user3, @rating31),
    ('Bohemian Pilsner is as authentic as it gets.', @user4, @rating32),
    ('Coffee porter is my new favorite breakfast beer!', @user6, @rating33),
    ('Wild ferment is interesting but not for everyone.', @user8, @rating34),
    ('Session IPA is perfect for summer afternoons.', @user9, @rating35),
    ('Nutty brown ale has incredible depth of flavor.', @user10, @rating36),
    ('Old Guardian is a masterpiece of brewing.', @user11, @rating37),
    ('Imperial Stout deserves all the awards.', @user13, @rating38);
COMMIT TRANSACTION;


----------------------------------------------------------------------------
-- BreweryPostComment (20 brewery comments)
----------------------------------------------------------------------------
BEGIN TRANSACTION;
INSERT INTO dbo.BreweryPostComment
    (CommentText, PostedByID, RatingID)
VALUES
    ('Amazing brewery! The taproom has a great atmosphere.', @user14, @rating13),
    ('Love supporting local breweries like this one.', @user15, @rating14),
    ('Good selection of beers, but service could be better.', @user16, @rating15),
    ('Best brewery in the area, hands down!', @user17, @rating16),
    ('Nice facility and friendly staff. Will visit again.', @user18, @rating17),
    ('Great variety of beer styles. Something for everyone.', @user19, @rating18),
    ('Decent brewery but a bit pricey.', @user20, @rating19),
    ('Fantastic sour beer selection! Worth the trip.', @user21, @rating20),
    ('Belgian House has the most authentic Belgian beers outside Belgium!', @user14, @rating39),
    ('Amber Fields creates consistently excellent amber ales.', @user15, @rating40),
    ('Farmhouse Funk is a must-visit for sour beer enthusiasts.', @user16, @rating41),
    ('Brown Bear Brewing has a cozy atmosphere and great beer.', @user17, @rating42),
    ('Vintage Vats ages their beers to perfection.', @user18, @rating43),
    ('Hop Haven is always pushing boundaries with new hops.', @user19, @rating44),
    ('Barrel & Grain sources locally and it shows in quality.', @user20, @rating45),
    ('Hoppy Trails never disappoints with their IPAs.', @user21, @rating46),
    ('Dark Horse makes the best stouts in the region.', @user22, @rating47),
    ('Golden Gate Lager House is my -to for crisp lagers.', @user23, @rating48),
    ('Mountain View Ales has incredible views and incredible beer.', @user24, @rating49),
    ('Coastal Wheat Works perfects the art of wheat beer.', @user25, @rating50);
COMMIT TRANSACTION;


----------------------------------------------------------------------------
-- END OF TEST DATA
----------------------------------------------------------------------------
-- print user with most followers


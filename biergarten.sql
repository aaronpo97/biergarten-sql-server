----------------------------------------------------------------------------
----------------------------------------------------------------------------

USE master;

IF EXISTS (SELECT name
FROM sys.databases
WHERE name = N'Biergarten')
BEGIN
	ALTER DATABASE Biergarten SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
END
GO

DROP DATABASE IF EXISTS Biergarten;
GO

CREATE DATABASE Biergarten;
GO

USE Biergarten;

----------------------------------------------------------------------------
----------------------------------------------------------------------------

CREATE TABLE UserAccount
(
	UserAccountID UNIQUEIDENTIFIER
		CONSTRAINT DF_UserAccountID	DEFAULT NEWID(),

	Username VARCHAR(64) NOT NULL,

	FirstName NVARCHAR(128) NOT NULL,

	LastName NVARCHAR(128) NOT NULL,

	Email VARCHAR(128) NOT NULL,

	CreatedAt DATETIME NOT NULL,

	UpdatedAt DATETIME,

	DateOfBirth DATETIME NOT NULL,

	CONSTRAINT PK_UserAccount 
		PRIMARY KEY (UserAccountID),

	CONSTRAINT AK_Username
		UNIQUE (Username),

	CONSTRAINT AK_Email
		UNIQUE (Email),

);
----------------------------------------------------------------------------
----------------------------------------------------------------------------
CREATE TABLE Comment
(
	CommentID UNIQUEIDENTIFIER
		CONSTRAINT DF_CommentID DEFAULT NEWID(),

	CommentText NVARCHAR(512),

	PostedByID UNIQUEIDENTIFIER NOT NULL,

	CONSTRAINT PK_CommentID
		PRIMARY KEY (CommentID),

	CONSTRAINT FK_PostedByID
		FOREIGN KEY (PostedByID) REFERENCES UserAccount(UserAccountID),
)

CREATE NONCLUSTERED INDEX IX_Comment_PostedByID
ON Comment(PostedByID);

----------------------------------------------------------------------------
----------------------------------------------------------------------------

CREATE TABLE Photo -- All photos must be linked to a user account, you cannot delete a user account if they have uploaded photos
(
	PhotoID UNIQUEIDENTIFIER
		CONSTRAINT DF_PhotoID DEFAULT NEWID(),

	Hyperlink NVARCHAR(256),
	-- storage is handled via filesystem or cloud service

	UploadedByID UNIQUEIDENTIFIER NOT NULL,

	UploadedAt DATETIME NOT NULL
		CONSTRAINT DF_Photo_UploadedAt DEFAULT GETDATE(),

	CONSTRAINT PK_Photo
		PRIMARY KEY (PhotoID),

	CONSTRAINT FK_Photo_UploadedBy
		FOREIGN KEY (UploadedByID)
		REFERENCES UserAccount(UserAccountID)
		ON DELETE NO ACTION
);

CREATE NONCLUSTERED INDEX IX_Photo_UploadedByID
	ON Photo(UploadedByID);

----------------------------------------------------------------------------
----------------------------------------------------------------------------

CREATE TABLE UserAvatar -- delete avatar photo when user account is deleted
(
	UserAvatarID UNIQUEIDENTIFIER
		CONSTRAINT DF_UserAvatarID DEFAULT NEWID(),

	UserAccountID UNIQUEIDENTIFIER NOT NULL,

	PhotoID UNIQUEIDENTIFIER NOT NULL,

	CONSTRAINT PK_UserAvatar PRIMARY KEY (UserAvatarID),

	CONSTRAINT FK_UserAvatar_UserAccount
		FOREIGN KEY (UserAccountID)
		REFERENCES UserAccount(UserAccountID)
		ON DELETE CASCADE,

	CONSTRAINT FK_UserAvatar_PhotoID
		FOREIGN KEY (PhotoID)
		REFERENCES Photo(PhotoID),

	CONSTRAINT AK_UserAvatar_UserAccountID
		UNIQUE (UserAccountID)
)

CREATE NONCLUSTERED INDEX IX_UserAvatar_UserAccount
	ON UserAvatar(UserAccountID);

----------------------------------------------------------------------------
----------------------------------------------------------------------------

CREATE TABLE UserVerification -- delete verification data when user account is deleted
(
	UserVerificationID UNIQUEIDENTIFIER
		CONSTRAINT DF_UserVerificationID DEFAULT NEWID(),

	UserAccountID UNIQUEIDENTIFIER NOT NULL,

	VerificationDateTime DATETIME NOT NULL
		CONSTRAINT DF_VerificationDateTime 
		DEFAULT GETDATE(),

	CONSTRAINT PK_UserVerification 
		PRIMARY KEY (UserVerificationID),

	CONSTRAINT FK_UserVerification_UserAccount 
		FOREIGN KEY (UserAccountID) 
		REFERENCES UserAccount(UserAccountID)
		ON DELETE CASCADE,

	CONSTRAINT AK_UserVerification_UserAccountID
		UNIQUE (UserAccountID)
);

CREATE NONCLUSTERED INDEX IX_UserVerification_UserAccount
	ON UserVerification(UserAccountID);

----------------------------------------------------------------------------
----------------------------------------------------------------------------

CREATE TABLE UserCredential -- delete credentials when user account is deleted
(
	UserCredentialID UNIQUEIDENTIFIER
		CONSTRAINT DF_UserCredentialID DEFAULT NEWID(),

	UserAccountID UNIQUEIDENTIFIER NOT NULL,

	CreatedAt DATETIME
		CONSTRAINT DF_UserCredential_CreatedAt DEFAULT GETDATE() NOT NULL,

	Expiry DATETIME
		CONSTRAINT DF_UserCredential_Expiry DEFAULT DATEADD(DAY, 90, GETDATE()) NOT NULL,

	Hash NVARCHAR(100) NOT NULL,
	-- uses argon2

	CONSTRAINT PK_UserCredential
		PRIMARY KEY (UserCredentialID),

	CONSTRAINT FK_UserCredential_UserAccount
		FOREIGN KEY (UserAccountID)
		REFERENCES UserAccount(UserAccountID)
		ON DELETE CASCADE,

	CONSTRAINT AK_UserCredential_UserAccountID
		UNIQUE (UserAccountID)
);

CREATE NONCLUSTERED INDEX IX_UserCredential_UserAccount
	ON UserCredential(UserAccountID);

----------------------------------------------------------------------------
----------------------------------------------------------------------------

CREATE TABLE UserFollow
(
	UserFollowID UNIQUEIDENTIFIER
		CONSTRAINT DF_UserFollowID DEFAULT NEWID(),

	UserAccountID UNIQUEIDENTIFIER NOT NULL,

	FollowingID UNIQUEIDENTIFIER NOT NULL,

	CreatedAt DATETIME
		CONSTRAINT DF_UserFollow_CreatedAt DEFAULT GETDATE() NOT NULL,

	CONSTRAINT PK_UserFollow
		PRIMARY KEY (UserFollowID),

	CONSTRAINT FK_UserFollow_UserAccount
		FOREIGN KEY (UserAccountID) 
		REFERENCES UserAccount(UserAccountID),

	CONSTRAINT FK_UserFollow_UserAccountFollowing
		FOREIGN KEY (FollowingID)
		REFERENCES UserAccount(UserAccountID),

	CONSTRAINT CK_CannotFollowOwnAccount
		CHECK (UserAccountID != FollowingID)
);

CREATE NONCLUSTERED INDEX IX_UserFollow_UserAccount_FollowingID 
	ON UserFollow(UserAccountID, FollowingID);

CREATE NONCLUSTERED INDEX IX_UserFollow_FollowingID_UserAccount
	ON UserFollow(FollowingID, UserAccountID);

----------------------------------------------------------------------------
----------------------------------------------------------------------------

CREATE TABLE BreweryPost -- A user cannot be deleted if they have a post
(
	BreweryPostID UNIQUEIDENTIFIER
		CONSTRAINT DF_BreweryPostID DEFAULT NEWID(),

	PostedByID UNIQUEIDENTIFIER NOT NULL,

	Description NVARCHAR(512) NOT NULL,

	CreatedAt DATETIME NOT NULL
		CONSTRAINT DF_BreweryPost_CreatedAt DEFAULT GETDATE(),

	UpdatedAt DATETIME NULL,

	CONSTRAINT PK_BreweryPost 
		PRIMARY KEY (BreweryPostID),

	CONSTRAINT FK_BreweryPost_UserAccount
		FOREIGN KEY (PostedByID)
		REFERENCES UserAccount(UserAccountID)
		ON DELETE NO ACTION
)

CREATE NONCLUSTERED INDEX IX_BreweryPost_PostedByID
	ON BreweryPost(PostedByID);

----------------------------------------------------------------------------
----------------------------------------------------------------------------

CREATE TABLE BreweryPostPhoto -- All photos linked to a post are deleted if the post is deleted
(
	BreweryPostPhotoID UNIQUEIDENTIFIER
		CONSTRAINT DF_BreweryPostPhotoID DEFAULT NEWID(),

	BreweryPostID UNIQUEIDENTIFIER NOT NULL,

	PhotoID UNIQUEIDENTIFIER NOT NULL,

	LinkedAt DATETIME NOT NULL
		CONSTRAINT DF_BreweryPostPhoto_LinkedAt DEFAULT GETDATE(),

	CONSTRAINT PK_BreweryPostPhoto
		PRIMARY KEY (BreweryPostPhotoID),

	CONSTRAINT FK_BreweryPostPhoto_BreweryPost
		FOREIGN KEY (BreweryPostID)
		REFERENCES BreweryPost(BreweryPostID)
		ON DELETE CASCADE,

	CONSTRAINT FK_BreweryPostPhoto_Photo
		FOREIGN KEY (PhotoID)
		REFERENCES Photo(PhotoID)
		ON DELETE CASCADE
);

CREATE NONCLUSTERED INDEX IX_BreweryPostPhoto_Photo_BreweryPost
ON BreweryPostPhoto(PhotoID, BreweryPostID);

CREATE NONCLUSTERED INDEX IX_BreweryPostPhoto_BreweryPost_Photo
ON BreweryPostPhoto(BreweryPostID, PhotoID);

----------------------------------------------------------------------------
----------------------------------------------------------------------------
CREATE TABLE BeerStyle
(
	BeerStyleID UNIQUEIDENTIFIER
		CONSTRAINT DF_BeerStyleID DEFAULT NEWID(),

	StyleName NVARCHAR(100) NOT NULL,

	Description NVARCHAR(MAX),

	CONSTRAINT PK_BeerStyle
		PRIMARY KEY (BeerStyleID),

	CONSTRAINT AK_BeerStyle_StyleName
		UNIQUE (StyleName)
);

----------------------------------------------------------------------------
----------------------------------------------------------------------------

CREATE TABLE BeerPost
(
	BeerPostID UNIQUEIDENTIFIER
		CONSTRAINT DF_BeerPostID DEFAULT NEWID(),

	Name NVARCHAR(100) NOT NULL,

	Description NVARCHAR(MAX),

	ABV DECIMAL(4,2),
	-- Alcohol By Volume (typically 0-67%)

	IBU INT,
	-- International Bitterness Units (typically 0-100)

	PostedByID UNIQUEIDENTIFIER NOT NULL,

	BeerStyleID UNIQUEIDENTIFIER NOT NULL,

	BrewedByID UNIQUEIDENTIFIER NOT NULL,

	CreatedAt DATETIME NOT NULL
		CONSTRAINT DF_BeerPost_CreatedAt DEFAULT GETDATE(),

	UpdatedAt DATETIME,

	CONSTRAINT PK_BeerPost 
        PRIMARY KEY (BeerPostID),

	CONSTRAINT FK_BeerPost_PostedBy
        FOREIGN KEY (PostedByID)
        REFERENCES UserAccount(UserAccountID),

	CONSTRAINT FK_BeerPost_BeerStyle
		FOREIGN KEY (BeerStyleID)
		REFERENCES BeerStyle(BeerStyleID),

	CONSTRAINT FK_BeerPost_Brewery
		FOREIGN KEY (BrewedByID)
		REFERENCES BreweryPost(BreweryPostID),

	CONSTRAINT CHK_BeerPost_ABV 
        CHECK (ABV >= 0 AND ABV <= 67),

	CONSTRAINT CHK_BeerPost_IBU 
        CHECK (IBU >= 0 AND IBU <= 120)
);

CREATE NONCLUSTERED INDEX IX_BeerPost_PostedBy
    ON BeerPost(PostedByID);

CREATE NONCLUSTERED INDEX IX_BeerPost_BeerStyle
	ON BeerPost(BeerStyleID);

CREATE NONCLUSTERED INDEX IX_BeerPost_BrewedBy
	ON BeerPost(BrewedByID);

----------------------------------------------------------------------------
----------------------------------------------------------------------------

CREATE TABLE BeerPostPhoto -- All photos linked to a beer post are deleted if the post is deleted
(
	BeerPostPhotoID UNIQUEIDENTIFIER
		CONSTRAINT DF_BeerPostPhotoID DEFAULT NEWID(),

	BeerPostID UNIQUEIDENTIFIER NOT NULL,

	PhotoID UNIQUEIDENTIFIER NOT NULL,

	LinkedAt DATETIME NOT NULL
		CONSTRAINT DF_BeerPostPhoto_LinkedAt DEFAULT GETDATE(),

	CONSTRAINT PK_BeerPostPhoto
		PRIMARY KEY (BeerPostPhotoID),

	CONSTRAINT FK_BeerPostPhoto_BeerPost
		FOREIGN KEY (BeerPostID)
		REFERENCES BeerPost(BeerPostID)
		ON DELETE CASCADE,

	CONSTRAINT FK_BeerPostPhoto_Photo
		FOREIGN KEY (PhotoID)
		REFERENCES Photo(PhotoID)
		ON DELETE CASCADE
);

CREATE NONCLUSTERED INDEX IX_BeerPostPhoto_Photo_BeerPost
ON BeerPostPhoto(PhotoID, BeerPostID);

CREATE NONCLUSTERED INDEX IX_BeerPostPhoto_BeerPost_Photo
ON BeerPostPhoto(BeerPostID, PhotoID);

----------------------------------------------------------------------------
----------------------------------------------------------------------------

USE Biergarten;
GO

CREATE OR ALTER PROCEDURE usp_CreateUserAccount
(
    @UserAccountId UNIQUEIDENTIFIER = NULL,
    @Username VARCHAR(64),
    @FirstName NVARCHAR(128),
    @LastName NVARCHAR(128),
    @DateOfBirth DATETIME,
    @Email VARCHAR(128)
)
AS
BEGIN
    SET NOCOUNT ON
    SET XACT_ABORT ON
    BEGIN TRANSACTION

    INSERT INTO UserAccount 
    (
        UserAccountID,
        Username,
        FirstName,
        LastName,
        DateOfBirth,
        Email
    )
    VALUES
    (
        COALESCE(@UserAccountId, NEWID()),
        @Username,
        @FirstName,
        @LastName,
        @DateOfBirth,
        @Email
    );



    COMMIT TRANSACTION
END;
GO

CREATE OR ALTER PROCEDURE usp_DeleteUserAccount
(
    @UserAccountId UNIQUEIDENTIFIER
)
AS
BEGIN
    SET NOCOUNT ON
    SET XACT_ABORT ON
    BEGIN TRANSACTION

    IF NOT EXISTS (SELECT 1 FROM UserAccount WHERE UserAccountId = @UserAccountId)
    BEGIN
        RAISERROR('UserAccount with the specified ID does not exist.', 16,
        1);
        ROLLBACK TRANSACTION
        RETURN
    END

    DELETE FROM UserAccount 
    WHERE UserAccountId = @UserAccountId;
    COMMIT TRANSACTION
END;
GO


CREATE OR ALTER PROCEDURE usp_UpdateUserAccount
(
    @Username VARCHAR(64),
    @FirstName NVARCHAR(128),
    @LastName NVARCHAR(128),
    @DateOfBirth DATETIME,
    @Email VARCHAR(128),
    @UserAccountId UNIQUEIDENTIFIER
)
AS
BEGIN
    SET NOCOUNT ON
    SET XACT_ABORT ON
    BEGIN TRANSACTION

    IF NOT EXISTS (SELECT 1 FROM UserAccount WHERE UserAccountId = @UserAccountId)
    BEGIN
        RAISERROR('UserAccount with the specified ID does not exist.', 16,
        1);
        ROLLBACK TRANSACTION
        RETURN
    END 

    UPDATE UserAccount
    SET
        Username = @Username,
        FirstName = @FirstName,
        LastName = @LastName,
        DateOfBirth = @DateOfBirth,
        Email = @Email
    WHERE UserAccountId = @UserAccountId;

    COMMIT TRANSACTION
END;
GO

CREATE OR ALTER PROCEDURE usp_GetUserAccountById
(
    @UserAccountId UNIQUEIDENTIFIER
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT UserAccountID,
           Username,
           FirstName,
           LastName,
           Email,
           CreatedAt,
           UpdatedAt,
           DateOfBirth,
           Timer
    FROM dbo.UserAccount
    WHERE UserAccountID = @UserAccountId;
END;
GO

CREATE OR ALTER PROCEDURE usp_GetAllUserAccounts
AS
BEGIN
    SET NOCOUNT ON;

    SELECT UserAccountID,
           Username,
           FirstName,
           LastName,
           Email,
           CreatedAt,
           UpdatedAt,
           DateOfBirth,
           Timer
    FROM dbo.UserAccount;
END;
GO

CREATE OR ALTER PROCEDURE usp_GetUserAccountByUsername
(
    @Username VARCHAR(64)
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT UserAccountID,
           Username,
           FirstName,
           LastName,
           Email,
           CreatedAt,
           UpdatedAt,
           DateOfBirth,
           Timer
    FROM dbo.UserAccount
    WHERE Username = @Username;
END;
GO

CREATE OR ALTER PROCEDURE usp_GetUserAccountByEmail
(
    @Email VARCHAR(128)
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT UserAccountID,
           Username,
           FirstName,
           LastName,
           Email,
           CreatedAt,
           UpdatedAt,
           DateOfBirth,
           Timer
    FROM dbo.UserAccount
    WHERE Email = @Email;
END;
GO

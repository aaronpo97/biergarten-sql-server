USE Biergarten;
GO

IF TYPE_ID(N'dbo.TblUserHashes') IS NULL
    EXEC('CREATE TYPE dbo.TblUserHashes AS TABLE
          (
              UserAccountId UNIQUEIDENTIFIER NOT NULL,
              Hash NVARCHAR(MAX) NOT NULL
          );');
GO

-- Stored procedure to insert Argon2 hashes
CREATE OR ALTER PROCEDURE dbo.USP_AddUserCredentials
    (
    @Hash dbo.TblUserHashes READONLY
)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRANSACTION;

    INSERT INTO dbo.UserCredential
        (UserAccountId, Hash)
    SELECT
        uah.UserAccountId,
        uah.Hash
    FROM @Hash AS uah;

    COMMIT TRANSACTION;
END;
GO

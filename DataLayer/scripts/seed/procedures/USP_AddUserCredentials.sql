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

CREATE OR ALTER PROCEDURE dbo.USP_AddUserCredential(
    @UserAccountId uniqueidentifier,
    @Hash nvarchar(max)
)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRANSACTION;

    INSERT INTO dbo.UserCredential
        (UserAccountId, Hash)
    VALUES 
        (@UserAccountId, @Hash);

    COMMIT TRANSACTION;
END;
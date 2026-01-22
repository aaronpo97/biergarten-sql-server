CREATE OR ALTER PROCEDURE dbo.USP_AddUpdateUserCredential(
    @UserAccountId UNIQUEIDENTIFIER,
    @Hash NVARCHAR(MAX)
)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRANSACTION;

    IF NOT EXISTS (
        SELECT 1 
        FROM dbo.UserAccount 
        WHERE UserAccountID = @UserAccountId
    )
        THROW 50001, 'UserAccountID does not exist.', 1;
    

    -- invalidate old credentials
    UPDATE dbo.UserCredential 
    SET IsRevoked = 1,
        RevokedAt = GETDATE()
    WHERE UserAccountId = @UserAccountId
      AND IsRevoked = 0;
      
    INSERT INTO dbo.UserCredential
        (UserAccountId, Hash)
    VALUES 
        (@UserAccountId, @Hash);

    COMMIT TRANSACTION;
END;
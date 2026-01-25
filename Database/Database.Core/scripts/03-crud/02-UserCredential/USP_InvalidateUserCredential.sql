CREATE OR ALTER PROCEDURE dbo.USP_InvalidateUserCredential(
    @UserAccountId UNIQUEIDENTIFIER
)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRANSACTION;

    IF NOT EXISTS (SELECT 1
                   FROM dbo.UserAccount
                   WHERE UserAccountID = @UserAccountId)
        ROLLBACK TRANSACTION 
    

    -- invalidate all other credentials by setting them to revoked
    UPDATE dbo.UserCredential
    SET IsRevoked = 1,
        RevokedAt = GETDATE()
    WHERE UserAccountId = @UserAccountId AND IsRevoked != 1;
    

    COMMIT TRANSACTION;
END;
CREATE OR ALTER PROCEDURE dbo.USP_CreateUserVerification
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRANSACTION;

    INSERT INTO dbo.UserVerification
        (UserAccountId)
    SELECT
        ua.UserAccountID
    FROM dbo.UserAccount AS ua
    WHERE NOT EXISTS
            (SELECT 1
    FROM dbo.UserVerification AS uv
    WHERE uv.UserAccountId = ua.UserAccountID);


    IF (SELECT COUNT(*)
    FROM dbo.UserVerification) 
        != (SELECT COUNT(*)
    FROM dbo.UserAccount)
    BEGIN
        RAISERROR('UserVerification count does not match UserAccount count after insertion.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    COMMIT TRANSACTION;
END

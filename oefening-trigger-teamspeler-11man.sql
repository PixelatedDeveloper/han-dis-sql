INSERT Teamspelers (rugnr, spelersnaam) VALUES (99,'van der Vaart')


select * from Teamspelers

ALTER TRIGGER TRG_Teamspelers_INS
ON Teamspelers 
AFTER INSERT
AS
BEGIN
  -- etc.
  BEGIN TRY
  	DECLARE @rowsAffected INT
    IF @rowsAffected > 0 
    BEGIN
      IF (SELECT COUNT(*) FROM Teamspelers) > 11
		BEGIN
			WAITFOR DELAY '00:00:10'
	
      BEGIN
			RAISERROR ('Maximaal 11 spelers in het team.', 16, 1)
		-- etc.
		ROLLBACK TRANSACTION
	END -- trigger

      END
    END
  END TRY
  BEGIN CATCH -- etc.
  END CATCH
END

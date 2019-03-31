create trigger testtrigger
ON 
AFTER UPDATE Stuk
AS
BEGIN
SET @rows = @@ROWCOUNT

IF @@ROWCOUNT = 0 RETURN

IF NOT UPDATE(niveaucode) RETURN

BEGIN TRY
	INSERT activitylog (note)
	SELECT 'value '+ DELETED.niveaucode + 'changed to' + ISNULL(inserted.niveaucode)
	FROM INSERTED INNER JOIN DELETED 
		ON INSERTED.stuknr = DELETED.stuknr
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
	ROLLBACK TRAN

	'error handling'


END CATCH


END
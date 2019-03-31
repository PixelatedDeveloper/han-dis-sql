create proc spMal
AS
BEGIN
	BEGIN TRY
		Declare @trancount INT
		select @trancount = @@TRANCOUNT
		IF @trancount > 0
			BEGIN
				SAVE TRAN transave
			END
		ELSE

			BEGIN TRAN
				INSERT test (col) VALUES (1)
				IF @trancount = 0
					commit tran
	END TRY
	BEGIN CATCH






begin try 
BEGIN TRAN
	EXEC spMal
COMMIT TRAN
end try
begin catch
          ERROR_NUMBER() as ErrorNumber,
          ERROR_MESSAGE() as ErrorMessage;
          rollback tran
end catch

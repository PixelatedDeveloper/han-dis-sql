create trigger opgave1
on ArticleIngredient
after delete
as 
begin
	declare @rowcount int
	select @rowcount = @@ROWCOUNT
		if @rowcount = 0
		return

	begin try
		declare @articleid

	if exists (SELECT a.articleID FROM Article a inner join ArticleIngredient ai on a.articleid = ai.articleid group by a.articleID HAVING COUNT(ai.ingredientID) < 2)
		BEGIN
			DELETE articleID from ArticleIngredient where articleID = @articleid
		END
	ELSE 
		BEGIN
			rollback transaction
			raiserror ('Er zijn meer dan twee ingredienten voor dit artikel', 16,1)
		END	
	end try
	begin catch
	
		declare	@ErrorMsg	VARCHAR(400),
				@ErrorSeverity	INT,
				@ErrorState	INT
	
		select	@ErrorMsg	= ERROR_MESSAGE(),
				@ErrorSeverity	= ERROR_SEVERITY(),
				@ErrorState	= ERROR_STATE()
		RAISERROR (@ErrorMessage , @ErrorSeverity, @ErrorState)
			IF @@TRANCOUNT > 0 BEGIN ROLLBACK TRANSACTION
			end
		return	
	
	end catch


--opgave 2
create trigger opgave2
on ArticleIngredient
after insert
as
begin
	declare @rowcount int
	select @rowcount = @@ROWCOUNT
		if @rowcount = 0
		return
	
	begin try
		declare @ingredientid INT
		declare @description varchar(50)

		if exists (select a.articleID from Article a inner join Production p
						ON a.articleID = p.articleID
					where ProdDate <= GETDATE() )
			begin
				insert into ArticleIngredient VALUES (@ingredientid, @description)
			end
		else
		begin
			rollback transaction
			raiserror ('Er mogen geen ingredienten meer toegevoegd worden', 16,1)
		end	
	end try
	
	begin catch
	
	declare	@ErrorMsg	VARCHAR(400),
			@ErrorSeverity	INT,
			@ErrorState	INT
	
	select	@ErrorMsg	= ERROR_MESSAGE(),
			@ErrorSeverity	= ERROR_SEVERITY(),
			@ErrorState	= ERROR_STATE()
	RAISERROR (@ErrorMsg , @ErrorSeverity, @ErrorState)
		IF @@TRANCOUNT > 0 BEGIN ROLLBACK TRANSACTION
		end
	return	
	
	end catch
end


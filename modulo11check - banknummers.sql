CREATE FUNCTION checkModulo11 (@accountNr INT)
  RETURNS INT	-- returnwaarde 0 is ok, anders niet ok
AS
BEGIN
  DECLARE @result INT
  SELECT @result = 0

  DECLARE @workingNr INT
  SELECT @workingNr = @accountNr

  DECLARE @count INT
  SELECT @count = 1

  WHILE @count < 10
  BEGIN
    DECLARE @rest TINYINT
    SELECT @rest	  = @workingNr%10
    SELECT @workingNr = @workingNr/10
    SELECT @result	  = @rest*@count + @result
    SELECT @count	  = @count + 1
  END
  
  RETURN @result%11
END

--- Test
SELECT dbo.checkModulo11(972428575)
SELECT dbo.checkModulo11(972428577)


CREATE TABLE accountTest (
  col1 INT IDENTITY,
  accountNr INT NOT NULL
    CONSTRAINT CK_MODULO11 CHECK (dbo.checkModulo11(accountNr) = 0)
)

INSERT accountTest (accountNr) values (972428576)
INSERT accountTest (accountNr) VALUES (972428577)

SELECT * FROM accountTest


SELECT DATENAME(dw, GETDATE())
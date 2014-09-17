USE [dbPLD]
GO

IF EXISTS(SELECT 1 FROM SYSOBJECTS WHERE NAME='sp_PopFirstWord' AND TYPE='P')
	DROP PROCEDURE sp_PopFirstWord
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_PopFirstWord]  
    @SourceString   NVARCHAR(4000) = NULL OUTPUT,  
    @FirstWord      NVARCHAR(4000) = NULL OUTPUT  
AS  
    SET NOCOUNT ON  
  
    -- Procedure accepts a comma delimited string as the first parameter  
    -- Procedure outputs the first word in the second parameter  
    -- Procedure outputs the remainder of the delimeted string in the first parameter  
    -- Procedure yields the length of the First Word as the return value  
  
    DECLARE @Oldword        NVARCHAR(4000)  
    DECLARE @Length         INT  
    DECLARE @CommaLocation  INT  
  
    SELECT @Oldword = @SourceString  
  
    IF NOT @Oldword IS NULL  
    BEGIN  
        SELECT @CommaLocation = CHARINDEX(' ',@Oldword)  
        SELECT @Length = DATALENGTH(@Oldword)  
  
        IF @CommaLocation = 0  
        BEGIN  
            SELECT @FirstWord = @Oldword  
            SELECT @SourceString = NULL  
  
	    --IF @Length = '' BEGIN  SET @Length = NULL END
            RETURN @Length  
        END  
  
        SELECT @FirstWord = SUBSTRING(@Oldword, 1, @CommaLocation -1)  
        SELECT @SourceString = SUBSTRING(@Oldword, @CommaLocation + 1, @Length - @CommaLocation)  
  
	IF @Length - @CommaLocation = '' 
	BEGIN  
		RETURN @Length 
	END
	ELSE 
	BEGIN 
        	RETURN @Length - @CommaLocation  
	END 
    END  
  
    RETURN 0  
------------------------------------------------  
GO
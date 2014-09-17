USE [dbCatalogosGrales]
GO

/****** Object:  StoredProcedure [dbo].[stp_BuscarListaNegra]    Script Date: 04/22/2013 10:06:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (	SELECT							1
			FROM							SYSOBJECTS
			WHERE							NAME = 'FormatoNombreAp'
			AND								TYPE = 'P' )
	DROP PROCEDURE		FormatoNombreAp
GO
CREATE FUNCTION [dbo].[FormatoNombreAp]
	(
	@campoE varchar(500)
	)
RETURNS VARCHAR(500)
AS
BEGIN
	/*
	DECLARE @campoS VARCHAR(50)			
	SET @campoS	= RTRIM(LTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@campoE, '�', 'A'), '�', 'E'), '�', 'I'), '�', 'O'), '�', 'U'), '�', 'U'), ' ', '')))
	RETURN upper(@campoS)
	*/	
	DECLARE @campoS VARCHAR(500)			
	SET @campoS	= REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(UPPER(@campoE), '�', 'A'), '�', 'E'), '�', 'I'), '�', 'O'), '�', 'U'), '�', 'U'), ' ', ''), ',', ''), '.', ''), ';', '')
	RETURN @campoS
END
GO
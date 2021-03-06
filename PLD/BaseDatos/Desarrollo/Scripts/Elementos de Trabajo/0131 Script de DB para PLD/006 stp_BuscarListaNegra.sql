
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('stp_BuscarListaNegra') )
BEGIN 
 DROP PROCEDURE stp_BuscarListaNegra
END 
GO
/*=================================================================
		AUTOR:			Victor Pineda Velázquez
		DESCRIPCION:	Listar los registros de la tabla Lista Negra
						tbl_MST_ListaNegra
		MODIFICACION:	
		FECHA DE CREACIÓN: 20-MARZO-2013	
=================================================================*/
CREATE PROCEDURE stp_BuscarListaNegra
	  @vchPersonaIncidenciaNombre varchar(100) = '',
	  @vchPersonaIncidenciaApPat varchar(100) = '',
	  @vchPersonaIncidenciaApMat varchar(100) = '',
	  @vchNombreCompleto varchar(300) = ''
AS
BEGIN	
	DECLARE @NOMBRE		AS VARCHAR(100)
	DECLARE @APPAT		AS VARCHAR(100)
	DECLARE @APMAT		AS VARCHAR(100)
	DECLARE @NOMBREC	AS VARCHAR(300)
	DECLARE @APPS		AS VARCHAR(200)
	DECLARE @NPM		AS VARCHAR(300)
	DECLARE @NMP		AS VARCHAR(300)	
	SET @vchPersonaIncidenciaNombre =	ISNULL(@vchPersonaIncidenciaNombre, '')
	SET @vchPersonaIncidenciaApPat =	ISNULL(@vchPersonaIncidenciaApPat, '')
	SET @vchPersonaIncidenciaApMat =	ISNULL(@vchPersonaIncidenciaApMat, '')
	SET @vchNombreCompleto =			ISNULL(@vchNombreCompleto, '')
	--	Existe solo los parámetros de nombre y apellidos 
	IF (@vchPersonaIncidenciaNombre <> '' AND @vchPersonaIncidenciaApPat <> '' AND @vchPersonaIncidenciaApMat <> '' AND @vchNombreCompleto = '')	
		BEGIN
		print 'opción 2'
		SET @NOMBRE =	dbo.FormatoNombreAp(@vchPersonaIncidenciaNombre)
		SET @APPAT =	dbo.FormatoNombreAp(@vchPersonaIncidenciaApPat)
		SET @APMAT =	dbo.FormatoNombreAp(@vchPersonaIncidenciaApMat)		
		SET @NPM =		@NOMBRE + @APPAT + @APMAT
		SET @NMP =		@NOMBRE + @APMAT + @APPAT	
			SELECT  TM.VCHIDQEQ,					TM.VCHTIPOLISTA,
					TC.vchIdentificadorInterno,		TM.VCHNOMCOMPLETO
			FROM    tbl_MST_ListaNegra TM INNER JOIN 
					tbl_CAT_TipoListaNegra TC ON TM.VCHTIPOLISTA = TC.VCHTIPOLISTA	
			WHERE 	-- Nombre + ApPat + ApMat					
					(TM.vchCadenaNMP		= @NMP		)	OR
					(TM.vchCadenaNPM		= @NPM		)
		print @NPM
		print @NMP
		END	
	-- Existe solo nombre completo		
	IF (@vchPersonaIncidenciaNombre = '' AND @vchPersonaIncidenciaApPat = '' AND @vchPersonaIncidenciaApMat = '' AND @vchNombreCompleto <> '')
		BEGIN
		print 'opción 4'
			SET @NOMBREC = dbo.FormatoNombreAp(@vchNombreCompleto)			
			SELECT  TM.VCHIDQEQ,					TM.VCHTIPOLISTA,
					TC.vchIdentificadorInterno,		TM.VCHNOMCOMPLETO
			FROM    tbl_MST_ListaNegra TM 
				INNER JOIN 
					tbl_CAT_TipoListaNegra TC ON TM.VCHTIPOLISTA = TC.VCHTIPOLISTA	
			WHERE 	-- NombreCompleto					
					(TM.vchCadenaNMP		= @NOMBREC		)	OR
					(TM.vchCadenaNPM		= @NOMBREC		)	
		PRINT @NOMBREC						
		END
END

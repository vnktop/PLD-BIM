USE [dbCatalogosGrales]
GO
/****** Object:  StoredProcedure [dbo].[stp_InsertarCaroline]    Script Date: 04/12/2013 13:33:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Haydeé Monroy
-- Create date: 11-Abril-2013
-- Description:	Inserta registros en la tabla
-- tbl_MST_WSCaroline
-- =============================================
ALTER PROCEDURE [dbo].[stp_InsertarCaroline]
	
	@intWSCarolineID		int output,
	@intTipoPersonaID		int,
	@intClienteID			int,
	@vchTipificacion		varchar(50),
	@intCalificacion		int,
	@datFecha				datetime
	
AS

IF @datFecha is NULL or @datFecha = ' '

BEGIN

SET @datFecha= (GETDATE())

END
BEGIN
	
	INSERT INTO tbl_MST_WSCaroline
		    (
			intTipoPersonaID,
			intClienteID,
			vchTipificacion,
			intCalificacion,
			datFecha)
	VALUES (@intTipoPersonaID,
			@intClienteID,
			@vchTipificacion,
			@intCalificacion,
			@datFecha)
			
	
	
	SELECT @intWSCarolineID = @@IDENTITY 
	
END


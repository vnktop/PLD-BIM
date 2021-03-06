USE [dbPLD]
GO

IF (OBJECT_ID('stp_InsertarTipoLista')) IS NOT NULL	
	DROP PROCEDURE [stp_InsertarTipoLista]
	
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[stp_InsertarTipoLista] 
	@intResultado			INT OUTPUT,   
	@vchTipoLista			VARCHAR(20),
	@intTipoTipificacionID	INT,
	@VCDDESCRIPCION			VARCHAR(256),
	@vchPais				VARCHAR(50)
AS     
BEGIN
	INSERT INTO tbl_CAT_TipoListaNegra (vchTipoLista,			
										intTipoTipificacionID,	
										VCDDESCRIPCION,			
										vchPais)
	VALUES (@vchTipoLista,													
			@intTipoTipificacionID,								
			@VCDDESCRIPCION,			
			@vchPais)
	SET @intResultado = @@ROWCOUNT
	SELECT @intResultado
	RETURN @intResultado
END
GO

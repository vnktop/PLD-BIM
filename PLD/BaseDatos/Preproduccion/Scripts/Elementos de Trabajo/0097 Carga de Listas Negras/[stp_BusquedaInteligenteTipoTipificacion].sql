USE [dbPLD]
GO

/****** Object:  StoredProcedure [dbo].[stp_BuscarListaNegra]    Script Date: 04/22/2013 10:06:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (	SELECT							1
			FROM							SYSOBJECTS
			WHERE							NAME = 'stp_BusquedaInteligenteTipoTipificacion'
			AND								TYPE = 'P' )
	DROP PROCEDURE		stp_BusquedaInteligenteTipoTipificacion
GO

CREATE PROCEDURE [dbo].[stp_BusquedaInteligenteTipoTipificacion]
	-- Add the parameters for the stored procedure here
	@Cadena		VARCHAR(2000)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
   
		SELECT			intTipoTipificacionID, vchDescripcion
		FROM			tbl_CAT_TipoTipificacion						
		WHERE		UPPER(REPLACE(ISNULL(vchDescripcion, ''), ' ', '%')) LIKE '%' + UPPER(@Cadena) + '%'
END

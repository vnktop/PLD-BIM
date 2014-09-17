USE [dbPLD]
GO

/****** Object:  StoredProcedure [dbo].[stp_CRUDConfiguracionPLD]    Script Date: 04/22/2013 10:03:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (	SELECT							1
			FROM							SYSOBJECTS
			WHERE							NAME = 'stp_ListarCatTipoLista'
			AND								TYPE = 'P' )
	DROP PROCEDURE		stp_ListarCatTipoLista
GO
CREATE PROCEDURE [dbo].[stp_ListarCatTipoLista]
AS 
BEGIN
	SELECT distinct vchTipoLista, intTipoListaID
	FROM tbl_CAT_TipoListaNegra	
	order by vchTipoLista asc
END

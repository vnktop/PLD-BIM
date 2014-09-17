USE [dbPLD]
GO

/****** Object:  StoredProcedure [dbo].[stp_ListarCatTipoListaNegra]    Script Date: 04/24/2013 12:21:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (	SELECT							1
			FROM							SYSOBJECTS
			WHERE							NAME = 'stp_ListarCatTipoListaNegra'
			AND								TYPE = 'P' )
	DROP PROCEDURE		stp_ListarCatTipoListaNegra
GO
/*=================================================================
		AUTOR:			Eliseo Díaz Díaz
		DESCRIPCION:	Listado del catálogo Tipo Lista Negra
		MODIFICACION:
		FECHA DE CREACIÓN: 19-MARZO-2013	
=================================================================*/
CREATE PROCEDURE [dbo].[stp_ListarCatTipoListaNegra]
AS 
BEGIN
	SELECT intTipoTipificacionID,vchDescripcion as vchDescripcion
	FROM tbl_CAT_TipoTipificacion	
END
--stp_ListarCatTipoListaNegra


USE [dbPLD]
GO

/****** Object:  StoredProcedure [dbo].[stp_CRUDConfiguracionPLD]    Script Date: 04/22/2013 10:03:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (	SELECT							1
			FROM							SYSOBJECTS
			WHERE							NAME = 'stp_ListarCatAccionesPLD'
			AND								TYPE = 'P' )
	DROP PROCEDURE		stp_ListarCatAccionesPLD
GO
/*=================================================================
		AUTOR:			Gilberto Feria
		DESCRIPCION:	Listado del catálogo de Acciones PLD
		MODIFICACION:
		FECHA DE CREACIÓN: 25-MARZO-2013	
=================================================================*/
CREATE PROCEDURE [dbo].[stp_ListarCatAccionesPLD]
AS 
BEGIN
	SELECT INTACCIONPLDID
      ,VCHDESCRIPCION
      ,BITESTATUS
  FROM tbl_CAT_AccionesPLD
	WHERE BITESTATUS =1
END

--stp_ListarCatAccionesPLD

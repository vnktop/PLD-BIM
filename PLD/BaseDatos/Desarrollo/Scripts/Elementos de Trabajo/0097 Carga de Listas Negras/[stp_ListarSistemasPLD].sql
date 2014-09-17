USE [dbPLD]
GO

/****** Object:  StoredProcedure [dbo].[stp_ListarCatTipoListaNegra]    Script Date: 04/24/2013 12:21:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (	SELECT							1
			FROM							SYSOBJECTS
			WHERE							NAME = 'stp_ListarSistemasPLD'
			AND								TYPE = 'P' )
	DROP PROCEDURE		stp_ListarSistemasPLD
GO
/*=================================================================
		AUTOR:			Gilberto Feria
		DESCRIPCION:	Listado del catálogo de Sitemas para configurar acciones  PLD
		MODIFICACION:
		FECHA DE CREACIÓN: 25-MARZO-2013	
=================================================================*/
CREATE PROCEDURE [dbo].[stp_ListarSistemasPLD]
AS 
BEGIN
SELECT CS.sintSistemaID
      ,CS.vchNombre
      ,CS.vchDescripcion
      ,case when count(RA.sintSistemaId)>0 
      then 1
      else 0
      end conf
  FROM dbSIE..tbl_CAT_Sistemas as  CS left join tbl_REL_AccionPLDListaNegra  RA on CS.sintSistemaId= RA.sintSistemaId
  where CS.sintSistemaId in(4,5,14,15)--faltan 2 sistemas
	and  CS.BITESTATUS =1
	group by CS.sintSistemaID,CS.vchNombre,CS.vchDescripcion
END


--exec stp_ListarSistemasPLD

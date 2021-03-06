
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('stp_ListarSistemasPLD') )
BEGIN 
 DROP PROCEDURE stp_ListarSistemasPLD
END 
GO
/*=================================================================
		AUTOR:			Gilberto Feria
		DESCRIPCION:	Listado del catálogo de Sitemas para configurar acciones  PLD
		MODIFICACION:
		FECHA DE CREACIÓN: 25-MARZO-2013	
=================================================================*/
CREATE PROCEDURE stp_ListarSistemasPLD
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
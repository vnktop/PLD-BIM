
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('stp_ListarCatAccionesPLD') )
BEGIN 
 DROP PROCEDURE stp_ListarCatAccionesPLD
END 
GO
/*=================================================================
		AUTOR:			Gilberto Feria
		DESCRIPCION:	Listado del catálogo de Acciones PLD
		MODIFICACION:
		FECHA DE CREACIÓN: 25-MARZO-2013	
=================================================================*/
CREATE PROCEDURE stp_ListarCatAccionesPLD
AS 
BEGIN
	SELECT INTACCIONPLDID
      ,VCHDESCRIPCION
      ,BITESTATUS
  FROM tbl_CAT_AccionesPLD
	WHERE BITESTATUS =1
END

--stp_ListarCatAccionesPLD



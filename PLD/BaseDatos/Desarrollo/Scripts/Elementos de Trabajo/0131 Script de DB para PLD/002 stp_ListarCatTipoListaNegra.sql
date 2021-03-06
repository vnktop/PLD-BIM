
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('stp_ListarCatTipoListaNegra') )
BEGIN 
 DROP PROCEDURE stp_ListarCatTipoListaNegra
END 
GO
/*=================================================================
		AUTOR:			Eliseo Díaz Díaz
		DESCRIPCION:	Listado del catálogo Tipo Lista Negra
		MODIFICACION:
		FECHA DE CREACIÓN: 19-MARZO-2013	
=================================================================*/
CREATE PROCEDURE stp_ListarCatTipoListaNegra
AS 
BEGIN
	SELECT LSTN.VCHTIPOLISTA,LSTN.vchIdentificadorInterno,LSTN.vchPais,LSTN.VCDDESCRIPCION
	FROM tbl_CAT_TipoListaNegra LSTN
	WHERE LSTN.BITESTATUS =1
END
--stp_ListarCatTipoListaNegra
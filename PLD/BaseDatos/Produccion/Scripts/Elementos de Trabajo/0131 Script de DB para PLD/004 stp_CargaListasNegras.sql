IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('stp_CargaListasNegras') )
BEGIN 
 DROP PROCEDURE stp_CargaListasNegras
END 
GO
CREATE PROCEDURE stp_CargaListasNegras
				@Cantidad int output
----------------------------------------------------------------------------------------------//
--		Autor:	Ricardo Martínez
--		Fecha:	2013/03/22
--		Descripcion:	Carga Lista Negras

----------------------------------------------------------------------------------------------//
AS

DECLARE @bcpCommand varchar(8000)

--TRUNCATE TABLE tbl_MST_ListaNegra 

SET NOCOUNT ON

set @bcpCommand='exec master..xp_cmdshell ''bcp "dbPLD.dbo.tbl_MST_ListaNegra" IN "C:\Repositorio\PLD\ListaNegra.txt" -c -t "|" -S local -C ACP -T -r \n '''
exec(@bcpCommand)

DELETE lsPrinPLD.dbCaroline.dbo.tbl_Tmp_ListaRestringida

INSERT INTO lsPrinPLD.dbCaroline.dbo.tbl_Tmp_ListaRestringida (intListaIdTLR,
															   intOrganismoIdCOR,
															   vchNombreTLR,
															   vchApPaternoTLR,
															   vchApMaternoTLR
															   ) 
															   Select ROW_NUMBER() OVER (ORDER BY T1.intIDdispo),  
																	 3,
																	 CASE WHEN T1.vchNombre IS NULL THEN T1.vchNomCompleto ELSE T1.vchNombre END,
																	 T1.vchApPaterno,
																	 T1.vchApPaterno																	  
																FROM tbl_MST_ListaNegra T1



SELECT COUNT(VCHIDQEQ) AS Cantidad FROM tbl_MST_ListaNegra



--SELECT * FROM tbl_MST_ListaNegra
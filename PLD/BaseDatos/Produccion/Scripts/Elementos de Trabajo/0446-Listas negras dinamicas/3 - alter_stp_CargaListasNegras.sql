USE [dbPLD]
GO
/****** Object:  StoredProcedure [dbo].[stp_CargaListasNegras]    Script Date: 07/22/2013 15:06:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[stp_CargaListasNegras]
				@Cantidad int output,
				@iProveedorId INT
----------------------------------------------------------------------------------------------//
--		Autor:	Ricardo Martínez
--		Fecha:	2013/03/22
--		Descripcion:	Carga Lista Negras

----------------------------------------------------------------------------------------------//
AS

DECLARE @bcpCommand varchar(8000)

--SELECT *
--  INTO #temp 
--  FROM tbl_MST_ListaNegra
-- WHERE iProveedorId != @iProveedorId

DELETE FROM tbl_MST_ListaNegra WHERE iProveedorId = @iProveedorId

SET NOCOUNT ON
--BEGIN TRANSACTION CARGALISTA
BEGIN TRY	
--set @bcpCommand='exec master..xp_cmdshell ''bcp "dbPLD.dbo.tbl_MST_ListaNegra" IN "C:\Repositorio\PLD\ListaNegra.txt" -c -t "|" -S local -C ACP -T -r \n '''

set @bcpCommand='exec master..xp_cmdshell ''D:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "dbPLD.dbo.tbl_MST_ListaNegra" IN "C:\Repositorio\PLD\ListaNegra.txt" -c -t "|" -S 172.30.28.48\pruebas -T -C ACP -r \n '''
exec(@bcpCommand)

DELETE lsPrinPLD.dbCaroline.dbo.tbl_Tmp_ListaRestringida

--INSERT INTO tbl_MST_ListaNegra
--SELECT * FROM #temp 

--DROP table #temp

INSERT INTO lsPrinPLD.dbCaroline.dbo.tbl_Tmp_ListaRestringida (intListaIdTLR,
															   intOrganismoIdCOR,
															   vchNombreTLR,
															   vchApPaternoTLR,
															   vchApMaternoTLR
															   ) 
															    Select ROW_NUMBER() OVER (ORDER BY ISNULL(vchNombre,vchRazonSocial),vchApPaterno,vchApMaterno) Id,  
																	 T2.intTipoListaID,
																	 CASE WHEN ISNULL(T1.vchNombre,'') = '' THEN ISNULL(T1.vchRazonSocial,'') ELSE ISNULL(T1.vchNombre,'') END vchNombre,
																	 ISNULL(T1.vchApPaterno,'') vchApPaterno,
																	 ISNULL(T1.vchApMaterno,'') vchApMaterno
																FROM tbl_MST_ListaNegra T1
																LEFT JOIN tbl_CAT_TipoListaNegra T2 ON T1.vchTipoLista = T2.vchTipoLista
																WHERE intTipoListaID is not null

--COMMIT TRANSACTION CARGALISTA

SET @Cantidad = 1
END TRY
BEGIN CATCH
				--ROLLBACK TRANSACTION	CARGALISTA

END CATCH
SELECT COUNT(VCHIDQEQ) AS Cantidad FROM tbl_MST_ListaNegra
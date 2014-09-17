ALTER PROCEDURE [dbo].[stp_CargaListasNegras]
				@mensaje varchar(200) output,
				--@vchError varchar(100) output,
				@iProveedorId INT
----------------------------------------------------------------------------------------------//
--		Autor:	Ricardo Martínez
--		Fecha:	2013/03/22
--		Descripcion:	Carga Lista Negras
--		Modificación: Ricardo Martínez   FECHA: 2013/08/06

----------------------------------------------------------------------------------------------//
AS

DECLARE @bcpCommand varchar(8000)

DELETE FROM tbl_MST_ListaNegra WHERE iProveedorId = @iProveedorId

SET NOCOUNT ON
--BEGIN TRANSACTION CARGALISTA
BEGIN TRY	
--set @bcpCommand='exec master..xp_cmdshell ''bcp "dbPLD.dbo.tbl_MST_ListaNegra" IN "C:\Repositorio\PLD\ListaNegra.txt" -c -t "|" -S local -C ACP -T -r \n '''
DECLARE @tabla AS TABLE
(
	id INT identity(1,1), 
	output varchar(100)
)
INSERT INTO @tabla (output)
exec('exec master..xp_cmdshell ''D:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "dbPLD.dbo.tbl_MST_ListaNegra" IN "C:\Repositorio\PLD\ListaNegra.txt" -c -t "|" -S local -T -C ACP -r \n ''')

--DELETE lsPrinPLD.dbCaroline.dbo.tbl_Tmp_ListaRestringida
--EXECUTE [lsPrinPLD].[dbCaroline].dbo.sp_executesql "TRUNCATE TABLE dbo.tbl_Tmp_ListaRestringida"

--INSERT INTO lsPrinPLD.dbCaroline.dbo.tbl_Tmp_ListaRestringida (intListaIdTLR,
--															   intOrganismoIdCOR,
--															   vchNombreTLR,
--															   vchApPaternoTLR,
--															   vchApMaternoTLR
--															   ) 
--															    Select ROW_NUMBER() OVER (ORDER BY ISNULL(vchNombre,vchRazonSocial),vchApPaterno,vchApMaterno) Id,  
--																	 T2.intTipoListaID,
--																	 CASE WHEN ISNULL(T1.vchNombre,'') = '' THEN ISNULL(T1.vchRazonSocial,'') ELSE ISNULL(T1.vchNombre,'') END vchNombre,
--																	 ISNULL(T1.vchApPaterno,'') vchApPaterno,
--																	 ISNULL(T1.vchApMaterno,'') vchApMaterno
--																FROM tbl_MST_ListaNegra T1
--																LEFT JOIN tbl_CAT_TipoListaNegra T2 ON T1.vchTipoLista = T2.vchTipoLista
--																WHERE intTipoListaID is not null AND t1.iProveedorId = @iProveedorId


SET @mensaje = (SELECT output
				  FROM @tabla
				 WHERE id = 2)
--COMMIT TRANSACTION CARGALISTA
END TRY
BEGIN CATCH
				--ROLLBACK TRANSACTION	CARGALISTA
				SET @mensaje = ERROR_MESSAGE()				
END CATCH
SELECT @mensaje


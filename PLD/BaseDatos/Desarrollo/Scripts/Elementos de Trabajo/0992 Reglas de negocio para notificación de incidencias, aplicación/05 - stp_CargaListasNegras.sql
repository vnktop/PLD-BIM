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

DELETE FROM tbl_MST_ListaNegra WHERE iProveedorId = @iProveedorId AND bitEstatus = 1
--DBCC CHECKIDENT (tbl_MST_ListaNegra, RESEED,0)

SET NOCOUNT ON
--BEGIN TRANSACTION CARGALISTA
BEGIN TRY	
DECLARE @tabla AS TABLE
(
	id INT identity(1,1), 
	output varchar(100)
)
INSERT INTO @tabla (output)
--exec('exec master..xp_cmdshell ''D:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "dbPLD.dbo.tbl_MST_ListaNegra" IN "C:\Repositorio\PLD\ListaNegra.txt" -c -t "|" -S local -T -C ACP -r \n ''')
exec('exec master..xp_cmdshell ''bcp "dbPLD.dbo.tbl_MST_ListaNegra" IN "C:\Repositorio\PLD\ListaNegra.txt" -c -t "|" -S local -T -C ACP -r \n ''')

SET @mensaje = (SELECT output
				  FROM @tabla
				 WHERE id = 2)
--COMMIT TRANSACTION CARGALISTA
END TRY
BEGIN CATCH
				--ROLLBACK TRANSACTION	CARGALISTA
				SET @mensaje = 'Error: ' + ERROR_MESSAGE()				
END CATCH
SELECT @mensaje

--declare @mensajer varchar(200) 
--exec stp_CargaListasNegras @mensajer, 1
--print @mensajer
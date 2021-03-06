USE [dbPLD]
GO
/****** Object:  StoredProcedure [dbo].[stp_Occam_EmployeeHistory]    Script Date: 07/02/2014 11:35:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================
-- Author:		Dante Tellez
-- Create date: 10-Junio-2014
-- Description:	Genera el Histórico de Employee para Occam
-- =======================================================
ALTER PROCEDURE [dbo].[stp_Occam_EmployeeHistory]
AS
BEGIN
	DECLARE @intSpace INTEGER, @FecIni CHAR(8), @chSpace CHAR(256)
	SET @chSpace = '                                                                                                                                '


 IF EXISTS(SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME='##EmployeeHistory' AND TYPE='U')  
  DROP TABLE ##EmployeeHistory  
  
		 CREATE TABLE ##EmployeeHistory  
		 (  
			[BankCode]					VARCHAR(32)		NULL,  
			[isSwif]					VARCHAR(1)		NULL,  
			[isABA]						VARCHAR(1)		NULL,  
			[LegalId1]					VARCHAR(20)		NULL,  
			[BranchCode]				VARCHAR(20)		NULL,  
			[DepartmentCode]			VARCHAR(20)		NULL,  
			[TitleCode]					VARCHAR(20)		NULL,
			[BossLegalId]				VARCHAR(20)		NULL,
			[From]						VARCHAR(23)		NULL,
			[Until]						VARCHAR(23)		NULL,
		--	Limite						VARCHAR(1)		NULL
		 )  
		 
			INSERT INTO ##EmployeeHistory  
				( 
				 BankCode
				,isSwif
				,isABA
				,LegalId1
				,BranchCode
				,DepartmentCode
				,TitleCode
				,BossLegalId
				,[From]
				,Until		
				)
	
			SELECT '040150                          '								BankCode
					,'T'															isSwif
					,'F'															isABA
					,[rfc] + SUBSTRING(CONVERT(CHAR(8), fechanacimiento, 112),3,8) + homoclave + '                    '	 Legalid1
					
					,rel.SucNumero + @chSpace	BranchCode
					,CONVERT(CHAR(3), iddepartamento)	+ @chSpace					DepartmentCode
					,CAST(idpuesto AS CHAR(3)) + '                 '			TitleCode
					,REPLICATE(' ',20)												BossLegalId 
					,REPLACE(CONVERT(CHAR(23), fechaalta, 121),'-','/')	[From]					
					,REPLICATE(' ',23)												Until 
			  FROM  [LSPLD_NOM].[ctBANCO_INMOBILI2].[dbo].[nom10001] nom
					INNER JOIN  tbl_Rel_SosuNom3 rel ON nom.iddepartamento = rel.iddeparta
			

SELECT * FROM ##EmployeeHistory
exec('exec master..xp_cmdshell ''C:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "Select * FROM ##EmployeeHistory" queryout "C:\Repositorio\PLD\Employee-History.txt" -c -t "" -S local -T -C ACP -r \n ''')

		
END		 





USE [dbPLD]
GO
/****** Object:  StoredProcedure [dbo].[stp_Occam_BankEmployeeTitle]    Script Date: 07/02/2014 11:34:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dante Tellez
-- Create date: 15-Mayo-2014
-- Description:	Genera el BankEmployeeTitle para Occam
-- =============================================
ALTER PROCEDURE [dbo].[stp_Occam_BankEmployeeTitle]
AS
BEGIN
	DECLARE @intSpace INTEGER
	SET @intSpace = 256
	

--	OBTIENE BankEmployeeTitle
 IF EXISTS(SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME='##BankEmployeeTitle' AND TYPE='U')  
  DROP TABLE ##BankEmployeeTitle  
  
		 CREATE TABLE ##BankEmployeeTitle  
		 (  
		  [BankCode]  VARCHAR(32)  NULL,  
		  [isSwif]   VARCHAR(1) NULL,  
		  [isABA]  VARCHAR(1)  NULL, 
		  [Code]  VARCHAR(20)  NULL,  
		  [TitleName]   VARCHAR(50) NULL,  
		  [Description_]  VARCHAR(256)  NULL,
		  [IsMoneyLaunderingEnforcement]   VARCHAR(1)  NULL,  
		 )   

			INSERT INTO ##BankEmployeeTitle  
				( 
				 BankCode
				,isSwif
				,isABA
				,Code
				,TitleName
				,Description_
				,IsMoneyLaunderingEnforcement
				)
			SELECT '040150                          ' BankCode
					,'T'					isSwif
					,'F'					isABA
					,CAST(idpuesto AS CHAR(3)) + '                 '	Code
					,[Descripcion] + '                                                                      '	TitleName
					,[Descripcion] + '                                                                                                                                                                                                                                                                                        '	Description_
					,'F'				IsMoneyLaunderingEnforcement 	   		  
			  FROM [LSPLD_NOM].[ctBANCO_INMOBILI2].[dbo].[nom10006]

SELECT * FROM ##BankEmployeeTitle
exec('exec master..xp_cmdshell ''C:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "Select * FROM ##BankEmployeeTitle" queryout "C:\Repositorio\PLD\Bank-Employee-Title.txt" -c -t "" -S local -T -C ACP -r \n ''')
				
END


USE [dbPLD]
GO
/****** Object:  StoredProcedure [dbo].[stp_Occam_BankDepartment]    Script Date: 07/02/2014 11:34:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dante Tellez
-- Create date: 15-Mayo-2014
-- Description:	Genera el BankDepartment Code para Occam
-- =============================================
ALTER PROCEDURE [dbo].[stp_Occam_BankDepartment]
AS
BEGIN
	DECLARE @intSpace INTEGER
	SET @intSpace = 256
	

--	OBTIENE BankDepartment 
 IF EXISTS(SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME='##BankDepartment' AND TYPE='U')  
  DROP TABLE ##BankDepartment  
  
		 CREATE TABLE ##BankDepartment  
		 (  
		  [BankCode]  VARCHAR(32)  NULL,  
		  [isSwif]   VARCHAR(1) NULL,  
		  [isABA]  VARCHAR(1)  NULL,
		  [Code]  VARCHAR(20)  NULL,  
		  [Name]   VARCHAR(70) NULL,  
		  [Description_]  VARCHAR(256)  NULL,
		  [IsWorkingMoneyLaundry]   VARCHAR(1)  NULL,  
		 )   

			INSERT INTO ##BankDepartment  
				( 
				 BankCode
				,isSwif
				,isABA
				,Code
				,Name
				,Description_
				,IsWorkingMoneyLaundry
				)
			SELECT '040150                          ' BankCode
					,'T'					isSwif
					,'F'					isABA
					,CAST(iddepartamento AS CHAR(2)) + '                                  ' Code
					,[Descripcion] + '                                                                      ' Name
					,[Descripcion] +  + '                                                                                                                                                                                                                                                                                        '	Description_
					,'F'				IsWorkingMoneyLaundry 
			 FROM [LSPLD_NOM].[ctBANCO_INMOBILI2].[dbo].[nom10003]

SELECT * FROM ##BankDepartment	
exec('exec master..xp_cmdshell ''C:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "Select * FROM ##BankDepartment" queryout "C:\Repositorio\PLD\BankDepartment.txt" -c -t "" -S local -T -C ACP -r \n ''')

END


USE [dbPLD]
GO
/****** Object:  StoredProcedure [dbo].[stp_Occam_BankBranch]    Script Date: 07/02/2014 11:32:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dante Tellez
-- Create date: 15-Mayo-2014
-- Description:	Genera el BankBranch Code para Occam
-- =============================================
ALTER PROCEDURE [dbo].[stp_Occam_BankBranch]
AS
BEGIN
	DECLARE @intSpace INTEGER
	SET @intSpace = 256
	

--	OBTIENE BankBranch 
 IF EXISTS(SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME='##BankBranch' AND TYPE='U')  
  DROP TABLE ##BankBranch  
  
		 CREATE TABLE ##BankBranch  
		 (  
		  [BankCode]  VARCHAR(32)  NULL,  
		  [isSwif]   VARCHAR(1) NULL,  
		  [isABA]  VARCHAR(1)  NULL,
		  [Code]  VARCHAR(20)  NULL,
		  [LocationCode]  VARCHAR(20)  NULL,  
		  [Name]   VARCHAR(70) NULL,  
		  [isMain]  VARCHAR(1)  NULL,   
		  [Phone]   VARCHAR(20)  NULL,  
		  [ActivationDate]   VARCHAR(23)  NULL,    
		  [DeactivationDate]   VARCHAR(23)  NULL
		 )   


			INSERT INTO ##BankBranch  
				( 
				 BankCode
				,isSwif
				,isABA
				,Code
				,LocationCode
				,Name
				,isMain
				,Phone
				,ActivationDate
				,DeactivationDate)
			SELECT '040150                          '	BankCode
					,'T'								isSwif
					,'F'								isABA
					,LTRIM(RTRIM(Suc_Numero))+REPLICATE(' ', 20 - LEN(LTRIM(RTRIM(Suc_Numero)))) Code
					,'                    '				LocationCode					
					,Suc_Nombre	+ '                                                                      '	Name
					,'F'								isMain
					,CASE WHEN Suc_Telefo = '' THEN '52010404'+ REPLICATE(' ', 12) ELSE  LTRIM(RTRIM(Suc_Telefo))+REPLICATE(' ', 20 - LEN(LTRIM(RTRIM(Suc_Telefo)))) END  Phone
					,Suc_FecApe							ActivationDate	
					,'                       '	DeactivationDate			
			FROM SYB_LINK.dbBIM.dbo.SOSUCURS --WHERE SoSucursID <>799
			UNION
			SELECT '040150                          ' BankCode
					,'T'					isSwif
					,'F'					isABA
					,'000                 '	Code
					,'                    '	LocationCode					
					,LTRIM(RTRIM('OFICINAS CENTRALES'))+REPLICATE(' ', 70 - LEN(LTRIM(RTRIM('OFICINAS CENTRALES'))))  Name
					,'T'					isMain
					,'52010404                           ' Phone
					,'2013-10-01 00:00:00.0000000'				ActivationDate				
					,'                       '	DeactivationDate


SELECT * FROM ##BankBranch
exec('exec master..xp_cmdshell ''C:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "Select * FROM ##BankBranch" queryout "C:\Repositorio\PLD\Bank-Branch.txt" -c -t "" -S local -T -C ACP -r \n ''')

				
END

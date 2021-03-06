USE [dbPLD]
GO
/****** Object:  StoredProcedure [dbo].[stp_Occam_Employee]    Script Date: 07/02/2014 11:34:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dante Tellez
-- Create date: 15-Mayo-2014
-- Description:	Genera el Employee Code para Occam
-- =============================================
ALTER PROCEDURE [dbo].[stp_Occam_Employee]
AS
BEGIN
	DECLARE @intSpace INTEGER
	SET @intSpace = 256
	
	
--	OBTIENE Employee 
 IF EXISTS(SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME='##Employee' AND TYPE='U')  
  DROP TABLE ##Employee  
  
		 CREATE TABLE ##Employee  
		 (  
			BankCode			VARCHAR(32)  NULL,  
			isSwif				VARCHAR(1)   NULL,  
			isABA				VARCHAR(1)   NULL, 
			LegalIdKind1		VARCHAR(20)  NULL,
			LegalId1			VARCHAR(20)  NULL,
			LegalIdKind2		VARCHAR(20)  NULL,
			LegalId2			VARCHAR(20)  NULL,
			LegalIdKind3		VARCHAR(20)  NULL,
			LegalId3			VARCHAR(20)  NULL,
			FirstName			VARCHAR(70)  NULL,
			SecondName			VARCHAR(70)  NULL,
			FirstLastName		VARCHAR(70)  NULL,
			SecondLastName		VARCHAR(70)  NULL,
			Gender				VARCHAR(1)  NULL,
			Code				VARCHAR(30)  NULL,
			LivingPhone1		VARCHAR(20)  NULL,
			LivingPhone2		VARCHAR(20)  NULL,
			CellPhone1			VARCHAR(20)  NULL,
			CellPhone2			VARCHAR(20)  NULL,
			FaxPhone1			VARCHAR(20)  NULL,
			EMail1				VARCHAR(50)  NULL,
			EMail2				VARCHAR(50)  NULL,
			Website				VARCHAR(520)  NULL,
			BornCountry			VARCHAR(20)  NULL,
			BornDate			VARCHAR(23)  NULL,
			NationalityCountry	VARCHAR(20)  NULL,
			CivilState			VARCHAR(20)  NULL,
			Profession			VARCHAR(20)  NULL,
			Occupation			VARCHAR(20)  NULL,
			SinceDate			VARCHAR(23)  NULL,
			UntilDate			VARCHAR(23)  NULL,
			StatusCode			VARCHAR(20)  NULL,
			EmployeeKind		VARCHAR(20)  NULL,
			IsShareholder		VARCHAR(1)  NULL,
			TIN					VARCHAR(30)  NULL,
			TINKind				VARCHAR(20)  NULL,
			Limite		VARCHAR(1)  NULL
		 )   

			INSERT INTO ##Employee  
				( 

			BankCode 
			,isSwif  
			,isABA			
			,LegalIdKind1
			,LegalId1
			,LegalIdKind2
			,LegalId2
			,LegalIdKind3
			,LegalId3
			,FirstName
			,SecondName
			,FirstLastName
			,SecondLastName
			,Gender
			,Code
			,LivingPhone1
			,LivingPhone2
			,CellPhone1
			,CellPhone2
			,FaxPhone1
			,EMail1
			,EMail2
			,Website
			,BornCountry
			,BornDate
			,NationalityCountry
			,CivilState
			,Profession
			,Occupation
			,SinceDate
			,UntilDate
			,StatusCode
			,EmployeeKind
			,IsShareholder
			,TIN
			,TINKind
			--,Limite
				)
			SELECT '040150                          '																	BankCode
					,'T'																								isSwif
					,'F'																								isABA
					,'LG001' + '                  '																		LegalIdKind1
					,[rfc] + SUBSTRING(CONVERT(CHAR(8), fechanacimiento, 112),3,8) + homoclave + '                    ' Legalid1
					,'LG002' + '                   '  																	LegalIdKind2
					,[curpi] + SUBSTRING(CONVERT(CHAR(8), fechanacimiento, 112),3,8) + curpf + '                    '	Legalid2
					,'                    ' 																			LegalIdKind3
					,'                    ' 																			LegalId3
					,[nombre] + '                                                                      ' 				FirstName
					, + '                                                                      '						SecondName
					  ,[apellidopaterno] + '                                                                      '		FirstLastName
					  ,[apellidomaterno] + '                                                                      '		SecondLastName
					  ,[sexo]																							Gender
					  ,[codigoempleado] + '                              '												Code
					  ,CASE WHEN [telefono] = '' THEN '11023770' ELSE
					  LTRIM(RTRIM(ISNULL([telefono],'11023770')))+REPLICATE(' ', 20 - LEN(LTRIM(RTRIM(ISNULL([telefono],'11023770')))))
					  END
																								 						LivingPhone1
					  ,'                    ' 																			LivingPhone2
					  ,'                    ' 																			CellPhone2
					  ,'                    ' 																			CellPhone2
					  ,'                    ' 																			FaxPhone2
					  ,[CorreoElectronico] + '                                                  '						EMail1
					  ,'                                                  '												EMail2
					  ,' '																								Website
					  ,'PA001               '																			BornCountry
					  , ISNULL(SUBSTRING(REPLACE(CONVERT(VARCHAR(26),fechanacimiento,25), '-', '/'), 1, LEN(CONVERT(VARCHAR(26),fechanacimiento,25)) - 4), REPLICATE(' ', 23)) 								BornDate
					  ,'PA001               '																			NacionalityCountry
					  ,ISNULL((CASE WHEN [estadocivil] = 'S' THEN 'SOLTERO             '
						  WHEN [estadocivil] = 'C' THEN 'CASADO              '
						 
						  END), 'NO DISPONIBLE      ')															CivilState --CATALOGO DE SIBAMEX
					  ,'PR099               '																			Profession
					  ,CASE 
						WHEN idpuesto<10 THEN 'PN00' + rtrim(CAST(idpuesto AS CHAR)) + '               '
						WHEN idpuesto<100 THEN 'PN0' + rtrim(CAST(idpuesto AS CHAR)) + '               '
						WHEN idpuesto<1000 THEN 'PN' + rtrim(CAST(idpuesto AS CHAR)) + '               ' END
																		Occupation
					  , ISNULL(SUBSTRING(REPLACE(CONVERT(VARCHAR(26),fechaalta,25), '-', '/'), 1, LEN(CONVERT(VARCHAR(26),fechaalta,25)) - 4), REPLICATE(' ', 23)) 	SinceDate
					  ,CASE WHEN fechabaja <= '19000101' THEN REPLICATE(' ', 23) ELSE 
					  ISNULL(SUBSTRING(REPLACE(CONVERT(VARCHAR(26),fechabaja,25), '-', '/'), 1, LEN(CONVERT(VARCHAR(26),fechabaja,25)) - 4), REPLICATE(' ', 23))
					  END										UntilDate      
					  ,CASE WHEN [estadoempleado] = 'A' THEN 'ES001               ' ELSE 'ES002               ' END		 							StatusCode
					  ,'EK001               '																			EmployeeKind
					  ,'F'																								IsShareholder
					  ,'                              '																	TIN
					  ,'                    '																			TINKind
					  --,''																								Limite
			  FROM [LSPLD_NOM].[ctBANCO_INMOBILI2].[dbo].[nom10001]

SELECT * FROM ##Employee
exec('exec master..xp_cmdshell ''C:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "Select * FROM ##Employee" queryout "C:\Repositorio\PLD\Employee.txt" -c -t "" -S local -T -C ACP -r \n ''')

				
END

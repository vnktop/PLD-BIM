USE [dbPLD]
GO
/****** Object:  StoredProcedure [dbo].[stp_Occam_MasterCode]    Script Date: 07/02/2014 11:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dante Tellez
-- Create date: 15-Mayo-2014
-- Description:	Genera el Master Code para Occam
-- exec stp_Occam_MasterCode
-- =============================================
ALTER PROCEDURE [dbo].[stp_Occam_MasterCode]
AS
BEGIN
	DECLARE @intSpace INTEGER
	SET @intSpace = 256

	
--	OBTIENE INSTRUMENT KINDS
 IF EXISTS(SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME='##InstrumentKinds' AND TYPE='U')  
  DROP TABLE ##InstrumentKinds  
  
		 CREATE TABLE ##InstrumentKinds  
		 (  
		  [BankCode]  VARCHAR(32)  NULL,  
		  [isSwif]   VARCHAR(1) NULL,  
		  [isABA]  VARCHAR(1)  NULL,  
		  [FlatFileIdentificator]   VARCHAR(20)  NULL,  
		  [BankMasterCode]   CHAR(20)  NULL,  
		  [BankMasterCodeDescription]   VARCHAR(256)  NULL,    
		 )    

		--Cuentas TR ASCENDENTE & Cuentas Fiducuiario
			INSERT INTO ##InstrumentKinds  
				( 
				 BankCode
				,isSwif
				,isABA
				,FlatFileIdentificator
				,BankMasterCode
				,BankMasterCodeDescription
				)
			SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'InstrumentKinds     ' FlatFileIdentificator
					,'CH0' + Tip_Numero Tip_Numero
					,Tip_Descri Tip_Descri
			FROM SYB_LINK.dbBIM.dbo.CHTIPOS	WHERE Tip_Numero IN ('02','07')
			UNION 
			SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'InstrumentKinds     ' FlatFileIdentificator
					,'FD0' + Clf_Tipo Clf_Tipo
					,Clf_Descri
			 FROM  SYB_LINK.dbBIM.dbo.FDCLAFID


		--Créditos Individual
			INSERT INTO ##InstrumentKinds  
				( 
				 BankCode
				,isSwif
				,isABA
				,FlatFileIdentificator
				,BankMasterCode
				,BankMasterCodeDescription
				)
			SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'InstrumentKinds     ' FlatFileIdentificator
					,'CI00' + CAST(iCatalogoId AS CHAR(1)) iCatalogoId
					,sDescCatalogo sDescCatalogo
			FROM SIHCEI.dbo.tbl_sistema_catalogos WHERE iAgrupaCatId=151


		--Créditos Empresarial
			INSERT INTO ##InstrumentKinds  
				( 
				 BankCode
				,isSwif
				,isABA
				,FlatFileIdentificator
				,BankMasterCode
				,BankMasterCodeDescription
				)
			SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'InstrumentKinds     ' FlatFileIdentificator
					,'CE00' + CAST(sintTipoProductoID AS CHAR(1)) sintTipoProductoID
					,vchDescripcion vchDescripcion			
			FROM SIHCEI.dbo.tbl_CAT_TipoProducto

		--Inversión PRLV
			INSERT INTO ##InstrumentKinds  
				( 
				 BankCode
				,isSwif
				,isABA
				,FlatFileIdentificator
				,BankMasterCode
				,BankMasterCodeDescription
				)
				SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'InstrumentKinds     ' FlatFileIdentificator
					,'IN' + Tip_Numero Tip_Numero
					,Tip_Descri+ ' [PRLV]' Tip_Descri
			FROM SYB_LINK.dbBIM.dbo.INTIPOS

			--SELECT '040150                          ' BankCode
			--		,'T' isSwif
			--		,'F' isABA
			--		,'InstrumentKinds     ' FlatFileIdentificator
			--		,'IN' + Cla_Numero Cla_Numero
			--		,Cla_Descri Cla_Descri				
			--FROM SYB_LINK.dbBIM.dbo.INCLAINV

			
		----Fiduciario Inversión & Fiducuario Garantía/Financiamiento & Fiduciario Administración
		--	INSERT INTO ##InstrumentKinds  
		--		( 
		--		 BankCode
		--		,isSwif
		--		,isABA
		--		,FlatFileIdentificator
		--		,BankMasterCode
		--		,BankMasterCodeDescription
		--		)
		--	SELECT '040150                          ' BankCode
		--			,'T' isSwif
		--			,'F' isABA
		--			,'InstrumentKinds     ' FlatFileIdentificator
		--			,'FD' + Clf_Numero Clf_Numero
		--			,Clf_Descri Clf_Descri					
		--	FROM SYB_LINK.dbBIM.dbo.FDCLAFID

		--Cedes
			INSERT INTO ##InstrumentKinds  
				( 
				 BankCode
				,isSwif
				,isABA
				,FlatFileIdentificator
				,BankMasterCode
				,BankMasterCodeDescription
				)
			SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'InstrumentKinds     ' FlatFileIdentificator
					,'CD0' + Pro_Numero Pro_Numero
					,Pro_Descri Pro_Descri		
			FROM SYB_LINK.dbBIM.dbo.CEPRODUC WHERE Pro_Numero='01'

--SELECT * FROM ##InstrumentKinds
--exec('exec master..xp_cmdshell ''C:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "Select * FROM ##InstrumentKinds" queryout "C:\Repositorio\PLD\InstrumentKinds.txt" -c -t "|" -S local -T -C ACP -r \n ''')




--	OBTIENE INSTRUMENT STATUS 
 IF EXISTS(SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME='##InstrumentStatus' AND TYPE='U')  
  DROP TABLE ##InstrumentStatus  
  
		 CREATE TABLE ##InstrumentStatus  
		 (  
		  [BankCode]  VARCHAR(32)  NULL,  
		  [isSwif]   VARCHAR(1) NULL,  
		  [isABA]  VARCHAR(1)  NULL,  
		  [FlatFileIdentificator]   VARCHAR(20)  NULL,  
		  [BankMasterCode]   VARCHAR(20)  NULL,  
		  [BankMasterCodeDescription]   VARCHAR(256)  NULL,    
		 )    


		--Cuentas  ( TR ASCENDENTE y Fiducuiario)
			--SELECT * FROM SYB_LINK.dbBIM.dbo.CHCUENTA --BAD
			--SELECT * FROM OPENQUERY([SYB_LINK], 'SELECT * FROM CHCUENTA') --OK
			INSERT INTO ##InstrumentStatus  
				( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			SELECT 
				'040150                          ' BankCode,'T' isSwif,'F' isABA,'InstrumentStatus    ' FlatFileIdentificator,'00A               ' Cue_Status,'Activa' Cue_Status

			INSERT INTO ##InstrumentStatus  
				( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			SELECT 
				'040150                          ' BankCode,'T' isSwif,'F' isABA,'InstrumentStatus    ' FlatFileIdentificator,'00B               ' Cue_Status,'Bloqueada' Cue_Status

			INSERT INTO ##InstrumentStatus  
				( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			SELECT 
				'040150                          ' BankCode,'T' isSwif,'F' isABA,'InstrumentStatus    ' FlatFileIdentificator,'00C               ' Cue_Status,'Cancelada' Cue_Status

			INSERT INTO ##InstrumentStatus  
				( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			SELECT 
				'040150                          ' BankCode,'T' isSwif,'F' isABA,'InstrumentStatus    ' FlatFileIdentificator,'00I               ' Cue_Status,'Inactiva' Cue_Status

			
		--Creditos  Empresarial  
			INSERT INTO ##InstrumentStatus  
				( 
				 BankCode
				,isSwif
				,isABA
				,FlatFileIdentificator
				,BankMasterCode
				,BankMasterCodeDescription
				)
			SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'InstrumentStatus    ' FlatFileIdentificator
					,CASE WHEN iCatalogoId>9 THEN '0' + CAST(iCatalogoId AS CHAR(2)) + '               '		-- RIGHT(space(20) + 'CE0' + CAST(iCatalogoId AS CHAR) + 'O', 20) 
					ELSE 'O0' + CAST(iCatalogoId AS CHAR(1)) + '               ' END iCatalogoId
					,sDescCatalogo sDescCatalogp
			FROM SIHCEI.dbo.tbl_sistema_catalogos WHERE iAgrupaCatId=313 AND iCatalogoId IN (4,10)


		--Creditos Individual
			INSERT INTO ##InstrumentStatus  
				( 
				 BankCode
				,isSwif
				,isABA
				,FlatFileIdentificator
				,BankMasterCode
				,BankMasterCodeDescription
				)
			SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'InstrumentStatus    ' FlatFileIdentificator
					,'A0' + CONVERT(CHAR(1),iCatalogoId) + '               ' iCatalogoId
					,sDescCatalogo sDescCatalogp
			FROM SIHCEI.dbo.tbl_sistema_catalogos WHERE iAgrupaCatId=28 AND iCatalogoId IN (4)


		--Inversión PRLV 
			--INSERT INTO ##InstrumentStatus  
			--	( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			--SELECT 
			--	'040150                          ' BankCode,'T' isSwif,'F' isABA,'InstrumentStatus    ' FlatFileIdentificator,'IN00A               ' Cue_Status,'Activa' Cue_Status

			INSERT INTO ##InstrumentStatus  
				( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			SELECT 
				'040150                          ' BankCode,'T' isSwif,'F' isABA,'InstrumentStatus    ' FlatFileIdentificator,'P0N               ' Cue_Status,'Proceso (cargada a cuenta)' Cue_Status

			INSERT INTO ##InstrumentStatus  
				( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			SELECT 
				'040150                          ' BankCode,'T' isSwif,'F' isABA,'InstrumentStatus    ' FlatFileIdentificator,'00P               ' Cue_Status,'Pagada' Cue_Status

			--INSERT INTO ##InstrumentStatus  
			--	( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			--SELECT 
			--	'040150                          ' BankCode,'T' isSwif,'F' isABA,'InstrumentStatus    ' FlatFileIdentificator,'IN00C               ' Cue_Status,'Cancelada' Cue_Status


		--Fiduciario (Inversión, Garantía y Administración)
			--INSERT INTO ##InstrumentStatus  
			--	( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			--SELECT 
			--	'040150                          ' BankCode,'T' isSwif,'F' isABA,'InstrumentStatus    ' FlatFileIdentificator,'FD00A               ' Cue_Status,'Activa' Cue_Status

			--INSERT INTO ##InstrumentStatus  
			--	( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			--SELECT 
			--	'040150                          ' BankCode,'T' isSwif,'F' isABA,'InstrumentStatus    ' FlatFileIdentificator,'FD00B               ' Cue_Status,'Bloqueada' Cue_Status

			--INSERT INTO ##InstrumentStatus  
			--	( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			--SELECT 
			--	'040150                          ' BankCode,'T' isSwif,'F' isABA,'InstrumentStatus    ' FlatFileIdentificator,'FD00C               ' Cue_Status,'Cancelada' Cue_Status

			--INSERT INTO ##InstrumentStatus  
			--	( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			--SELECT 
			--	'040150                          ' BankCode,'T' isSwif,'F' isABA,'InstrumentStatus    ' FlatFileIdentificator,'FD00I               ' Cue_Status,'Inactiva' Cue_Status


		--Cedes 
			--INSERT INTO ##InstrumentStatus  
			--	( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			--SELECT 
			--	'040150                          ' BankCode,'T' isSwif,'F' isABA,'InstrumentStatus    ' FlatFileIdentificator,'CD00A               ' Cue_Status,'Activa' Cue_Status

			--INSERT INTO ##InstrumentStatus  
			--	( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			--SELECT 
			--	'040150                          ' BankCode,'T' isSwif,'F' isABA,'InstrumentStatus    ' FlatFileIdentificator,'CD00C               ' Cue_Status,'Cancelada' Cue_Status

			INSERT INTO ##InstrumentStatus  
				( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			SELECT 
				'040150                          ' BankCode,'T' isSwif,'F' isABA,'InstrumentStatus    ' FlatFileIdentificator,'00N               ' Cue_Status,'Cargada a cuenta' Cue_Status

			--INSERT INTO ##InstrumentStatus  
			--	( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			--SELECT 
			--	'040150                          ' BankCode,'T' isSwif,'F' isABA,'InstrumentStatus    ' FlatFileIdentificator,'CD00P               ' Cue_Status,'Pagada' Cue_Status


--SELECT * FROM ##InstrumentStatus
--exec('exec master..xp_cmdshell ''C:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "Select * FROM ##InstrumentStatus" queryout "C:\Repositorio\PLD\InstrumentStatus.txt" -c -t "|" -S local -T -C ACP -r \n ''')




--	OBTIENE ClientKinds 
 IF EXISTS(SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME='##ClientEconActCodes' AND TYPE='U')  
  DROP TABLE ##ClientEconActCodes 
  
		 CREATE TABLE ##ClientEconActCodes  
		 (  
		  [BankCode]  VARCHAR(32)  NULL,  
		  [isSwif]   VARCHAR(1) NULL,  
		  [isABA]  VARCHAR(1)  NULL,  
		  [FlatFileIdentificator]   VARCHAR(20)  NULL,  
		  [BankMasterCode]   VARCHAR(20)  NULL,  
		  [BankMasterCodeDescription]   VARCHAR(256)  NULL,    
		 )    

		--Cuentas TR ASCENDENTE & Cuentas Fiducuiario
			INSERT INTO ##ClientEconActCodes  
				( 
				 BankCode
				,isSwif
				,isABA
				,FlatFileIdentificator
				,BankMasterCode
				,BankMasterCodeDescription
				)
			SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'ClientEconActCodes  ' FlatFileIdentificator
					,Act_Numero + '          ' Act_Numero
					,Act_Descri Act_Descri
			FROM SYB_LINK.dbBIM.dbo.CLACTIVI

			INSERT INTO ##ClientEconActCodes  
				( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			SELECT 
				'040150                          ' BankCode,'T' isSwif,'F' isABA,'ClientEconActCodes  ' FlatFileIdentificator,'0009999999          ' Act_Numero,'NO CLASIFICADA (USO EXCLUSIVO CNBV)' Act_Descri

			

--SELECT * FROM ##ClientKinds
--exec('exec master..xp_cmdshell ''C:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "Select * FROM ##ClientKinds" queryout "C:\Repositorio\PLD\ClientKinds.txt" -c -t "|" -S local -T -C ACP -r \n ''')




--	OBTIENE ClientEconActCodes 
 IF EXISTS(SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME='##ClientKinds' AND TYPE='U')  
  DROP TABLE ##ClientKinds  
  
		 CREATE TABLE ##ClientKinds 
		 (  
		  [BankCode]  VARCHAR(32)  NULL,  
		  [isSwif]   VARCHAR(1) NULL,  
		  [isABA]  VARCHAR(1)  NULL,  
		  [FlatFileIdentificator]   VARCHAR(20)  NULL,  
		  [BankMasterCode]   VARCHAR(20)  NULL,  
		  [BankMasterCodeDescription]   VARCHAR(256)  NULL,    
		 )    

		--
			INSERT INTO ##ClientKinds  
				( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			SELECT 
				'040150                          ' BankCode,'T' isSwif,'F' isABA,'ClientKinds         ' FlatFileIdentificator,'CL001               ' Cue_Status,'Persona Moral' 

			INSERT INTO ##ClientKinds 
				( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			SELECT 
				'040150                          ' BankCode,'T' isSwif,'F' isABA,'ClientKinds         ' FlatFileIdentificator,'CL002               ' Cue_Status,'Persona Fisica' 

			INSERT INTO ##ClientKinds 
				( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			SELECT 
				'040150                          ' BankCode,'T' isSwif,'F' isABA,'ClientKinds         ' FlatFileIdentificator,'CL003               ' Cue_Status,'Persona Fisica Con Actividad Empresarial' 
			INSERT INTO ##ClientKinds 
				( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			SELECT '040150' +  REPLICATE(' ', 32 - LEN('040150')) BankCode
					,'T' isSwif
					,'F' isABA
					,'ClientKinds' +  REPLICATE(' ', 20 - LEN('ClientKinds')) FlatFileIdentificator
					,'TR004' +  REPLICATE(' ', 20 - LEN('TR004'))Cue_Status -- LAYOUT ACCOUNT MOVEMENT SO.Orp_Tipo = 'R' THEN 'TR40003' ELSE 'TR40000'
					,'Transferencia'				

--SELECT * FROM ##ClientEconActCodes
--exec('exec master..xp_cmdshell ''C:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "Select * FROM ##ClientEconActCodes" queryout "C:\Repositorio\PLD\ClientEconActCodes.txt" -c -t "|" -S local -T -C ACP -r \n ''')




--	OBTIENE Currencies 
 IF EXISTS(SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME='##Currencies' AND TYPE='U')  
  DROP TABLE ##Currencies  
  
		 CREATE TABLE ##Currencies  
		 (  
		  [BankCode]  VARCHAR(32)  NULL,  
		  [isSwif]   VARCHAR(1) NULL,  
		  [isABA]  VARCHAR(1)  NULL,  
		  [FlatFileIdentificator]   VARCHAR(20)  NULL,  
		  [BankMasterCode]   VARCHAR(20)  NULL,  
		  [BankMasterCodeDescription]   VARCHAR(256)  NULL,    
		 )    

		--Cuentas TR ASCENDENTE & Cuentas Fiducuiario
			INSERT INTO ##Currencies  
				( 
				 BankCode
				,isSwif
				,isABA
				,FlatFileIdentificator
				,BankMasterCode
				,BankMasterCodeDescription
				)
			SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'Currencies          ' FlatFileIdentificator
					,'CU0' + Mon_Numero + '               ' Mon_Numero
					,Mon_Descri Mon_Descri
			FROM SYB_LINK.dbBIM.dbo.SOMONEDA

--SELECT * FROM ##Currencies
--exec('exec master..xp_cmdshell ''C:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "Select * FROM ##Currencies" queryout "C:\Repositorio\PLD\Currencies.txt" -c -t "|" -S local -T -C ACP -r \n ''')




              
--	OBTIENE Transactions 
 IF EXISTS(SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME='##Transactions' AND TYPE='U')  
  DROP TABLE ##Transactions  
  
		 CREATE TABLE ##Transactions  
		 (  
		  [BankCode]  VARCHAR(32)  NULL,  
		  [isSwif]   VARCHAR(1) NULL,  
		  [isABA]  VARCHAR(1)  NULL,  
		  [FlatFileIdentificator]   VARCHAR(20)  NULL,  
		  [BankMasterCode]   VARCHAR(20)  NULL,  
		  [BankMasterCodeDescription]   VARCHAR(256)  NULL,    
		 )    

		--Crédito Individual 
			INSERT INTO ##Transactions  
				( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			SELECT 
				'040150                          ' BankCode,'T' isSwif,'F' isABA,'Transactions        ' FlatFileIdentificator,'TIE01               ' Cue_Status,'Excendente no aplicado' Cue_Status -- Marco Ruíz/Frank
			
			INSERT INTO ##Transactions  
				( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			SELECT 
				'040150                          ' BankCode,'T' isSwif,'F' isABA,'Transactions        ' FlatFileIdentificator,'TIR01               ' Cue_Status,'Reconocimiento de pago' Cue_Status -- Marco Ruíz/Frank				
				
			INSERT INTO ##Transactions  
				( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			SELECT 
				'040150                          ' BankCode,'T' isSwif,'F' isABA,'Transactions        ' FlatFileIdentificator,'TI002               ' Cue_Status,'Excedente pago aplicado' Cue_Status -- Marco Ruíz/Frank
				
			INSERT INTO ##Transactions  
				( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			SELECT 
				'040150                          ' BankCode,'T' isSwif,'F' isABA,'Transactions        ' FlatFileIdentificator,'TI003               ' Cue_Status,'Carga de Bancos' Cue_Status

			INSERT INTO ##Transactions  
				( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			SELECT 
				'040150                          ' BankCode,'T' isSwif,'F' isABA,'Transactions        ' FlatFileIdentificator,'TI004               ' Cue_Status,'Carga Archivos Infonavit' Cue_Status

			INSERT INTO ##Transactions  
				( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			SELECT 
				'040150                          ' BankCode,'T' isSwif,'F' isABA,'Transactions        ' FlatFileIdentificator,'TI005               ' Cue_Status,'Pago Por Conciliación' Cue_Status
			
			INSERT INTO ##Transactions  
				( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			SELECT 
				'040150                          ' BankCode,'T' isSwif,'F' isABA,'Transactions        ' FlatFileIdentificator,'TI006               ' Cue_Status,'Pago Manual [Abono a capital o liquidación]' Cue_Status -- Marco Ruíz/Frank

			INSERT INTO ##Transactions  
				( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			SELECT 
				'040150                          ' BankCode,'T' isSwif,'F' isABA,'Transactions        ' FlatFileIdentificator,'TI007               ' Cue_Status,'Carga Domiciliación' Cue_Status

			INSERT INTO ##Transactions  
				( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			SELECT 
				'040150                          ' BankCode,'T' isSwif,'F' isABA,'Transactions        ' FlatFileIdentificator,'TI009               ' Cue_Status,'Carga Ajustes Individual' Cue_Status

		
		--Sibamex
			INSERT INTO ##Transactions  
				( 
				 BankCode
				,isSwif
				,isABA
				,FlatFileIdentificator
				,BankMasterCode
				,BankMasterCodeDescription
				)
			SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'Transactions        ' FlatFileIdentificator
					,'TS0' + Tim_Numero + '               ' Tim_Numero		
					, REPLACE(Tim_Descri,'SPEUA','SPEI') Tim_Descri
			FROM SYB_LINK.dbBIM.dbo.CHTIPMOV  
				WHERE Tim_Numero in (
					SELECT Mov_Tipo FROM SYB_LINK.dbBIM.dbo.CHHISMOV GROUP BY Mov_Tipo )
					AND Tim_Numero not like '4000%'
			UNION
			SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'Transactions        ' FlatFileIdentificator
					,'EF0000033           '
					,'Retiro en efectivo'
			UNION 
			SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'Transactions        ' FlatFileIdentificator
					,'EF0000036           '
					,'Deposito en efectivo'			
			UNION 
			SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'Transactions        ' FlatFileIdentificator
					,'TR40003' +  REPLICATE(' ', 20 - LEN('TR40003')) -- LAYOUT ACCOUNT MOVEMENT SO.Orp_Tipo = 'R' THEN 'TR40003' ELSE 'TR40000'
					,'Abono por SPEI recibido'									
										

		--Empresarial
			INSERT INTO ##Transactions  
				( 
				 BankCode
				,isSwif
				,isABA
				,FlatFileIdentificator
				,BankMasterCode
				,BankMasterCodeDescription
				)
			SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'Transactions        ' FlatFileIdentificator
					--,'TE00' + CAST(sintTipoDispoID AS CHAR) sintTipoDispoID
					,CASE WHEN sintTipoDispoID>9 THEN 'TE0' + CAST(sintTipoDispoID AS CHAR(3)) + '               '
						ELSE 'TE00' + CAST(sintTipoDispoID AS CHAR(3)) + '               ' END sintTipoDispoID				
					,vchDescripcion vchDescripcion
			FROM SIHCEI.dbo.tbl_cat_TipoDisposicion
			UNION
			SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'Transactions        ' FlatFileIdentificator
					--,intConceptoID
					,CASE WHEN intConceptoID>9 THEN 'TM0' + CAST(intConceptoID AS CHAR(2)) + '               '
						ELSE 'TM00' + CAST(intConceptoID AS CHAR(2)) + '               ' END intConceptoID									
					,vchDescripcion 
				FROM SIHCEI.dbo.tbl_CAT_Concepto 
				WHERE sintGrupoID in (1,2,4)	
				
			UNION
				SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'Transactions        ' FlatFileIdentificator
					,'01                  '
					,'Inversión capital'	
					
			UNION
				SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'Transactions        ' FlatFileIdentificator
					,'10                  '
					,'Inversión interés'	
					
			UNION
				SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'Transactions        ' FlatFileIdentificator
					,'11                  '
					,'Inversión provisionados'	
					
			UNION
				SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'Transactions        ' FlatFileIdentificator
					,'20                  '
					,'Inversión ISR'								
			UNION
				SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'Transactions        ' FlatFileIdentificator
					,'99                  '
					,'Pago a Capital (Vivienda)'	
		-- OJO CHECAR CON QUE CAMPO SE DEBE FILTRAR
			--INSERT INTO ##Transactions  
			--	( 
			--	 BankCode
			--	,isSwif
			--	,isABA
			--	,FlatFileIdentificator
			--	,BankMasterCode
			--	,BankMasterCodeDescription
			--	)
			--SELECT '040150                          ' BankCode
			--		,'T' isSwif
			--		,'F' isABA
			--		,'Transactions        ' FlatFileIdentificator
			--		,CASE WHEN intConceptoID>9 THEN 'CO0' + CAST(intConceptoID AS CHAR(3)) + '               '
			--			ELSE 'CO00' + CAST(intConceptoID AS CHAR(3)) + '               ' END intConceptoID				
			--		,vchDescripcion vchDescripcion
			--FROM SIHCEI.dbo.tbl_CAT_Concepto

--SELECT * FROM ##Transactions
--exec('exec master..xp_cmdshell ''C:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "Select * FROM ##Transactions" queryout "C:\Repositorio\PLD\Transactions.txt" -c -t "|" -S local -T -C ACP -r \n ''')

		


--	OBTIENE TransferOperKinds 
 IF EXISTS(SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME='##TransferOperKinds' AND TYPE='U')  
  DROP TABLE ##TransferOperKinds  
  
		 CREATE TABLE ##TransferOperKinds  
		 (  
		  [BankCode]  VARCHAR(32)  NULL,  
		  [isSwif]   VARCHAR(1) NULL,  
		  [isABA]  VARCHAR(1)  NULL,  
		  [FlatFileIdentificator]   VARCHAR(20)  NULL,  
		  [BankMasterCode]   VARCHAR(20)  NULL,  
		  [BankMasterCodeDescription]   VARCHAR(256)  NULL,    
		 )   

			INSERT INTO ##TransferOperKinds  
				( 
				 BankCode
				,isSwif
				,isABA
				,FlatFileIdentificator
				,BankMasterCode
				,BankMasterCodeDescription
				)
			SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'TransferOperKinds   ' FlatFileIdentificator
					,'TH' + Tim_Numero + '               ' Tim_Numero
					, 
					CASE WHEN Tim_Numero = 000033 THEN 'Traspaso a Cta. (ENV.)'
						 WHEN Tim_Numero = 000036 THEN 'Traspaso a Cta. (REC.)'
					ELSE
					REPLACE(Tim_Descri,'SPEUA','SPEI') 
					END Tim_Descri
			FROM SYB_LINK.dbBIM.dbo.CHTIPMOV  
				WHERE Tim_Numero like '4000%'
				--WHERE Tim_Numero in (400000, 400003)
				OR Tim_Numero in (000033, 000036)
--SELECT * FROM ##TransferOperKinds
--exec('exec master..xp_cmdshell ''C:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "Select * FROM ##TransferOperKinds" queryout "C:\Repositorio\PLD\TransferOperKinds.txt" -c -t "|" -S local -T -C ACP -r \n ''')

		
		
		

--	OBTIENE Countries 
 IF EXISTS(SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME='##Countries' AND TYPE='U')  
  DROP TABLE ##Countries  
  
		 CREATE TABLE ##Countries  
		 (  
		  [BankCode]  VARCHAR(32)  NULL,  
		  [isSwif]   VARCHAR(1) NULL,  
		  [isABA]  VARCHAR(1)  NULL,  
		  [FlatFileIdentificator]   VARCHAR(20)  NULL,  
		  [BankMasterCode]   VARCHAR(20)  NULL,  
		  [BankMasterCodeDescription]   VARCHAR(256)  NULL,    
		 )   

			INSERT INTO ##Countries  
				( 
				 BankCode
				,isSwif
				,isABA
				,FlatFileIdentificator
				,BankMasterCode
				,BankMasterCodeDescription
				)
			SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'Countries           ' FlatFileIdentificator
					,'PA' + Pai_Numero + '               ' Pai_Numero
					,Pai_Nombre Pai_Nombre
			FROM SYB_LINK.dbBIM.dbo.SOPAIS



--SELECT * FROM ##Countries
--exec('exec master..xp_cmdshell ''C:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "Select * FROM ##Countries" queryout "C:\Repositorio\PLD\Countries.txt" -c -t "|" -S local -T -C ACP -r \n ''')




--	OBTIENE EmployeeKinds 
 IF EXISTS(SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME='##EmployeeKinds' AND TYPE='U')  
  DROP TABLE ##EmployeeKinds  
  
		 CREATE TABLE ##EmployeeKinds  
		 (  
		  [BankCode]  VARCHAR(32)  NULL,  
		  [isSwif]   VARCHAR(1) NULL,  
		  [isABA]  VARCHAR(1)  NULL,  
		  [FlatFileIdentificator]   VARCHAR(20)  NULL,  
		  [BankMasterCode]   VARCHAR(20)  NULL,  
		  [BankMasterCodeDescription]   VARCHAR(256)  NULL,    
		 )   

			INSERT INTO ##EmployeeKinds  
				( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			SELECT 
				'040150                          ' BankCode,'T' isSwif,'F' isABA,'EmployeeKinds       ' FlatFileIdentificator,'EK001               ' Cue_Status,'Interno' Cue_Status


--SELECT * FROM ##EmployeeKinds
--exec('exec master..xp_cmdshell ''C:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "Select * FROM ##EmployeeKinds" queryout "C:\Repositorio\PLD\EmployeeKinds.txt" -c -t "|" -S local -T -C ACP -r \n ''')




--	OBTIENE CountryCities 
 IF EXISTS(SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME='##CountryCities' AND TYPE='U')  
  DROP TABLE ##CountryCities  
  
		 CREATE TABLE ##CountryCities  
		 (  
		  [BankCode]  VARCHAR(32)  NULL,  
		  [isSwif]   VARCHAR(1) NULL,  
		  [isABA]  VARCHAR(1)  NULL,  
		  [FlatFileIdentificator]   VARCHAR(20)  NULL,  
		  [BankMasterCode]   VARCHAR(20)  NULL,  
		  [BankMasterCodeDescription]   VARCHAR(256)  NULL,    
		 )   

			INSERT INTO ##CountryCities  
				( 
				 BankCode
				,isSwif
				,isABA
				,FlatFileIdentificator
				,BankMasterCode
				,BankMasterCodeDescription
				)
			SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'CountryCities       ' FlatFileIdentificator
					,Loc_Numero + '            ' Loc_Numero
					,Loc_Nombre
			FROM SYB_LINK.dbBIM.dbo.CLLOCALI
            UNION
            SELECT '040150              ' BankCode
                   ,'T' isSwif
                   ,'F' isABA
                   ,'CountryCities       ' FlatFileIdentificator
                   ,'99999999            ' Loc_Numero
                   ,'NO DISPONIBLE'

			
--SELECT * FROM ##CountryCities
--exec('exec master..xp_cmdshell ''C:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "Select * FROM ##CountryCities" queryout "C:\Repositorio\PLD\CountryCities.txt" -c -t "|" -S local -T -C ACP -r \n ''')




--	OBTIENE CountryZipCodes 
 IF EXISTS(SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME='##CountryZipCodes' AND TYPE='U')  
  DROP TABLE ##CountryZipCodes  
  
	 CREATE TABLE ##CountryZipCodes  
	 (  
	  [BankCode]  VARCHAR(32)  NULL,  
	  [isSwif]   VARCHAR(1) NULL,  
	  [isABA]  VARCHAR(1)  NULL,  
	  [FlatFileIdentificator]   VARCHAR(20)  NULL,  
	  [BankMasterCode]   VARCHAR(20)  NULL,  
	  [BankMasterCodeDescription]   VARCHAR(256)  NULL,    
	 )   

		INSERT INTO ##CountryZipCodes  
			( 
			 BankCode
			,isSwif
			,isABA
			,FlatFileIdentificator
			,BankMasterCode
			,BankMasterCodeDescription
			)
		SELECT DISTINCT '040150                          ' BankCode
				,'T' isSwif
				,'F' isABA
				,'CountryZipCodes     ' FlatFileIdentificator
				,CAST(Cpc_CodPos AS CHAR(5)) + '             ' COLLATE Modern_Spanish_CI_AI Cpc_CodPos
				,CAST(Cpc_CodPos AS CHAR(5)) + '             ' COLLATE Modern_Spanish_CI_AI Cpc_CodPos 
		FROM SYB_LINK.dbBIM.dbo.CLCODPOS
		UNION
		SELECT 
			DISTINCT '040150                          '				BankCode
				,'T'												 isSwif
				,'F'												isABA
				,'CountryZipCodes     '								FlatFileIdentificator
				,CAST(sCodigoPostal  AS CHAR(5))  + '             ' COLLATE Modern_Spanish_CI_AI	Cpc_CodPos
				,CAST(sCodigoPostal AS CHAR(5)) + '             '	COLLATE Modern_Spanish_CI_AI Cpc_CodPos 			
		FROM  [SIHCEI]..tbl_Sistema_Sepomex 
--SELECT * FROM ##CountryZipCodes
--exec('exec master..xp_cmdshell ''C:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "Select * FROM ##CountryZipCodes" queryout "C:\Repositorio\PLD\CountryZipCodes.txt" -c -t "|" -S local -T -C ACP -r \n ''')




--	OBTIENE CountryStates 
 IF EXISTS(SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME='##CountryStates' AND TYPE='U')  
  DROP TABLE ##CountryStates  
  
		 CREATE TABLE ##CountryStates  
		 (  
		  [BankCode]  VARCHAR(32)  NULL,  
		  [isSwif]   VARCHAR(1) NULL,  
		  [isABA]  VARCHAR(1)  NULL,  
		  [FlatFileIdentificator]   VARCHAR(20)  NULL,  
		  [BankMasterCode]   VARCHAR(20)  NULL,  
		  [BankMasterCodeDescription]   VARCHAR(256)  NULL,    
		 )   

			INSERT INTO ##CountryStates  
				( 
				 BankCode
				,isSwif
				,isABA
				,FlatFileIdentificator
				,BankMasterCode
				,BankMasterCodeDescription
				)
			SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'CountryStates       ' FlatFileIdentificator
					,LTRIM(RTRIM(Ent_AbBuCr))+REPLICATE(' ', 20 - LEN(LTRIM(RTRIM(Ent_AbBuCr)))) Ent_AbBuCr
					,LTRIM(RTRIM(Ent_Nombre)) Ent_Nombre			
			FROM SYB_LINK.dbBIM.dbo.CLENTIDA
			WHERE ClEntidaID <101			
			UNION
			SELECT '040150                          ' BankCode
						,'T' isSwif
						,'F' isABA
						,'CountryStates       ' FlatFileIdentificator
						, 'ND'+REPLICATE(' ', 18) Ent_AbBuCr
						,LTRIM(RTRIM('NO DISPONIBLE'))+REPLICATE(' ', 20 - LEN(LTRIM(RTRIM('NO DISPONIBLE')))) Ent_Nombre	

			--SELECT * FROM SYB_LINK.dbBIM.dbo.SOCIUENT
			--SELECT * FROM SYB_LINK.dbBIM.dbo.RELSOEST
			--select * FROM SYB_LINK.dbBIM.dbo.CLENTIDA
			--SELECT * FROM SYB_LINK.dbBIM.dbo.SOESTADO
			--SELECT * FROM ##CountryStates				
--exec('exec master..xp_cmdshell ''C:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "Select * FROM ##CountryStates" queryout "C:\Repositorio\PLD\CountryStates.txt" -c -t "|" -S local -T -C ACP -r \n ''')





--	OBTIENE CreditGuranteeKind 
 IF EXISTS(SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME='##CreditGuranteeKind' AND TYPE='U')  
  DROP TABLE ##CreditGuranteeKind  
  
		 CREATE TABLE ##CreditGuranteeKind  
		 (  
		  [BankCode]  VARCHAR(32)  NULL,  
		  [isSwif]   VARCHAR(1) NULL,  
		  [isABA]  VARCHAR(1)  NULL,  
		  [FlatFileIdentificator]   VARCHAR(20)  NULL,  
		  [BankMasterCode]   VARCHAR(20)  NULL,  
		  [BankMasterCodeDescription]   VARCHAR(256)  NULL,    
		 )   

			INSERT INTO ##CreditGuranteeKind  
				( 
				 BankCode
				,isSwif
				,isABA
				,FlatFileIdentificator
				,BankMasterCode
				,BankMasterCodeDescription
				)
			SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'CreditGuranteeKind  ' FlatFileIdentificator
					,CASE WHEN sintTipoGarantiaID>9 THEN 'GU0' + CONVERT(CHAR(2),sintTipoGarantiaID) + '               '
						ELSE 'GU00' + CONVERT(CHAR(1),sintTipoGarantiaID) + '               ' END sintTipoGarantiaID			
					,vchDescripcion vchDescripcion
			FROM SIHCEI.dbo.tbl_CAT_TipoGarantia

--SELECT * FROM ##CreditGuranteeKind	
--exec('exec master..xp_cmdshell ''C:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "Select * FROM ##CreditGuranteeKind" queryout "C:\Repositorio\PLD\CreditGuranteeKind.txt" -c -t "|" -S local -T -C ACP -r \n ''')




 IF EXISTS(SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME='##CreditGuarantorKind' AND TYPE='U')  
  DROP TABLE ##CreditGuarantorKind  
  
		 CREATE TABLE ##CreditGuarantorKind  
		 (  
		  [BankCode]  VARCHAR(32)  NULL,  
		  [isSwif]   VARCHAR(1) NULL,  
		  [isABA]  VARCHAR(1)  NULL,  
		  [FlatFileIdentificator]   VARCHAR(20)  NULL,  
		  [BankMasterCode]   CHAR(20)  NULL,  
		  [BankMasterCodeDescription]   VARCHAR(256)  NULL,    
		 )    

		--Créditos Individual
			INSERT INTO ##CreditGuarantorKind  
				( 
				 BankCode
				,isSwif
				,isABA
				,FlatFileIdentificator
				,BankMasterCode
				,BankMasterCodeDescription
				)
			SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'CreditGuarantorKind ' FlatFileIdentificator
					--,'GI00' + CAST(iCatalogoId AS CHAR(2)) iCatalogoId
					,CASE WHEN iCatalogoId>9 THEN 'GI0' + CONVERT(CHAR(2),iCatalogoId) + '               '
						ELSE 'GI00' + CONVERT(CHAR(2),iCatalogoId) + '               ' END iCatalogoId			
					,sDescCatalogo sDescCatalogo
			FROM SIHCEI.dbo.tbl_sistema_catalogos WHERE iAgrupaCatId=72 AND iCatalogoId IN (3, 15)


		--Créditos Empresarial
			INSERT INTO ##CreditGuarantorKind  
				( 
				 BankCode
				,isSwif
				,isABA
				,FlatFileIdentificator
				,BankMasterCode
				,BankMasterCodeDescription
				)
			SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'CreditGuarantorKind ' FlatFileIdentificator
					--,'GE00' + CAST(iCatalogoId AS CHAR(2)) iCatalogoId
					,CASE WHEN iCatalogoId>9 THEN 'GE0' + CONVERT(CHAR(2),iCatalogoId) + '               '	
						ELSE 'GE00' + CONVERT(CHAR(2),iCatalogoId) + '               ' END iCatalogoId				
					,sDescCatalogo sDescCatalogo
			FROM SIHCEI.dbo.tbl_sistema_catalogos WHERE iAgrupaCatId=83 AND iCatalogoId IN (2, 10, 19)

--SELECT * FROM ##CreditGuarantorKind
--exec('exec master..xp_cmdshell ''C:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "Select * FROM ##CreditGuarantorKind" queryout "C:\Repositorio\PLD\CreditGuarantorKind.txt" -c -t "|" -S local -T -C ACP -r \n ''')
	


--	OBTIENE PersonRelatCodes
 IF EXISTS(SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME='##PersonRelatCodes' AND TYPE='U')  
  DROP TABLE ##PersonRelatCodes  
  
		 CREATE TABLE ##PersonRelatCodes  
		 (  
		  [BankCode]  VARCHAR(32)  NULL,  
		  [isSwif]   VARCHAR(1) NULL,  
		  [isABA]  VARCHAR(1)  NULL,  
		  [FlatFileIdentificator]   VARCHAR(20)  NULL,  
		  [BankMasterCode]   VARCHAR(20)  NULL,  
		  [BankMasterCodeDescription]   VARCHAR(256)  NULL,    
		 )    

		--Créditos Individual
			INSERT INTO ##PersonRelatCodes  
				( 
				 BankCode
				,isSwif
				,isABA
				,FlatFileIdentificator
				,BankMasterCode
				,BankMasterCodeDescription
				)
			SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'PersonRelatCodes    ' FlatFileIdentificator
					,CASE WHEN iCatalogoId>9 THEN 'PI0' + CONVERT(CHAR(2),iCatalogoId) + '               '
						ELSE 'PI00' + CONVERT(CHAR(1),iCatalogoId) + '               ' END iCatalogoId			
					,sDescCatalogo sDescCatalogo							
                    FROM SIHCEI.dbo.tbl_sistema_catalogos WHERE iAgrupaCatId=47 and iCatalogoId < 14
                UNION
                       SELECT '040150              ' BankCode
                              ,'T' isSwif
                              ,'F' isABA
                              ,'PersonRelatCodes    ' FlatFileIdentificator
                              ,'PI014               '    iCatalogoId                
                              ,'SOBRINO(A)' sDescCatalogo
                UNION                                          
                       SELECT '040150              ' BankCode
                              ,'T' isSwif
                              ,'F' isABA
                              ,'PersonRelatCodes    ' FlatFileIdentificator
                              ,'PI015               '    iCatalogoId                
                              ,'NOVIO(A)' sDescCatalogo
                UNION                                          
                       SELECT '040150              ' BankCode
                              ,'T' isSwif
                              ,'F' isABA
                              ,'PersonRelatCodes    ' FlatFileIdentificator
                              ,'PI016               '    iCatalogoId                
                              ,'SUEGRO(A)' sDescCatalogo


		----Créditos Empresarial
		--	INSERT INTO ##PersonRelatCodes  
		--		( 
		--		 BankCode
		--		,isSwif
		--		,isABA
		--		,FlatFileIdentificator
		--		,BankMasterCode
		--		,BankMasterCodeDescription
		--		)
		--	SELECT '040150                          ' BankCode
		--			,'T' isSwif
		--			,'F' isABA
		--			,'PersonRelatCodes    ' FlatFileIdentificator
		--			,CASE WHEN iCatalogoId>9 THEN 'PE0' + CONVERT(CHAR(2),iCatalogoId)
		--				ELSE 'PE00' + CONVERT(CHAR(1),iCatalogoId) END iCatalogoId			
		--			,sDescCatalogo sDescCatalogo							
		--	FROM SIHCEI.dbo.tbl_sistema_catalogos WHERE iAgrupaCatId=83

--SELECT * FROM ##PersonRelatCodes
--exec('exec master..xp_cmdshell ''C:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "Select * FROM ##PersonRelatCodes" queryout "C:\Repositorio\PLD\PersonRelatCodes.txt" -c -t "|" -S local -T -C ACP -r \n ''')




--	OBTIENE EmployeeStatus 
 IF EXISTS(SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME='##EmployeeStatus' AND TYPE='U')  
  DROP TABLE ##EmployeeStatus  
  
		 CREATE TABLE ##EmployeeStatus  
		 (  
		  [BankCode]  VARCHAR(32)  NULL,  
		  [isSwif]   VARCHAR(1) NULL,  
		  [isABA]  VARCHAR(1)  NULL,  
		  [FlatFileIdentificator]   VARCHAR(20)  NULL,  
		  [BankMasterCode]   VARCHAR(20)  NULL,  
		  [BankMasterCodeDescription]   VARCHAR(256)  NULL,    
		 )   

			INSERT INTO ##EmployeeStatus  
				( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			SELECT 
				'040150                          ' BankCode,'T' isSwif,'F' isABA,'EmployeeStatus      ' FlatFileIdentificator,'ES001               ' Cue_Status,'Activo' Cue_Status
                           
            INSERT INTO ##EmployeeStatus  
				( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
            SELECT 
                '040150                          ' BankCode,'T' isSwif,'F' isABA,'EmployeeStatus      ' FlatFileIdentificator,'ES002               ' Cue_Status,'Baja' Cue_Status
			INSERT INTO ##EmployeeStatus  
				( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
            SELECT 
                '040150                          ' BankCode,'T' isSwif,'F' isABA,'EmployeeStatus      ' FlatFileIdentificator,'ES003               ' Cue_Status,'Reingreso' Cue_Status


--SELECT * FROM ##EmployeeStatus
--exec('exec master..xp_cmdshell ''C:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "Select * FROM ##EmployeeStatus" queryout "C:\Repositorio\PLD\EmployeeStatus.txt" -c -t "|" -S local -T -C ACP -r \n ''')





--	OBTIENE ProfessionCodes 
 IF EXISTS(SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME='##ProfessionCodes' AND TYPE='U')  
  DROP TABLE ##ProfessionCodes  
  
		 CREATE TABLE ##ProfessionCodes  
		 (  
		  [BankCode]  VARCHAR(32)  NULL,  
		  [isSwif]   VARCHAR(1) NULL,  
		  [isABA]  VARCHAR(1)  NULL,  
		  [FlatFileIdentificator]   VARCHAR(20)  NULL,  
		  [BankMasterCode]   VARCHAR(20)  NULL,  
		  [BankMasterCodeDescription]   VARCHAR(256)  NULL,    
		 )   

			INSERT INTO ##ProfessionCodes  
				( 
				 BankCode
				,isSwif
				,isABA
				,FlatFileIdentificator
				,BankMasterCode
				,BankMasterCodeDescription
				)
			SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'ProfessionCodes     ' FlatFileIdentificator
					,'PR0' + CAST(Pro_Numero AS CHAR(2)) + '               ' Pro_Numero
					,Pro_Descri Pro_Descri
			FROM SYB_LINK.dbBIM.dbo.CLPROFES

--SELECT * FROM ##ProfessionCodes	
--exec('exec master..xp_cmdshell ''C:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "Select * FROM ##ProfessionCodes" queryout "C:\Repositorio\PLD\ProfessionCodes.txt" -c -t "|" -S local -T -C ACP -r \n ''')




--	OBTIENE OccupationCodes 
 IF EXISTS(SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME='##OccupationCodes' AND TYPE='U')  
  DROP TABLE ##OccupationCodes  
  
		 CREATE TABLE ##OccupationCodes  
		 (  
		  [BankCode]  VARCHAR(32)  NULL,  
		  [isSwif]   VARCHAR(1) NULL,  
		  [isABA]  VARCHAR(1)  NULL,  
		  [FlatFileIdentificator]   VARCHAR(20)  NULL,  
		  [BankMasterCode]   VARCHAR(20)  NULL,  
		  [BankMasterCodeDescription]   VARCHAR(256)  NULL,    
		 )   

			INSERT INTO ##OccupationCodes  
				( 
				 BankCode
				,isSwif
				,isABA
				,FlatFileIdentificator
				,BankMasterCode
				,BankMasterCodeDescription
				)
			SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'OccupationCodes     ' FlatFileIdentificator
					,'PU' + CAST(Pue_Numero AS CHAR(3)) + '               ' Pue_Numero
					,Pue_Descri Pue_Descri
			FROM SYB_LINK.dbBIM.dbo.CLPUESTO

			INSERT INTO ##OccupationCodes  
				( 
				 BankCode
				,isSwif
				,isABA
				,FlatFileIdentificator
				,BankMasterCode
				,BankMasterCodeDescription
				)
			SELECT '040150                          ' BankCode
					,'T' isSwif
					,'F' isABA
					,'OccupationCodes     ' FlatFileIdentificator
					,CASE 
						WHEN idpuesto<10 THEN 'PN00' + rtrim(CAST(idpuesto AS CHAR)) + '               '
						WHEN idpuesto<100 THEN 'PN0' + rtrim(CAST(idpuesto AS CHAR)) + '               '
						WHEN idpuesto<1000 THEN 'PN' + rtrim(CAST(idpuesto AS CHAR)) + '               ' END
						idpuesto
					,descripcion descripcion
			FROM [LSPLD_NOM].[ctBANCO_INMOBILI2].[dbo].[nom10006]
			WHERE idpuesto not in (192,222,223)


--SELECT * FROM ##OccupationCodes  --SELECT * FROM [LSPLD_NOM].[ctBANCO_INMOBILI2].[dbo].[nom10003] ORDER BY idpuesto ASC
--exec('exec master..xp_cmdshell ''C:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "Select * FROM ##OccupationCodes" queryout "C:\Repositorio\PLD\OccupationCodes.txt" -c -t "|" -S local -T -C ACP -r \n ''')




--	OBTIENE LegalIdKindCodes 
 IF EXISTS(SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME='##LegalIdKindCodes' AND TYPE='U')  
  DROP TABLE ##LegalIdKindCodes  
  
		 CREATE TABLE ##LegalIdKindCodes  
		 (  
		  [BankCode]  VARCHAR(32)  NULL,  
		  [isSwif]   VARCHAR(1) NULL,  
		  [isABA]  VARCHAR(1)  NULL,  
		  [FlatFileIdentificator]   VARCHAR(20)  NULL,  
		  [BankMasterCode]   VARCHAR(20)  NULL,  
		  [BankMasterCodeDescription]   VARCHAR(256)  NULL,    
		 )   

			INSERT INTO ##LegalIdKindCodes  
				( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			SELECT 
				'040150                          ' BankCode,'T' isSwif,'F' isABA,'LegalIdKindCodes    ' FlatFileIdentificator, 'LG001               ' Cue_Status, 'RFC' Cue_Status

			INSERT INTO ##LegalIdKindCodes  
				( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription)
			SELECT 
				'040150                          ' BankCode,'T' isSwif,'F' isABA,'LegalIdKindCodes    ' FlatFileIdentificator, 'LG002               ' Cue_Status, 'CURP' Cue_Status

--SELECT * FROM ##LegalIdKindCodes
--exec('exec master..xp_cmdshell ''C:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "Select * FROM ##LegalIdKindCodes" queryout "C:\Repositorio\PLD\LegalIdKindCodes.txt" -c -t "|" -S local -T -C ACP -r \n ''')


 IF EXISTS(SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME='##MasterCodeTemplate' AND TYPE='U')  
  DROP TABLE ##MasterCodeTemplate  
  
		 CREATE TABLE ##MasterCodeTemplate  
		 (  
		  [BankCode]  VARCHAR(32)  NULL,  
		  [isSwif]   VARCHAR(1) NULL,  
		  [isABA]  VARCHAR(1)  NULL,  
		  [FlatFileIdentificator]   VARCHAR(20)  NULL,  
		  [BankMasterCode]   CHAR(20)  NULL,  
		  [BankMasterCodeDescription]   VARCHAR(256)  NULL--,  
		  --Limite VARCHAR(1)
		 )    
INSERT INTO ##MasterCodeTemplate ( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription) SELECT BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription + '                                                                                                                                                                                                                                                                                      ' FROM ##InstrumentKinds
INSERT INTO ##MasterCodeTemplate ( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription) SELECT BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription + '                                                                                                                                                                                                                                                                                      ' FROM ##InstrumentStatus
INSERT INTO ##MasterCodeTemplate ( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription) SELECT BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription + '                                                                                                                                                                                                                                                                                      ' FROM ##ClientKinds
INSERT INTO ##MasterCodeTemplate ( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription) SELECT BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription + '                                                                                                                                                                                                                                                                                      ' FROM ##ClientEconActCodes
INSERT INTO ##MasterCodeTemplate ( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription) SELECT BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription + '                                                                                                                                                                                                                                                                                      ' FROM ##Currencies
INSERT INTO ##MasterCodeTemplate ( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription) SELECT BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription + '                                                                                                                                                                                                                                                                                      ' FROM ##Transactions
INSERT INTO ##MasterCodeTemplate ( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription) SELECT BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription + '                                                                                                                                                                                                                                                                                      ' FROM ##TransferOperKinds
INSERT INTO ##MasterCodeTemplate ( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription) SELECT BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription + '                                                                                                                                                                                                                                                                                      ' FROM ##Countries
INSERT INTO ##MasterCodeTemplate ( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription) SELECT BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription + '                                                                                                                                                                                                                                                                                      ' FROM ##EmployeeKinds
INSERT INTO ##MasterCodeTemplate ( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription) SELECT BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription + '                                                                                                                                                                                                                                                                                      ' FROM ##CountryCities
INSERT INTO ##MasterCodeTemplate ( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription) SELECT BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription + '                                                                                                                                                                                                                                                                                      ' FROM ##CountryZipCodes
INSERT INTO ##MasterCodeTemplate ( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription) SELECT BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription + '                                                                                                                                                                                                                                                                                      ' FROM ##CountryStates
INSERT INTO ##MasterCodeTemplate ( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription) SELECT BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription + '                                                                                                                                                                                                                                                                                      ' FROM ##CreditGuranteeKind
INSERT INTO ##MasterCodeTemplate ( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription) SELECT BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription + '                                                                                                                                                                                                                                                                                      ' FROM ##CreditGuarantorKind
INSERT INTO ##MasterCodeTemplate ( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription) SELECT BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription + '                                                                                                                                                                                                                                                                                      ' FROM ##PersonRelatCodes
INSERT INTO ##MasterCodeTemplate ( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription) SELECT BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription + '                                                                                                                                                                                                                                                                                      ' FROM ##EmployeeStatus
INSERT INTO ##MasterCodeTemplate ( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription) SELECT BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription + '                                                                                                                                                                                                                                                                                      ' FROM ##ProfessionCodes
INSERT INTO ##MasterCodeTemplate ( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription) SELECT BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription + '                                                                                                                                                                                                                                                                                      ' FROM ##OccupationCodes
INSERT INTO ##MasterCodeTemplate ( BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription) SELECT BankCode,isSwif,isABA,FlatFileIdentificator,BankMasterCode,BankMasterCodeDescription + '                                                                                                                                                                                                                                                                                      ' FROM ##LegalIdKindCodes

exec('exec master..xp_cmdshell ''C:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "Select * FROM ##MasterCodeTemplate" queryout "C:\Repositorio\Occam\Master-Code-Template.txt" -c -t "" -S local -T -C ACP -r \n ''')
SELECT * FROM ##MasterCodeTemplate
				
END


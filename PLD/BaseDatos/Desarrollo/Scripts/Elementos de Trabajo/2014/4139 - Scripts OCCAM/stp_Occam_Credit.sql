USE [dbPLD]
--	EXECUTE stp_Occam_Credit
GO
/****** Object:  StoredProcedure [dbo].[stp_Occam_Credit]    Script Date: 07/02/2014 12:23:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dante Tellez
-- Create date: 2-Junio-2014
-- Description:	Genera el Master Code para Occam
-- =============================================
ALTER PROCEDURE [dbo].[stp_Occam_Credit]
AS
BEGIN
	DECLARE @intSpace INTEGER, @FecIni CHAR(8), @chSpace CHAR(256)
	SET @intSpace = 256
	SET @FecIni = convert(varchar,GETDATE(),112)
	SET @chSpace = '                                                                                                                                '

	EXEC SIHCEI.dbo.stp_getInterfazCreditos_Universo '', @FecIni, '', 0

-------------------------------------	
--	OBTIENE CREDITOS EMPRESARIALES --
-------------------------------------
 IF EXISTS(SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME='##Credit' AND TYPE='U')  
  DROP TABLE ##Credit  
  
		 CREATE TABLE ##Credit  
		 (  
			[BankCode]					VARCHAR(32)		NULL,  
			[isSwif]					VARCHAR(1)		NULL,  
			[isABA]						VARCHAR(1)		NULL,  
			[CreditNumber]				VARCHAR(30)		NULL,  
			[CompanyLegalId1]			VARCHAR(20)		NULL,  
			[PersonLegalId1]			VARCHAR(20)		NULL,  
			[RegistrationBranchCode]	VARCHAR(20)		NULL,
			[RegistrationOperatorCode]	VARCHAR(30)		NULL,
			[RegistrationAuthorizer]	VARCHAR(30)		NULL,
			[RegistrationDate]			VARCHAR(23)		NULL,
			[CancelationDate]			VARCHAR(23)		NULL,
			[InstrumentStatusCode]		VARCHAR(20)		NULL,
			[InstrumentKindCode]		VARCHAR(20)		NULL,
			[Currency]					VARCHAR(20)		NULL,
			[Amount]					VARCHAR(20)		NULL,
			[StartDate]					VARCHAR(23)		NULL,
			[ExpectedEndDate]			VARCHAR(23)		NULL,
			[ActualEndDate]				VARCHAR(23)		NULL,
			[PaymentPlan]				VARCHAR(128)	NULL,
			[ExpectedPayments]			VARCHAR(3)		NULL,
			[ActualPayments]			VARCHAR(4)		NULL,
			[DaysBetweenPayments]		VARCHAR(5)		NULL,
			[SinglePaymentDate]			VARCHAR(23)		NULL,
			[InitialPaymentAmount]		VARCHAR(20)		NULL,
			[PaymentsAmount]			VARCHAR(20)		NULL,
			[InterestRate]				VARCHAR(6)		NULL,
			[AccountNumber]				VARCHAR(30)		NULL,
			[CreditCardNumber]			VARCHAR(30)		NULL,
			[Description]				VARCHAR(100)	NULL,
			[Remarks]					VARCHAR(100)	NULL,
			[Limite]					VARCHAR(1)		NULL
		 )  
		----Cuentas TR ASCENDENTE & Cuentas Fiducuiario
			INSERT INTO ##Credit  
				( 
				 BankCode
				,isSwif
				,isABA
				,CreditNumber
				,CompanyLegalId1
				,PersonLegalId1
				,RegistrationBranchCode
				,RegistrationOperatorCode
				,RegistrationAuthorizer
				,RegistrationDate
				,CancelationDate
				,InstrumentStatusCode
				,InstrumentKindCode
				,Currency 
				,Amount 
				,StartDate 
				,ExpectedEndDate 
				,ActualEndDate
				,PaymentPlan 
				,ExpectedPayments
				,ActualPayments 
				,DaysBetweenPayments 
				,SinglePaymentDate 
				,InitialPaymentAmount 
				,PaymentsAmount
				,InterestRate
				,AccountNumber
				,CreditCardNumber
				,[Description]
				,Remarks 				
				)
			SELECT '040150                          '								BankCode
					,'T'															isSwif
					,'F'															isABA
					--,ISNULL(op.vchNoCredito,'') + @chSpace							CreditNumber
					--,ISNULL(op.iOperacionId,'') + @chSpace							CreditNumber
					
					,CASE WHEN op.iOperacionId<10 THEN CONVERT(CHAR(1),op.iOperacionId) + @chSpace
					WHEN op.iOperacionId<100 THEN CONVERT(CHAR(2),op.iOperacionId) + @chSpace
					WHEN op.iOperacionId<1000 THEN CONVERT(CHAR(3),op.iOperacionId) + @chSpace
					WHEN op.iOperacionId<10000 THEN CONVERT(CHAR(4),op.iOperacionId) + @chSpace
					ELSE CONVERT(CHAR(5),op.iOperacionId) + @chSpace END			CreditNumber
					
					,CAST(op.iPersonaId AS CHAR(5)) + @chSpace						CompanyLegalId1
					,Cli.Cli_RFC + @chSpace											PersonLegalId1
					,CASE 
						WHEN op.iSucursalId<10 THEN '00' + rtrim(CAST(op.iSucursalId AS CHAR)) + @chSpace
						WHEN op.iSucursalId<100 THEN '0' + rtrim(CAST(op.iSucursalId AS CHAR)) + @chSpace
						WHEN op.iSucursalId<1000 THEN '' + rtrim(CAST(op.iSucursalId AS CHAR)) + @chSpace END
																					RegistrationBranchCode
					,ISNULL(EmUs.codigoempleado,'') + @chSpace						RegistrationOperatorCode
					,ISNULL(EmUsAut.codigoempleado,'') + @chSpace					RegistrationAuthorizer	--Empleado que autorizó el credito
					,Convert(varchar,op.FAlta,120) + @chSpace						RegistrationDate
					,@chSpace														CancelationDate	--ISNULL(Convert(varchar,datFechaLiquidacion,120),'')
					,right('0000'+convert(varchar(4), iEstatusId), 4) + @chSpace	InstrumentStatusCode 
					--,right('0000'+convert(varchar(4), iCondicionId), 4) + @chSpace	InstrumentKindCode
					,right('0000'+convert(varchar(4), con.iProductoId), 4) + @chSpace	InstrumentKindCode
					,right('CU00'+convert(varchar(5), pg.iMonedaID), 5) + @chSpace	Currency 
					,'        ' + CAST(MConcedido AS CHAR(13))						Amount 
					,Convert(varchar,FFirma,120) + @chSpace							StartDate 
					,Convert(varchar,FVencimiento,120) + @chSpace					ExpectedEndDate 
					--,Convert(varchar,ISNULL(datFechaLiquidacion,''),120) + @chSpace			ActualEndDate
					,CASE WHEN ISNULL(datFechaLiquidacion,'')='' THEN @chSpace
					ELSE Convert(varchar,datFechaLiquidacion,120) + @chSpace END	ActualEndDate
					,@chSpace														PaymentPlan 
					,@chSpace														ExpectedPayments 
					,ISNULL(op2.Pagos,0) + ISNULL(op3.Pagos,0)						ActualPayments 
					,@chSpace														DaysBetweenPayments 
					,@chSpace														SinglePaymentDate 
					,ISNULL(pin.decMontoDp,0)										InitialPaymentAmount	
					,@chSpace														PaymentsAmount
					,cg.TasaInteres													InterestRate
					,@chSpace														AccountNumber
					,@chSpace														CreditCardNumber
					,@chSpace														Descripcion
					,@chSpace														Remarks 
			FROM SIHCEI.dbo.tbl_Operaciones op 
			INNER JOIN SIHCEI.dbo.tmp_CreditosEmpresariales tmp ON op.iOperacionId = tmp.iOperacionId	--Obtiene solo los creditos activos 
			INNER JOIN SIHCEI.dbo.tbl_Operaciones_Generales pg ON op.iOperacionId = pg.iOperacionId		--Obtiene la moneda

			LEFT JOIN SIHCEI.dbo.tbl_Personas per ON op.iPersonaId = per.iPersonaId						--Obtiene el RFC del cliente
				LEFT JOIN SYB_LINK.dbBIM.dbo.CLRELCLI Rlc ON per.iPersonaId = Rlc.Rcl_NoClCo
				INNER JOIN SYB_LINK.dbBIM.dbo.CLCLIENT Cli ON Rcl_Numero=Cli_Numero
			
			LEFT JOIN																					--Obtiene  ActualPayments
						(SELECT op.iOperacionId, COUNT(*) Pagos
							FROM SIHCEI.dbo.tbl_Operaciones op 
							INNER JOIN SIHCEI.dbo.tbl_MST_Pago mp ON op.iOperacionId = mp.iOperacionId
							INNER JOIN SIHCEI.dbo.tbl_DET_Pago dp ON mp.intPagoID = dp.intPagoID 
							WHERE intConceptoID=1	--PAGO A CAPITAL
							GROUP BY op.iOperacionId) 
					op2 ON op.iOperacionId = op2.iOperacionId
					
			LEFT JOIN 
						(SELECT op.iOperacionId, COUNT(*) Pagos
							FROM SIHCEI.dbo.tbl_Operaciones op 
							INNER JOIN SIHCEI.dbo.tbl_MST_Pago mp ON op.iOperacionId = mp.iOperacionId
							INNER JOIN SIHCEI.dbo.tbl_DET_PagoViv dp ON mp.intPagoID = dp.intPagoID 
							GROUP BY op.iOperacionId)
					op3 ON op2.iOperacionId = op3.iOperacionId
					
			LEFT JOIN																					--Obtiene la tasa de interes
						(SELECT iOperacionId, SUM(decValor) TasaInteres FROM SIHCEI.dbo.tbl_MST_CondGralesCredito	
						WHERE intConceptoID  in (15,19)
						GROUP BY iOperacionId)
					cg ON op.iOperacionId = cg.iOperacionId
				
			LEFT JOIN 					
						(SELECT op.iOperacionId, mp.decMonto, dp.decMonto decMontoDp
							FROM SIHCEI.dbo.tbl_Operaciones op 
							INNER JOIN SIHCEI.dbo.tbl_MST_Pago mp ON op.iOperacionId = mp.iOperacionId
							INNER JOIN SIHCEI.dbo.tbl_DET_Pago dp ON mp.intPagoID = dp.intPagoID 
							INNER JOIN (
																		
								SELECT op.iOperacionId, MIN(intDetPagoID) intDetPagoID
									FROM SIHCEI.dbo.tbl_Operaciones op 
									INNER JOIN SIHCEI.dbo.tbl_MST_Pago mp ON op.iOperacionId = mp.iOperacionId
									INNER JOIN SIHCEI.dbo.tbl_DET_Pago dp ON mp.intPagoID = dp.intPagoID 
									WHERE intConceptoID=1	--PAGO A CAPITAL
									GROUP BY op.iOperacionId
								)
								de ON op.iOperacionId = de.iOperacionId AND dp.intDetPagoID=de.intDetPagoID	)
					pin ON op.iOperacionId = pin.iOperacionId

			LEFT JOIN 
						RELEMPUSU EmUs ON op.UAlta=EmUs.intUsuarioID
					
						
			LEFT JOIN 
			
						(SELECT iOperacionID, codigoempleado FROM RELEMPUSU rEmUs INNER JOIN 
							(SELECT --DMI.intResolucionId, 
								 DMI.iOperacionID, 
								 --OCR.sdatFecAutorizaComite,
								 UPPER(OCR.vchUserAutorizaComite) vchUserAutorizaComite,
								 USR.intUsuarioID,
								 USR.sintNumEmpleado
							FROM SIHCEI.dbo.tbl_Operaciones OPE
							INNER JOIN SIHCEI.dbo.tbl_DET_Minuta DMI ON OPE.iOperacionID = DMI.iOperacionID
							INNER JOIN SIHCEI.dbo.Tbl_OriginaCredito OCR ON OCR.intMinutaId = DMI.intMinutaId
							LEFT OUTER JOIN dbSIE..tbl_CAT_Usuarios USR ON USR.vchUsuario COLLATE Modern_Spanish_CI_AS = OCR.vchUserAutorizaComite COLLATE Modern_Spanish_CI_AS

							WHERE DMI.bitActivo = 1 AND DMI.intResolucionId=1 AND ISNULL(vchUserAutorizaComite,'')<>''
							)
							rEmUs1 ON rEmUs1.intUsuarioID=rEmUs.intUsuarioID
						) 
						EmUsAut ON EmUsAut.iOperacionID=op.iOperacionID

			LEFT JOIN 
					SIHCEI.dbo.tbl_condiciones con ON  op.iCondicionId=con.iCondicionId 
					
			--INNER JOIN SIHCEI.dbo.tbl_Personas_Referencias pr ON op.iPersonaId=pr.iPersonaId
					
			ORDER BY op.iOperacionId


UPDATE ##Credit SET ActualPayments = right(@chSpace+convert(varchar(3), ActualPayments), 3),
					InitialPaymentAmount = right(@chSpace+convert(varchar(20), InitialPaymentAmount), 20),
					PaymentsAmount = @chSpace,
					InterestRate = right(@chSpace+convert(varchar(6), InterestRate), 6),
					RegistrationOperatorCode = RegistrationOperatorCode + @chSpace,
					PaymentPlan = @chSpace






-------------------------------------	
--	OBTIENE CREDITOS INDIVIDUALES  --
-------------------------------------
				INSERT INTO ##Credit  
				( 
				 BankCode
				,isSwif
				,isABA
				,CreditNumber
				,CompanyLegalId1
				,PersonLegalId1
				,RegistrationBranchCode
				,RegistrationOperatorCode
				,RegistrationAuthorizer
				,RegistrationDate
				,CancelationDate
				,InstrumentStatusCode
				,InstrumentKindCode
				,Currency 
				,Amount 
				,StartDate 
				,ExpectedEndDate 
				,ActualEndDate
				,PaymentPlan 
				,ExpectedPayments
				,ActualPayments 
				,DaysBetweenPayments 
				,SinglePaymentDate 
				,InitialPaymentAmount 
				,PaymentsAmount
				,InterestRate
				,AccountNumber
				,CreditCardNumber
				,[Description]
				,Remarks 				
				)			
			SELECT '040150                          '								BankCode
					,'T'															isSwif
					,'F'															isABA
					--,ISNULL(op.vchNoCredito,'') + @chSpace							CreditNumber
					,CASE WHEN op.iOperacionId<10 THEN CONVERT(CHAR(1),op.iOperacionId) + @chSpace
					WHEN op.iOperacionId<100 THEN CONVERT(CHAR(2),op.iOperacionId) + @chSpace
					WHEN op.iOperacionId<1000 THEN CONVERT(CHAR(3),op.iOperacionId) + @chSpace
					WHEN op.iOperacionId<10000 THEN CONVERT(CHAR(4),op.iOperacionId) + @chSpace
					ELSE CONVERT(CHAR(5),op.iOperacionId) + @chSpace END			CreditNumber
					--,ISNULL(op.iOperacionId,'') + @chSpace							CreditNumber
					,Cli.Cli_RFC + @chSpace											CompanyLegalId1
					,Cli.Cli_RFC + @chSpace											PersonLegalId1					
					,CASE 
						WHEN op.iSucursalId<10 THEN '00' + rtrim(CAST(op.iSucursalId AS CHAR)) + @chSpace
						WHEN op.iSucursalId<100 THEN '0' + rtrim(CAST(op.iSucursalId AS CHAR)) + @chSpace
						WHEN op.iSucursalId<1000 THEN '' + rtrim(CAST(op.iSucursalId AS CHAR)) + @chSpace END
																					RegistrationBranchCode
					,CASE 
						WHEN op.UAlta<0 THEN '0000' + @chSpace
						ELSE RIGHT('0000'+convert(varchar(4), op.UAlta), 4) END 	RegistrationOperatorCode
					,ISNULL(us.codigoempleado,'') + @chSpace						RegistrationAuthorizer	--Empleado que autorizó el credito
					,Convert(varchar,op.FAlta,120) + @chSpace						RegistrationDate
					,@chSpace														CancelationDate	--ISNULL(Convert(varchar,datFechaLiquidacion,120),'')
					,right('0000'+convert(varchar(4), iEstatusId), 4) + @chSpace	InstrumentStatusCode 
					--,right('0000'+convert(varchar(4), iCondicionId), 4) + @chSpace	InstrumentKindCode
					,right('0000'+convert(varchar(4), con.iProductoId), 4) + @chSpace	InstrumentKindCode
					,right('CU00'+convert(varchar(5), pg.iMonedaID), 5) + @chSpace	Currency 
					,'        ' + CAST(MConcedido AS CHAR(13))						Amount 
					,Convert(varchar,FFirma,120) + @chSpace							StartDate 
					,Convert(varchar,DATEADD(mm, iPlazo, FFirma),120) + @chSpace	ExpectedEndDate 
					,Convert(varchar,opap.FPago_Real,120) + @chSpace				ActualEndDate    
					,@chSpace														PaymentPlan 
					,ISNULL(CAST(opa1.iNAmortizacionId AS CHAR(13)),0) + @chSpace	ExpectedPayments 
					,ISNULL(opa2.iNAmortizacionId,0) + @chSpace						ActualPayments 
					,'30' + @chSpace												DaysBetweenPayments 
					--,Convert(varchar,FVencimiento,120) + @chSpace					SinglePaymentDate 
					,CASE WHEN ISNULL(FVencimiento,'')='' THEN @chSpace
					ELSE Convert(varchar,FVencimiento,120) + @chSpace END			SinglePaymentDate					
					--,ISNULL(opa3.MPago,0)											InitialPaymentAmount	
					--,Convert(varchar,opr.MPago_Mini) + @chSpace						InitialPaymentAmount	
					,CASE WHEN ISNULL(opr.MPago_Mini,0)=0 THEN @chSpace
					ELSE Convert(varchar,opr.MPago_Mini) + @chSpace END				InitialPaymentAmount	
					,@chSpace														PaymentsAmount
					,ISNULL(oc.Dato,0) + @chSpace									InterestRate
					,@chSpace														AccountNumber
					,@chSpace														CreditCardNumber
					,cpr.vchPrograma + @chSpace										Descripcion
					,@chSpace														Remarks 
			FROM SIHCEI.dbo.tbl_Operaciones op 
			INNER JOIN SIHCEI_Adm.dbo.tmp_CreditosIndividuales tmp ON op.iOperacionId = tmp.iOperacionId	--Obtiene los solo creditos activos 
			INNER JOIN SIHCEI_Adm.dbo.tbl_Operaciones_Generales pg ON op.iOperacionId = pg.iOperacionId		--Obtiene la moneda
			LEFT JOIN 
					RELEMPUSU us ON op.iVendedorId = us.intUsuarioID
			LEFT JOIN 
					SIHCEI_Adm.dbo.tbl_condiciones con ON  op.iCondicionId=con.iCondicionId
					
			LEFT JOIN SIHCEI_Adm.dbo.tbl_Personas per ON op.iPersonaId = per.iPersonaId						--Obtiene el RFC del cliente
				LEFT JOIN SYB_LINK.dbBIM.dbo.CLRELCLI Rlc ON per.iPersonaId = Rlc.Rcl_NoClCo
				INNER JOIN SYB_LINK.dbBIM.dbo.CLCLIENT Cli ON Rcl_Numero=Cli_Numero
			
			LEFT JOIN																					--Obtiene  ActualPayments
						(SELECT op.iOperacionId, COUNT(*) Pagos
							FROM SIHCEI_Adm.dbo.tbl_Operaciones op 
							INNER JOIN SIHCEI_Adm.dbo.tbl_MST_Pago mp ON op.iOperacionId = mp.iOperacionId
							INNER JOIN SIHCEI_Adm.dbo.tbl_DET_Pago dp ON mp.intPagoID = dp.intPagoID 
							WHERE intConceptoID=1	--PAGO A CAPITAL
							GROUP BY op.iOperacionId) 
					op2 ON op.iOperacionId = op2.iOperacionId
			LEFT JOIN 
						(SELECT op.iOperacionId, COUNT(*) Pagos
							FROM SIHCEI_Adm.dbo.tbl_Operaciones op 
							INNER JOIN SIHCEI_Adm.dbo.tbl_MST_Pago mp ON op.iOperacionId = mp.iOperacionId
							INNER JOIN SIHCEI_Adm.dbo.tbl_DET_PagoViv dp ON mp.intPagoID = dp.intPagoID 
							GROUP BY op.iOperacionId)
					op3 ON op2.iOperacionId = op3.iOperacionId
					
			LEFT JOIN																					--Obtiene la tasa de interes
						(SELECT iOperacionId, SUM(decValor) TasaInteres FROM SIHCEI_Adm.dbo.tbl_MST_CondGralesCredito	
						WHERE intConceptoID  in (15,19)
						GROUP BY iOperacionId)
					cg ON op.iOperacionId = cg.iOperacionId
				
			LEFT JOIN 					
						(SELECT op.iOperacionId, mp.decMonto, dp.decMonto decMontoDp
							FROM SIHCEI_Adm.dbo.tbl_Operaciones op 
							INNER JOIN SIHCEI_Adm.dbo.tbl_MST_Pago mp ON op.iOperacionId = mp.iOperacionId
							INNER JOIN SIHCEI_Adm.dbo.tbl_DET_Pago dp ON mp.intPagoID = dp.intPagoID 
							INNER JOIN (
																		
								SELECT op.iOperacionId, MIN(intDetPagoID) intDetPagoID
									FROM SIHCEI_Adm.dbo.tbl_Operaciones op 
									INNER JOIN SIHCEI_Adm.dbo.tbl_MST_Pago mp ON op.iOperacionId = mp.iOperacionId
									INNER JOIN SIHCEI_Adm.dbo.tbl_DET_Pago dp ON mp.intPagoID = dp.intPagoID 
									WHERE intConceptoID=1	--PAGO A CAPITAL
									GROUP BY op.iOperacionId
								)
								de ON op.iOperacionId = de.iOperacionId AND dp.intDetPagoID=de.intDetPagoID	)
					pin ON op.iOperacionId = pin.iOperacionId
			
			LEFT JOIN SIHCEI_Adm.dbo.tbl_Operaciones_Credito oc ON op.iOperacionId = oc.iOperacionId AND iTDatoId=37	--Obtiene la tasa de interes
			
			LEFT JOIN
					(SELECT iOperacionId, MAX(iNAmortizacionId) iNAmortizacionId FROM SIHCEI_Adm_Consulta.dbo.tbl_Operaciones_Pagos_Aplicaciones 
						WHERE iNAmortizacionId < 9999 GROUP BY iOperacionId)
					opa1 ON op.iOperacionId = opa1.iOperacionId	
							
			LEFT JOIN
					(SELECT iOperacionId, MAX(iNAmortizacionId) iNAmortizacionId FROM SIHCEI_Adm_Consulta.dbo.tbl_Operaciones_Pagos_Aplicaciones 
						WHERE sEstatusMig='S' GROUP BY iOperacionId)
					opa2 ON op.iOperacionId = opa2.iOperacionId			
			
			LEFT JOIN 
					(SELECT opg.iOperacionId, MPago FROM SIHCEI_Adm_Consulta.dbo.tbl_Operaciones_Pagos opg INNER JOIN (
						SELECT iOperacionId, MIN(iPagoId) iPagoId FROM SIHCEI_Adm_Consulta.dbo.tbl_Operaciones_Pagos 
						GROUP BY iOperacionId)
						op2 ON opg.iOperacionId=op2.iOperacionId AND opg.iPagoId=op2.iPagoId)
					opa3 ON op.iOperacionId=opa3.iOperacionId		
			
			LEFT JOIN 
					(SELECT iOperacionId, MAX(FPago_Real) FPago_Real FROM SIHCEI_Adm.dbo.tbl_Operaciones_Pagos_Aplicaciones 
					GROUP BY iOperacionId)
					opap ON op.iOperacionId=opap.iOperacionId
			
			--INNER JOIN SIHCEI_Adm.dbo.tbl_Personas_Referencias pr ON op.iPersonaId=pr.iPersonaId
			
			LEFT JOIN 
					(SELECT iOperacionId, MPago_Mini  FROM SIHCEI_Adm.dbo.tbl_Operaciones_Recibos 
					WHERE FEmis BETWEEN CONVERT(DATETIME, '01-'
							+ CONVERT(CHAR,MONTH(GETDATE())) 
							+ '-' + CONVERT(CHAR,YEAR(GETDATE()), 103)) AND 
							DATEADD(DAY,-1,CONVERT(DATETIME, '01-'
							+ CONVERT(CHAR,MONTH(DATEADD(MONTH,1,GETDATE())))
							+ '-' + CONVERT(CHAR,YEAR(GETDATE()), 103))) AND iPagoId=0)
					opr ON op.iOperacionId=opr.iOperacionId	
					
			LEFT JOIN 
					SIHCEI.dbo.tbl_CAT_Condicion_Programa cpr ON op.iCondicionId=cpr.iCondicionId AND op.iProgramaId=cpr.iProgramaId
					
			ORDER BY op.iOperacionId


UPDATE ##Credit SET ActualPayments = right(@chSpace+convert(varchar(3), ActualPayments), 3),
					InitialPaymentAmount = right(@chSpace+convert(varchar(20), InitialPaymentAmount), 20),
					PaymentsAmount = @chSpace,
					InterestRate = right(@chSpace+convert(varchar(6), InterestRate), 6),
					RegistrationOperatorCode = RegistrationOperatorCode + @chSpace,
					PaymentPlan = @chSpace
					
exec('exec master..xp_cmdshell ''C:\"Program Files"\"Microsoft SQL Server"\100\Tools\Binn\bcp.exe "Select * FROM ##Credit" queryout   "C:\Repositorio\PLD\Credit.txt" -c -t "|" -S local -T -C ACP -r \n ''')

--SELECT * FROM SIHCEI.dbo.tbl_Operaciones_Credito
SELECT * FROM ##Credit

END		 




USE [SIHCEI]
GO
/****** Object:  StoredProcedure [dbo].[stp_setTercerasPersonas]    Script Date: 06/10/2014 14:17:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--	sp_helptext stp_setTercerasPersonas
--	EXEC stp_setTercerasPersonas  
--	SELECT * FROM SYB_LINK.dbBIM.dbo.IEPLDTER  
--	SELECT * FROM ##TercerasPersonas
--	UPDATE ##TercerasPersonas SET vchSexo='', vchEdoCivil='', vchFechaNac='', vchCargo='' 
--	Cambiar SIHCEI_Adm_Consulta por SIHCEI_Adm
--	Cambiar en stp_getInterfazCreditosIndividuales_Universo		SIHCEI_Adm_Consulta por SIHCEI_Adm
--	DELETE FROM SYB_LINK.dbBIM.dbo.IEPLDTER 


--sp_helptext sp_Personas_Relaciones

ALTER PROCEDURE [dbo].[stp_setTercerasPersonas]  
AS  
BEGIN  
  
 DECLARE @fechAct VARCHAR(10) = CONVERT(VARCHAR(10),GETDATE(),103)   
  
 EXEC dbo.stp_getInterfazCreditos_Universo '',@fechAct,''  
  
  
 EXECUTE stp_getInterfazCreditosIndividuales_Universo  
       @sdatFecha_Inicio  = '19000101',  
       @sdatFecha_Fin   = @fechAct,  
       @vchOperacionesId  = ''  
   
   
   
 -- ELIMINA TEMPORAL  
 IF EXISTS(SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME='##TercerasPersonas' AND TYPE='U')  
  DROP TABLE ##TercerasPersonas  
    
    
   
 IF EXISTS(SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME='##tmpRelCreditos' AND TYPE='U')  
  DROP TABLE ##tmpRelCreditos  
      
 --//=======================================================================================  
 --// ESTRUCTURA TABLA DE PASO PARA ALMACENAR LOS DATOS DE LAS TERCERAS PERSONAS  
 --//=======================================================================================  
 CREATE TABLE ##TercerasPersonas  
 (  
  [iPersonaID]  VARCHAR(15)  NULL,  
  [vchNombre]   VARCHAR(120) NULL,  
  [vchApPaterno]  VARCHAR(50)  NULL,  
  [ApMaterno]   VARCHAR(50)  NULL,  
  [vchRFC]   VARCHAR(15)  NULL,  
  [vchCURP]   VARCHAR(20)  NULL,    
  [sintTipoPersonaFM] SMALLINT  NULL,  
  [vchCiudad]   VARCHAR(20)  NULL,  
  [vchDelMun]   VARCHAR(150) NULL,  
  [vchColonia]  VARCHAR(150) NULL,  
  [vchCalle]   VARCHAR(150) NULL,  
  [vchCP]    VARCHAR(6)  NULL,  
  [NoExterior]  VARCHAR(10)  NULL,  
  [NoInt]    VARCHAR(10)  NULL,  
  [Telefono]   NUMERIC  NULL,  
  [ActivEconom]  VARCHAR(5)  NULL,   
  [PaisNacionalidad] VARCHAR(6)  NULL,  
  [PaisResidencia] varchar(6)  NULL,  
  [PaisNacimiento] VARCHAR(6)  NULL,    
 -- [vchEstatus]  VARCHAR(1)  NULL,    
  [vchActivi]   VARCHAR(20)  NULL,
  [vchSexo]   VARCHAR(6)  NULL,
  [vchEdoCivil]  VARCHAR(25) NULL,
  [vchFechaNac]  VARCHAR(10) NULL,
  [vchCargo]  VARCHAR(3) NULL,
  IdPadre VARCHAR(5),
  TipoPersona VARCHAR (2) NULL,
  ReprLegal VARCHAR(1)
 )  
  
  
  CREATE TABLE ##tmpRelCreditos  
  (  
   [intCreditoID]  INT,  
   [iPersonaID]  INT,  
   [TipoPersonaID]  SMALLINT  
  )  
  
--SELECT * FROM dbCatalogosGrales..tbl_CAT_TipoPersonaBIM  
--OBTIENE EL UNIVERSO DE TERCERAS PERSONAS EMPRESARIALES  
 INSERT INTO ##TercerasPersonas  
 (  
  [iPersonaID],   
  [vchNombre],    
  [vchApPaterno],  
  [ApMaterno],    
  [vchRFC],  
  [vchCURP],    
  [sintTipoPersonaFM],  
  [vchCiudad],   
  [vchDelMun],    
  [vchColonia],    
  [vchCalle],    
  [vchCP],       
  [NoExterior],  
  [NoInt],   
  [Telefono],  
  [ActivEconom],    
  [PaisNacionalidad],  
  [PaisResidencia],   
  [PaisNacimiento],   
  --[NumContrato],   
  --[vchEstatus],    
  --[RolContrato],    
  [vchActivi],
  [vchSexo],
  [vchEdoCivil],
  [vchFechaNac],
  [vchCargo],
  IdPadre,
  TipoPersona,
  ReprLegal  
  )  
  SELECT DISTINCT  
	   OP.iParticipeId,  
	   CASE WHEN ISNULL(PER.sPrimerNombre,'') =''  
	  THEN PER.sNombreCompleto  
	  ELSE  
	   ISNULL(PER.sPrimerNombre,'') + ' ' + ISNULL(PER.sSegundoNombre,'')   
	  END        vchNombre,     
	  ISNULL(PER.sApellidoPaterno,'') sApellidoPaterno,  
	  ISNULL(PER.sApellidoMaterno,'') sApellidoMaterno,  
	  RTRIM(LTRIM(UPPER(ISNULL(SUBSTRING(RFC.sCampo1,0,13),''))))  vchRFC,  
	  '' [vchCURP],  
	  PER.iCveRegimenFiscal AS TipoPersona,  
	  '' vchCiudad,  
	  CASE WHEN ISNULL(PerDom.iPersonaId,0) != 0 THEN ISNULL(RIGHT('000'+CAST(PerDom.iEstadoId AS VARCHAR),3),'') ELSE ISNULL(RIGHT('000'+CAST(PerDomRes.iEstadoId AS VARCHAR),3),'') END [vchDelMuni],  
	  CASE WHEN ISNULL(PerDom.iPersonaId,0) != 0 THEN SUBSTRING(UPPER(ISNULL(PerDom.sColonia,'')),1,150) ELSE SUBSTRING(UPPER(ISNULL(PerDomRes.sColonia,'')),1,150) END     [vchColonia],  
	   CASE WHEN ISNULL(PerDom.iPersonaId,0) != 0 THEN SUBSTRING(UPPER(ISNULL(PerDom.sCalle,'')),1,40) ELSE SUBSTRING(UPPER(ISNULL(PerDomRes.sCalle,'')),1,40) END [vchCalle],  
	   '' [vchCP],  
	   dbo.RemoveChars(CASE WHEN ISNULL(PerDom.iPersonaId,0) != 0 THEN SUBSTRING(UPPER(ISNULL(PerDom.sNumExterior,'')),1,10) ELSE SUBSTRING(UPPER(ISNULL(PerDomRes.sNumExterior,'')),1,10) END) [vchNumExt],  
	   '' [NoInt],  
	   0 [Telefono],  
	   '' [ActivEconom],     
	  ISNULL(CatConvPisNaci.Valor,'') AS  [PaisNacionalidad],  
	  '' [PaiResidencia],  
	  ISNULL(CatConvPisNac.Valor,'') AS  [PaisNacimiento]--,   
	  --'' [NumContrato]--,   
	 -- CASE WHEN PER.FInactivo IS NULL THEN 1 ELSE 0 END [vchEstatus],    
	  --OP.iParticipeTipoId [RolContrato],    
	 -- PER.iPersonaId [vchNIC]      
	  ,CAST(LTRIM(RTRIM(ISNULL(CatActiv.chClave,''))) AS VARCHAR)
	  ,''	--ISNULL(siscat.sDescCatalogo,'') Sexo
	  ,''	--ISNULL(siscatEC.sDescCatalogo,'') EdoCivil
	  ,CASE WHEN ISNULL(dFechaNacimiento,'') ='' THEN '' 
			ELSE Convert(varchar(10),CONVERT(date,ISNULL(dFechaNacimiento,''),106),103) END FechaNac
	  ,''
	  ,CR.iPersonaId
	  ,siscatTP.iCatalogoId
	  ,CASE WHEN siscatTP.iCatalogoId=9 THEN 1
			ELSE 0 END ReprLegal	  
	  --,ISNULL(siscatPU.sDescCatalogo,'') Cargo	
  FROM    tmp_CreditosEmpresariales CR     
	INNER JOIN   
		tbl_Operaciones_Participes OP ON CR.iOperacionId = OP.iOperacionId  
	INNER JOIN   
		tbl_Personas PER ON PER.iPersonaId = OP.iParticipeId  
	LEFT JOIN -- Domicilio Fiscal  
		tbl_Personas_Domicilios PerDom WITH(NOLOCK) ON PerDom.iDomicilioId = (SELECT TOP 1 iDomicilioId FROM tbl_Personas_Domicilios T0 WHERE T0.iPersonaId = PER.iPersonaId AND T0.iTipoDomicilioId = 2 /*FISCAL*/ )  
	LEFT JOIN -- Domicilio Residencial  
		tbl_Personas_Domicilios PerDomRes WITH(NOLOCK) ON PerDomRes.iDomicilioId = (SELECT TOP 1 iDomicilioId FROM tbl_Personas_Domicilios T0 WHERE T0.iPersonaId = PER.iPersonaId AND T0.iTipoDomicilioId = 5 /*GARANTIA*/ )   
	LEFT JOIN   -- RFC  
		tbl_Personas_Identificaciones RFC WITH(NOLOCK) ON RFC.iIdentificacionId = (SELECT TOP 1 iIdentificacionId FROM tbl_Personas_Identificaciones id where id.iCveTipoIdentificacion=2 AND ISNULL(id.sCampo1,'')<>''  AND id.iPersonaId=PER.iPersonaId ) -- P.iPersonaId = RFC.iPersonaId AND RFC.iCveTipoIdentificacion = 2  
	LEFT JOIN -- Nacionalidad  
		tbl_Personas_Sibamex PSIB ON PSIB.iPersonaId = OP.iParticipeId  
	LEFT JOIN   
		tbl_sistema_catalogos_Conversion CatConvPisNac WITH(NOLOCK) ON CatConvPisNac.iAgrupaCatId = 60 AND CatConvPisNac.iCatalogoId = PSIB.sintPaisNacionalidad  AND CatConvPisNac.iTConversionId = 4  
	LEFT JOIN   
		tbl_sistema_catalogos_Conversion CatConvPisNaci WITH(NOLOCK) ON CatConvPisNaci.iAgrupaCatId = 60 AND CatConvPisNaci.iCatalogoId = PSIB.sintPaisNacimiento AND CatConvPisNaci.iTConversionId = 4     
	LEFT JOIN   
		tbl_CAT_Actividades CatActiv WITH(NOLOCK) ON CatActiv.sintActividadID = PSib.sintActividadID  
	LEFT JOIN 
		dbo.tbl_sistema_catalogos siscat ON PER.iCveSexo = siscat.iCatalogoId AND siscat.iAgrupaCatId=1
	LEFT JOIN 
		dbo.tbl_sistema_catalogos siscatEC ON PER.iCveEstadoCivil = siscatEC.iCatalogoId AND siscatEC.iAgrupaCatId=2         
		
	INNER JOIN tbl_sistema_catalogos siscatTP ON OP.iParticipeTipoId = siscatTP.iCatalogoId AND siscatTP.iAgrupaCatId=83
		
 WHERE iParticipeTipoId IN (SELECT sintParticipeSihceiEmpID FROM [tbl_REL_ParticipePLD] WHERE sintParticipePldID<>1)  
	AND ISNULL(PER.bitReportado,0) = 0     

  
 --OBTIENE EL UNIVERSO DE TERCERAS PERSONAS INDIVIDUALES  
 INSERT INTO ##TercerasPersonas  
 (  
  [iPersonaID],   
  [vchNombre],    
  [vchApPaterno],  
  [ApMaterno],    
  [vchRFC],  
  [vchCURP],  
  [sintTipoPersonaFM],  
  [vchCiudad],   
  [vchDelMun],    
  [vchColonia],    
  [vchCalle],    
  [vchCP],     
  [NoExterior],  
  [NoInt],  
  [Telefono],  
  [ActivEconom],  
  [PaisNacionalidad],  
  [PaisResidencia],   
  [PaisNacimiento],  
  --[NumContrato],   
  --[vchEstatus],    
  --[RolContrato],    
  [vchActivi],
  [vchSexo],
  [vchEdoCivil],
  [vchFechaNac],
  [vchCargo],
  IdPadre,
  TipoPersona,
  ReprLegal  
  )  
  SELECT DISTINCT   
	   OP.iParticipeId,  
	   CASE WHEN ISNULL(PER.sPrimerNombre,'') =''  
	  THEN PER.sNombreCompleto  
	  ELSE  
	   ISNULL(PER.sPrimerNombre,'') + ' ' + ISNULL(PER.sSegundoNombre,'')   
	  END        vchNombre,     
	  ISNULL(PER.sApellidoPaterno,'') sApellidoPaterno,  
	  ISNULL(PER.sApellidoMaterno,'') sApellidoMaterno,  
	  RTRIM(LTRIM(UPPER(ISNULL(SUBSTRING(RFC.sCampo1,0,13),''))))  vchRFC,  
	  '' [vchCURP],  
	  PER.iCveRegimenFiscal AS TipoPersona,  
	  '' vchCiudad,  
	  CASE WHEN ISNULL(PerDom.iPersonaId,0) != 0 THEN ISNULL(RIGHT('000'+CAST(PerDom.iEstadoId AS VARCHAR),3),'') ELSE ISNULL(RIGHT('000'+CAST(PerDomRes.iEstadoId AS VARCHAR),3),'') END [vchDelMuni],  
	  CASE WHEN ISNULL(PerDom.iPersonaId,0) != 0 THEN SUBSTRING(UPPER(ISNULL(PerDom.sColonia,'')),1,150) ELSE SUBSTRING(UPPER(ISNULL(PerDomRes.sColonia,'')),1,150) END     [vchColonia],  
	   CASE WHEN ISNULL(PerDom.iPersonaId,0) != 0 THEN SUBSTRING(UPPER(ISNULL(PerDom.sCalle,'')),1,40) ELSE SUBSTRING(UPPER(ISNULL(PerDomRes.sCalle,'')),1,40) END [vchCalle],  
	   '' [vchCP],  
	  dbo.RemoveChars(CASE WHEN ISNULL(PerDom.iPersonaId,0) != 0 THEN SUBSTRING(UPPER(ISNULL(PerDom.sNumExterior,'')),1,10) ELSE SUBSTRING(UPPER(ISNULL(PerDomRes.sNumExterior,'')),1,10) END) [vchNumExt],  
	   '' [NoInt],  
	   0 [Telefono],  
	   '' [ActivEconom],  
	  ISNULL(CatConvPisNaci.Valor,'') AS  [PaisNacionalidad],  
	  '' [PaiResidencia],  
	  ISNULL(CatConvPisNac.Valor,'') AS  [PaisNacimiento]--,   
	  --'' [NumContrato],   
	  --CASE WHEN PER.FInactivo IS NULL THEN 1 ELSE 0 END [vchEstatus],    
	  --OP.iParticipeTipoId [RolContrato],    
	  --PER.iPersonaId [vchNIC]  
	  ,CAST(LTRIM(RTRIM(ISNULL(CatActiv.chClave,''))) AS VARCHAR) 
	  --,ISNULL(siscat.sDescCatalogo,'') Sexo      
	  ,CASE WHEN ISNULL(siscat.sDescCatalogo,'') ='' THEN '' 
			WHEN siscat.sDescCatalogo = 'HOMBRE' THEN 'M'
			WHEN siscat.sDescCatalogo = 'MUJER' THEN 'F'
			ELSE '' END Sexo
	  
	  ,ISNULL(siscatEC.sDescCatalogo,'') EdoCivil 
	  ,CASE WHEN ISNULL(dFechaNacimiento,'') ='' THEN '' 
			ELSE Convert(varchar(10),CONVERT(date,ISNULL(dFechaNacimiento,''),106),103) END FechaNac
	  ,'' Cargo
	  ,CR.iPersonaId
	  ,siscatTP.iCatalogoId
	  ,0 ReprLegal		  
  FROM    tmp_CreditosIndividuales CR     
	INNER JOIN   
		SIHCEI_Adm_Consulta..tbl_Operaciones_Participes  OP ON CR.iOperacionId = OP.iOperacionId  
	INNER JOIN   
	   SIHCEI_Adm_Consulta..tbl_Personas PER ON PER.iPersonaId = OP.iParticipeId  
	LEFT JOIN -- Domicilio Fiscal  
	   SIHCEI_Adm_Consulta..tbl_Personas_Domicilios PerDom WITH(NOLOCK) ON PerDom.iDomicilioId = (SELECT TOP 1 iDomicilioId FROM tbl_Personas_Domicilios T0 WHERE T0.iPersonaId = PER.iPersonaId AND T0.iTipoDomicilioId = 2 /*FISCAL*/ )  
	LEFT JOIN -- Domicilio Residencial  
	   SIHCEI_Adm_Consulta..tbl_Personas_Domicilios PerDomRes WITH(NOLOCK) ON PerDomRes.iDomicilioId = (SELECT TOP 1 iDomicilioId FROM tbl_Personas_Domicilios T0 WHERE T0.iPersonaId = PER.iPersonaId AND T0.iTipoDomicilioId = 5 /*GARANTIA*/ )   
	LEFT JOIN   -- RFC  
	   SIHCEI_Adm_Consulta..tbl_Personas_Identificaciones RFC WITH(NOLOCK) ON RFC.iIdentificacionId = (SELECT TOP 1 iIdentificacionId FROM tbl_Personas_Identificaciones id where id.iCveTipoIdentificacion=2 AND ISNULL(id.sCampo1,'')<>''  AND id.iPersonaId=PER.iPersonaId ) -- P.iPersonaId = RFC.iPersonaId AND RFC.iCveTipoIdentificacion = 2  
   
	LEFT JOIN SIHCEI_Adm_Consulta..vw_OperacionesIndv  VW WITH(NOLOCK)  ON OP.iOperacionId = VW.iOperacionIdAdm  
   
	LEFT JOIN -- Nacionalidad  
		tbl_Personas_Sibamex PSIB ON PSIB.iPersonaId = VW.iPersonaIdOri  
	LEFT JOIN   
		tbl_sistema_catalogos_Conversion CatConvPisNac WITH(NOLOCK) ON CatConvPisNac.iAgrupaCatId = 60 AND CatConvPisNac.iCatalogoId = PSIB.sintPaisNacionalidad  AND CatConvPisNac.iTConversionId = 4  
	LEFT JOIN   
		tbl_sistema_catalogos_Conversion CatConvPisNaci WITH(NOLOCK) ON CatConvPisNaci.iAgrupaCatId = 60 AND CatConvPisNaci.iCatalogoId = PSIB.sintPaisNacimiento AND CatConvPisNaci.iTConversionId = 4     
	LEFT JOIN   
		tbl_CAT_Actividades CatActiv WITH(NOLOCK) ON CatActiv.sintActividadID = PSib.sintActividadID  
	LEFT JOIN 
		dbo.tbl_sistema_catalogos siscat ON PER.iCveSexo = siscat.iCatalogoId AND siscat.iAgrupaCatId=1
	LEFT JOIN 
		dbo.tbl_sistema_catalogos siscatEC ON PER.iCveEstadoCivil = siscatEC.iCatalogoId AND siscatEC.iAgrupaCatId=2
	INNER JOIN 
		tbl_sistema_catalogos siscatTP ON OP.iParticipeTipoId = siscatTP.iCatalogoId AND siscatTP.iAgrupaCatId=72
			   
 WHERE iParticipeTipoId in (SELECT sintParticipeSihceiIndID FROM [tbl_REL_ParticipePLD] )  
	AND ISNULL(PER.bitReportado,0) = 0     

 --SELECT * FROM [tbl_REL_ParticipePLD] cat 72  
   
 --INSERTA EN LA TEMPORAL LA CONSULTA INFERIOR  
 INSERT INTO  ##tmpRelCreditos  
  (  
   [intCreditoID],  
   [TipoPersonaID],  
   [iPersonaID]  
     
  )   
 --OBTIENE LA RELACION DE CREDTOS, ROLES, PERSONAS  
 SELECT DISTINCT  
  cr.iOperacionId,  
  REL.sintParticipePldID AS RolContrato,  
  iParticipeId--,  
  --'E' AS [Tipo]  
 --into #tmpCre  
 FROM tmp_CreditosEmpresariales CR   
  INNER JOIN tbl_Operaciones_Participes OP ON  OP.iOperacionId = CR.iOperacionId  
  INNER JOIN tbl_Personas PER ON PER.iPersonaId = OP.iParticipeId  
  LEFT JOIN [tbl_REL_ParticipePLD] REL ON REL.sintParticipeSihceiEmpID = OP.iParticipeTipoId  
 WHERE iParticipeTipoId in ( SELECT sintParticipeSihceiEmpID FROM [tbl_REL_ParticipePLD] ) AND ISNULL(PER.bitReportado,0) = 0  
 GROUP BY REL.sintParticipePldID,  
  iParticipeId,  
  CR.iOperacionId   
 UNION ALL  
 SELECT DISTINCT  
  cr.iOperacionId,  
  REL.sintParticipePldID AS RolContrato,  
  iParticipeId--,  
  --'I' AS [Tipo]   
 FROM tmp_CreditosIndividuales CR   
  INNER JOIN SIHCEI_Adm_Consulta..tbl_Operaciones_Participes OP ON CR.iOperacionId = OP.iOperacionId  
  INNER JOIN SIHCEI_Adm_Consulta..tbl_Personas PER ON PER.iPersonaId = OP.iParticipeId  
  LEFT JOIN [tbl_REL_ParticipePLD] REL ON REL.sintParticipeSihceiIndID = OP.iParticipeTipoId  
 WHERE iParticipeTipoId  IN (SELECT sintParticipeSihceiIndID FROM [tbl_REL_ParticipePLD]) AND ISNULL(PER.bitReportado,0) = 0  
 GROUP BY REL.sintParticipePldID,  
  iParticipeId,  
  CR.iOperacionId  
  
   
   
 --INSERTA EN SIBAMEX LAS PERSONAS, PREVIAMETE ELIMMINA EL REJISTRO SI ES QUE YA EXISTE  
 DELETE SYB_LINK.dbBIM.dbo.IEPLDTER WHERE Ter_PerSih IN (SELECT iPersonaID FROM  ##TercerasPersonas)    
 INSERT INTO SYB_LINK.dbBIM.dbo.IEPLDTER   
 SELECT * FROM  ##TercerasPersonas   
   

   
 --INSERTA LA RELACION DE CREDITOS,PERSONA Y TIPO DE PERSONA QUE NO EXISTA select * from SYB_LINK.dbBIM.dbo.IEPLDTER    
 INSERT INTO SYB_LINK.dbBIM.dbo.IEPLDRET    
 SELECT * FROM  ##tmpRelCreditos t1  
 WHERE NOT EXISTS (  
   SELECT * FROM   
   SYB_LINK.dbBIM.dbo.IEPLDRET  t2  
   WHERE   
   t1.[intCreditoID] = t2.Ret_CreSih AND  
   t1.[iPersonaID] = t2.Ret_PerSih AND  
      t1.[TipoPersonaID] = t2.Ret_Tipo   
  
   )  
  
  
 --ACTUALIZA EL ESTATUS ENVIADO DE LAS TERCERAS PERSONAS  
 UPDATE Tbl_Personas set bitReportado = 1  
 FROM Tbl_Personas p   
 INNER JOIN SYB_LINK.dbBIM.dbo.IEPLDTER  SY ON SY.Ter_PerSih = p.iPersonaId  
  
  
END  


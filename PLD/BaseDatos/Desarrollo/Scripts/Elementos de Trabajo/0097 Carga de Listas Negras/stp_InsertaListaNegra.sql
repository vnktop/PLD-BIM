USE [dbPLD]
GO

/****** Object:  StoredProcedure [dbo].[stp_InsertaListaNegra]    Script Date: 04/24/2013 12:21:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (	SELECT							1
			FROM							SYSOBJECTS
			WHERE							NAME = 'stp_InsertaListaNegra'
			AND								TYPE = 'P' )
	DROP PROCEDURE		stp_InsertaListaNegra
GO
/*=================================================================
		AUTOR:			Gilberto Feria
		DESCRIPCION:	Listado del catálogo de Sitemas para configurar acciones  PLD
		MODIFICACION:
		FECHA DE CREACIÓN: 25-MARZO-2013	
=================================================================*/
CREATE PROCEDURE stp_InsertaListaNegra(@vchidqeq varchar(100)
           ,@vchTipoLista varchar(5)
           ,@vchNombre varchar(1000)
           ,@vchApPaterno varchar(1000)
           ,@vchApMaterno varchar(1000)
           ,@vchCURP varchar(100)
           ,@vchRFC varchar(100)
           ,@vchFechaNac varchar(100)
           ,@vchEstatus varchar(100)
           ,@vchDependencia varchar(120)
           ,@vchPuesto varchar(120)
           ,@intIDdispo varchar(100)
           ,@bitCurpOK varchar(100)
           ,@vchIDRel varchar(120)
           ,@vchParentesco varchar(120)
           ,@vchRazonSocial varchar(256)
           ,@vchRFCMoral varchar(140)
           ,@vchISSSTE varchar(150)
           ,@vchIMSS varchar(150)
           ,@vchIngresos varchar(180)
           ,@vchNomCompleto varchar(3000)
           ,@vchApellidos varchar(200)
           ,@vchEntidad varchar(150)
           ,@vchGenero varchar(100)
           ,@vchAudUsuario varchar(180)
           ,@sdatFechains smalldatetime
           ,@vchCadenaNPM varchar(3000)
           ,@vchCadenaNMP varchar(3000))
AS 
BEGIN
	
INSERT INTO tbl_MST_ListaNegra
           (vchidqeq
           ,vchTipoLista
           ,vchNombre
           ,vchApPaterno
           ,vchApMaterno
           ,vchCURP
           ,vchRFC
           ,vchFechaNac
           ,vchEstatus
           ,vchDependencia
           ,vchPuesto
           ,intIDdispo
           ,bitCurpOK
           ,vchIDRel
           ,vchParentesco
           ,vchRazonSocial
           ,vchRFCMoral
           ,vchISSSTE
           ,vchIMSS
           ,vchIngresos
           ,vchNomCompleto
           ,vchApellidos
           ,vchEntidad
           ,vchGenero
           ,vchAudUsuario
           ,sdatFechains
           ,vchCadenaNPM
           ,vchCadenaNMP)
     VALUES
           (@vchidqeq
           ,@vchTipoLista
           ,@vchNombre
           ,@vchApPaterno
           ,@vchApMaterno
           ,@vchCURP
           ,@vchRFC
           ,@vchFechaNac
           ,@vchEstatus
           ,@vchDependencia
           ,@vchPuesto
           ,@intIDdispo
           ,@bitCurpOK
           ,@vchIDRel
           ,@vchParentesco
           ,@vchRazonSocial
           ,@vchRFCMoral
           ,@vchISSSTE
           ,@vchIMSS
           ,@vchIngresos
           ,@vchNomCompleto
           ,@vchApellidos
           ,@vchEntidad
           ,@vchGenero
           ,@vchAudUsuario
           ,@sdatFechains
           ,@vchCadenaNPM
           ,@vchCadenaNMP)
END



--exec stp_ListarSistemasPLD

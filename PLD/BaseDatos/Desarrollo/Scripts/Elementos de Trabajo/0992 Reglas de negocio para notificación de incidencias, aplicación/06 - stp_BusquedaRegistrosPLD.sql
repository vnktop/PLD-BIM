USE [dbPLD]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (	SELECT							1
			FROM							SYSOBJECTS
			WHERE							NAME = 'stp_BusquedaRegistrosPLD'
			AND								TYPE = 'P' )
	DROP PROCEDURE		stp_BusquedaRegistrosPLD
GO
--exec stp_BusquedaRegistrosPLD null, null
CREATE PROCEDURE [dbo].[stp_BusquedaRegistrosPLD]	
	@vchUsuario           VARCHAR(80),
	@intSistema           INT
AS
BEGIN

	SET NOCOUNT ON

	SELECT	TM_BT.intBitacoraID,
			TD_BT.intIdLN,
			ISNULL(TD_BT.vchUsuario, '') vchUsuario,
			UPPER(
				ISNULL(
					CASE WHEN TD_BT.intSistemaID = 4 OR TD_BT.intSistemaID = 5 
					THEN (SELECT  CAT_USR.vchNombre + ' ' + CAT_USR.vchApPaterno + ' ' + CAT_USR.vchApMaterno   FROM dbSIE..tbl_CAT_Usuarios CAT_USR WHERE TD_BT.vchUsuario = CAT_USR.vchUsuario)
					ELSE 
						(SELECT Usu_Nombre   COLLATE Modern_Spanish_CI_AI FROM LSPLDSIBAMEX.dbBIM.dbo.SOUSUARI WHERE TD_BT.vchUsuario =	Usu_Clave COLLATE Modern_Spanish_CI_AI )
					END, TD_BT.vchUsuario
					)
				)  vchUsuarioNombre,	
			TD_BT.intSistemaID,
			UPPER( 
				CASE WHEN ISNULL(TM_BT.vchPersonaCompleto, '') = '' 
				THEN ISNULL(TM_BT.vchNombre, '') + ' ' + ISNULL(TM_BT.vchApPaterno, '') + ' ' + ISNULL(TM_BT.vchApMaterno, '') 
				ELSE TM_BT.vchPersonaCompleto END) vchPersonaIncidencia,
			TM_BT.vchNombre,
			TM_BT.vchApPaterno,
			TM_BT.vchApMaterno,	   
			TM_BT.vchRelacionCliente,
			UPPER(TD_BT.vchComentario) vchComentario,
			TM_BT.bitAutorizado,
			TM_BT.bitProceso,
			TD_BT.datFecha,
			TM_BT.datFechaAutorizacion,
			TM_BT.bitHomonimo,
			UPPER(TM_BT.vchUsuarioAutoriza) vchUsuarioAutoriza,
			TM_BT.bitEstatus,
			UPPER(CAT_SIST.vchNombre) vchNombreSistema,
			TM_LN.VCHTIPOLISTA vchTipoLista,
			CAT_TT.intTipoTipificacionID,
			CAT_TT.vchDescripcion vchIdentificadorInterno,		
			TM_BT.intVigenciaDias
	FROM   tbl_MST_Bitacora AS TM_BT	
		   LEFT JOIN tbl_DET_Bitacora TD_BT ON 	TM_BT.intBitacoraID = TD_BT.intBitacoraID
		   left JOIN dbSIE..tbl_CAT_Sistemas AS CAT_SIST	ON TD_BT.intSistemaID = CAT_SIST.sintSistemaID
		   left JOIN tbl_MST_ListaNegra		AS TM_LN ON TD_BT.intIdLN = TM_LN.intIdLN
		   left JOIN tbl_CAT_TipoListaNegra CAT_TL ON CAT_TL.VCHTIPOLISTA = TM_LN.VCHTIPOLISTA
		   inner join tbl_CAT_TipoTipificacion CAT_TT ON CAT_TT.intTipoTipificacionID = CAT_TL.intTipoTipificacionID
		   left JOIN dbSIE..tbl_CAT_Usuarios CAT_USR ON TD_BT.vchUsuario = CAT_USR.vchUsuario --and CAT_USR.bitEstatus=1
		 -- 
  WHERE	  ISNULL(TD_BT.intSistemaID, 0) = CASE WHEN ISNULL(@intSistema, 0) = 0   THEN ISNULL(TD_BT.intSistemaID, 0) ELSE @intSistema END AND
          ISNULL(TD_BT.vchUsuario, '') = CASE WHEN ISNULL(@vchUsuario, '') = '' THEN ISNULL(TD_BT.vchUsuario, '') ELSE @vchUsuario END AND

			TM_BT.bitEstatus = 1
	ORDER BY TM_BT.intBitacoraID DESC	
END
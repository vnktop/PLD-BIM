USE [dbPLD]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (	SELECT							1
			FROM							SYSOBJECTS
			WHERE							NAME = 'stp_InsertarDesbloqueoPLD'
			AND								TYPE = 'P' )
	DROP PROCEDURE		stp_InsertarDesbloqueoPLD
GO
--exec stp_InsertarDesbloqueoPLD 0, 1, 1, null, '2013-09-05', 5, 'PRUEBA DE INGRESO ATRIBUTOS DESBLOQUEO DESDE SP'
CREATE PROCEDURE [dbo].[stp_InsertarDesbloqueoPLD]	
	@intResultado			INT OUTPUT,
	@intBitacoraID			INT,
	@bitAutorizado          BIT,
	@bitProceso				BIT,
	@bitHomonimo			BIT,
	@vchUsuarioAutoriza		VARCHAR(50),
	@datFechaAutorizacion	DATE,
	@intVigenciaDias		INT,
	@vchComentario			VARCHAR(100)
AS
BEGIN

	SET NOCOUNT ON
	
	DECLARE		@vchRespuesta	VARCHAR(5)
	DECLARE		@vchDetalle		VARCHAR(256)	

	BEGIN TRANSACTION			trn_InsertarDesbloqueoPLD
		BEGIN TRY
			PRINT 'ACTUALIZACIÓN MAESTRO'		
			UPDATE tbl_MST_Bitacora
				SET													
					bitAutorizado				= @bitAutorizado,
					bitProceso					= @bitProceso,		
					bitHomonimo					= @bitHomonimo,	
					vchUsuarioAutoriza			= @vchUsuarioAutoriza,	
					datFechaAutorizacion		= @datFechaAutorizacion,	
					intVigenciaDias				= @intVigenciaDias												 	          																
				WHERE
					intBitacoraID				= @intBitacoraID
					
			SELECT @intResultado = @@ROWCOUNT
					
			PRINT 'ACTUALIZACIÓN DETALLE'			
			UPDATE tbl_det_bitacora
				SET
					vchComentario				= @vchComentario
				WHERE
					intBitacoraID				= @intBitacoraID
					
		COMMIT TRANSACTION		trn_InsertarDesbloqueoPLD
					PRINT 'SE EJECUTA COMMIT'
					SET			@vchRespuesta = 'OK'
					SET			@vchDetalle = @intResultado
				END TRY
				BEGIN CATCH
					ROLLBACK TRANSACTION	trn_InsertarDesbloqueoPLD
					PRINT 'SE EJECUTA ROLLBACK'
					SET			@vchRespuesta = 'NOK'
					SET			@vchDetalle = ERROR_MESSAGE()
				END CATCH	
				
		SELECT @intResultado						
END
GO
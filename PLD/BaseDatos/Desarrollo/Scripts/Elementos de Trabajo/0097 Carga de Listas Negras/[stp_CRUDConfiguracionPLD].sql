USE [dbPLD]
GO

/****** Object:  StoredProcedure [dbo].[stp_CRUDConfiguracionPLD]    Script Date: 04/22/2013 10:03:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (	SELECT							1
			FROM							SYSOBJECTS
			WHERE							NAME = 'stp_CRUDConfiguracionPLD'
			AND								TYPE = 'P' )
	DROP PROCEDURE		stp_CRUDConfiguracionPLD
GO

CREATE PROCEDURE [dbo].[stp_CRUDConfiguracionPLD]
	@intResultado					AS INT OUTPUT,
	@intAccion						AS INT,

	@intTipoTipificacionID			AS INT,
	@sintSistemaID					AS INT,
	@bitBloqueoUsuario				AS BIT,
	@bitBloqueoProceso				AS BIT,
	@bitEnvioCorreo					AS BIT,
	@bitBitacora					AS BIT,
	@vchMensaje						AS VARCHAR(100),
	@vchCorreosPara					AS VARCHAR(256),
	@vchCorreosCC					AS VARCHAR(256)

AS
BEGIN
	IF @intAccion = 1							/*[c] - SQL Ingresar*/
		BEGIN
			BEGIN TRANSACTION					ingresar_ConfiguracionPLD
			BEGIN TRY				
				INSERT INTO tbl_REL_AccionPLDListaNegra
				(
					intTipoTipificacionID,	sintSistemaID,		bitBloqueoUsuario,		bitBloqueoProceso,	bitEnvioCorreo,		bitBitacora,
					vchMensaje,				vchCorreosPara,		vchCorreosCC
				)
				VALUES
				(
					@intTipoTipificacionID,	@sintSistemaID,		@bitBloqueoUsuario,		@bitBloqueoProceso,	@bitEnvioCorreo,	@bitBitacora,
					@vchMensaje,			@vchCorreosPara,	@vchCorreosCC
				)				  
				SET			@intResultado = COUNT(*)
				COMMIT TRANSACTION				ingresar_ConfiguracionPLD				
			END TRY
			BEGIN CATCH
				ROLLBACK TRANSACTION			ingresar_ConfiguracionPLD
				SET			@intResultado = -1			
			END CATCH		
		END

	IF @intAccion = 2							/*[R] - SQL Leer busqueda*/
		BEGIN			
			SELECT 	TBM.intTipoTipificacionID,	TTT.vchDescripcion AS vchIdentificadorInterno,				TBM.sintSistemaID,		TBS.vchNombre as vchNombreSistema,		
					CASE WHEN bitBloqueoUsuario = 1 THEN 'SI' ELSE 'NO' END AS vchbitBloqueoUsuario,		bitBloqueoUsuario,	
					CASE WHEN bitBloqueoProceso = 1 THEN 'SI' ELSE 'NO' END AS vchbitBloqueProceso,			bitBloqueoProceso,	
					CASE WHEN bitEnvioCorreo = 1	THEN 'SI' ELSE 'NO' END AS vchbitEnvioCorreo,			bitEnvioCorreo,
					CASE WHEN bitBitacora = 1		THEN 'SI' ELSE 'NO' END AS vchbitBitacora,				bitBitacora,
					vchMensaje,			vchCorreosPara,			vchCorreosCC
			FROM    tbl_REL_AccionPLDListaNegra		as TBM	LEFT OUTER JOIN
					dbSIE.dbo.tbl_CAT_Sistemas		as TBS	ON	TBM.sintSistemaID = TBS.sintSistemaID LEFT OUTER JOIN
					tbl_CAT_TipoTipificacion		as TTT	ON	TBM.intTipoTipificacionID = TTT.intTipoTipificacionID
			WHERE   (TBM.intTipoTipificacionID =	ISNULL(@intTipoTipificacionID, TBM.intTipoTipificacionID))		AND 
					(TBM.sintSistemaID =			ISNULL(@sintSistemaID, TBM.sintSistemaID))		AND
					(TBM.BITESTATUS = 1)
			ORDER BY vchNombreSistema ASC, intTipoTipificacionID DESC
			
		END						
	
	IF @intAccion = 3							/*[U] - SQL Actualizar*/
		BEGIN
			BEGIN TRANSACTION			actualizar_ConfiguracionPLD
			BEGIN TRY				
				UPDATE	tbl_REL_AccionPLDListaNegra 
				SET		bitBloqueoUsuario =			@bitBloqueoUsuario,
						bitEnvioCorreo =			@bitEnvioCorreo,
						bitBloqueoProceso =			@bitBloqueoProceso,
						bitBitacora	=				@bitBitacora,
						vchMensaje =				@vchMensaje,
						vchCorreosPara =			@vchCorreosPara,
						vchCorreosCC =				@vchCorreosCC
				WHERE	(intTipoTipificacionID =	@intTipoTipificacionID)	AND
						(sintSistemaID =			@sintSistemaID)	AND
						(BITESTATUS = 1)
				SET		@intResultado =				@@ROWCOUNT
				COMMIT TRANSACTION		actualizar_ConfiguracionPLD
			END TRY
			BEGIN CATCH
				ROLLBACK TRANSACTION	actualizar_ConfiguracionPLD
				SET		@intResultado =				-1			
			END CATCH		
		END

	IF @intAccion = 4							/*[D] - SQL Eliminar*/
		BEGIN
			BEGIN TRANSACTION			eliminar_ConfiguracionPLD
			BEGIN TRY				
				DELETE FROM  tbl_REL_AccionPLDListaNegra				
				WHERE	(intTipoTipificacionID =	@intTipoTipificacionID)	AND
						(sintSistemaID =			@sintSistemaID)	
				SET		@intResultado =		@@ROWCOUNT
				COMMIT TRANSACTION		eliminar_ConfiguracionPLD				
			END TRY
			BEGIN CATCH
				ROLLBACK TRANSACTION	eliminar_ConfiguracionPLD
				SET		@intResultado =		-1			
			END CATCH		
		END	
	SELECT @intResultado
	RETURN @intResultado
END
GO
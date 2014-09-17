
USE [dbPLD]
GO

/****** Object:  StoredProcedure [dbo].[stp_CRUDConfiguracionPLD]    Script Date: 04/22/2013 10:03:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (	SELECT							1
			FROM							SYSOBJECTS
			WHERE							NAME = 'stp_CRUDTipoListaNegra'
			AND								TYPE = 'P' )
	DROP PROCEDURE		stp_CRUDTipoListaNegra
GO
CREATE PROCEDURE [dbo].[stp_CRUDTipoListaNegra]	
	@intResultado			INT OUTPUT,
	@intAccion				INT,

	@intTipoListaID			INT,
	@vchTipoLista			VARCHAR(5),
	@intTipoTipificacionID	INT,
	@VCDDESCRIPCION			VARCHAR(256),
	@vchPais				VARCHAR(50)

AS
BEGIN
	IF @intAccion = 1							/*[c] - SQL Ingresar*/
		BEGIN
			BEGIN TRANSACTION					ingresar_TipoListaNegra
			BEGIN TRY			
				INSERT INTO tbl_CAT_TipoListaNegra
				(
					vchTipoLista,				intTipoTipificacionID,				VCDDESCRIPCION,			vchPais
				)
				VALUES
				(
					@vchTipoLista,				@intTipoTipificacionID,				@VCDDESCRIPCION,		@vchPais
				)				  
				SET			@intResultado = IDENT_CURRENT('tbl_CAT_TipoListaNegra')
				COMMIT TRANSACTION				ingresar_TipoListaNegra				
			END TRY
			BEGIN CATCH
				ROLLBACK TRANSACTION			ingresar_TipoListaNegra
				SET			@intResultado = -1			
			END CATCH		
		END

	IF @intAccion = 2							/*[R] - SQL Leer busqueda*/
		BEGIN			
			SELECT 	intTipoListaID,		vchTipoLista,				C_TLN.intTipoTipificacionID,		C_TT.vchDescripcion AS  vchTipoTipificacion,	VCDDESCRIPCION,	vchPais
			FROM    tbl_CAT_TipoListaNegra			AS C_TLN	LEFT OUTER JOIN
					tbl_CAT_TipoTipificacion		as C_TT	ON	C_TT.intTipoTipificacionID = C_TLN.intTipoTipificacionID 
			WHERE   (C_TLN.vchTipoLista =			ISNULL(@vchTipoLista, vchTipoLista))								AND
					(C_TLN.intTipoTipificacionID =	ISNULL(@intTipoTipificacionID, C_TLN.intTipoTipificacionID))		AND
					(C_TLN.BITESTATUS = 1)
			ORDER BY vchTipoTipificacion DESC			
		END			

	IF @intAccion = 3							/*[U] - SQL Actualizar*/
		BEGIN
			BEGIN TRANSACTION			actualizar_TipoListaNegra
			BEGIN TRY				
				UPDATE	tbl_CAT_TipoListaNegra 
				SET		vchTipoLista =				@vchTipoLista,
						intTipoTipificacionID =		@intTipoTipificacionID,
						VCDDESCRIPCION =			@VCDDESCRIPCION,
						vchPais	=					@vchPais						
				WHERE	(intTipoListaID =			@intTipoListaID)	AND
						(BITESTATUS = 1)
				SET		@intResultado =				@@ROWCOUNT
				COMMIT TRANSACTION		actualizar_TipoListaNegra
			END TRY
			BEGIN CATCH
				ROLLBACK TRANSACTION	actualizar_TipoListaNegra
				SET		@intResultado =				-1			
			END CATCH		
		END

	IF @intAccion = 4							/*[D] - SQL Eliminar*/
		BEGIN
			BEGIN TRANSACTION			eliminar_TipoListaNegra
			BEGIN TRY				
				UPDATE	tbl_CAT_TipoListaNegra 
				SET		BITESTATUS =				0
				WHERE	(intTipoListaID =	@intTipoListaID)	AND
						(BITESTATUS = 1)
				SET		@intResultado =				@@ROWCOUNT			
				COMMIT TRANSACTION		eliminar_TipoListaNegra				
			END TRY
			BEGIN CATCH
				ROLLBACK TRANSACTION	eliminar_TipoListaNegra
				SET		@intResultado =		-1			
			END CATCH		
		END	

	IF @intAccion = 5							/*[R] - SQL Leer existencia de registro, previo actualización*/
		BEGIN			
			SELECT	@intResultado = COUNT(*)
			FROM    tbl_CAT_TipoListaNegra	AS C_TLN		
			WHERE   (C_TLN.vchTipoLista =			@vchTipoLista)				AND
					(C_TLN.intTipoTipificacionID =	@intTipoTipificacionID)		AND
					(C_TLN.BITESTATUS = 1)					
		END	

	IF @intAccion = 6							/*[c] - SQL Ingresar*/
		BEGIN
			BEGIN TRANSACTION					ingresar_TipoTipificacion
			BEGIN TRY			
				INSERT INTO tbl_CAT_TipoTipificacion
				(
					vchDescripcion
				)
				VALUES
				(
					@VCDDESCRIPCION
				)				  
				SET			@intResultado = IDENT_CURRENT('tbl_CAT_TipoTipificacion')
				COMMIT TRANSACTION				ingresar_TipoTipificacion				
			END TRY
			BEGIN CATCH
				ROLLBACK TRANSACTION			ingresar_TipoTipificacion
				SET			@intResultado = -1			
			END CATCH		
		END

	IF @intAccion = 7							/*[U] - SQL Actualizar*/
		BEGIN
			BEGIN TRANSACTION			actualizar_TipoTipificacion
			BEGIN TRY				
				UPDATE	tbl_CAT_TipoTipificacion 
				SET		vchDescripcion =			@VCDDESCRIPCION				
				WHERE	(intTipoTipificacionID =	@intTipoTipificacionID)	
				SET		@intResultado =				@@ROWCOUNT
				COMMIT TRANSACTION		actualizar_TipoTipificacion
			END TRY
			BEGIN CATCH
				ROLLBACK TRANSACTION	actualizar_TipoTipificacion
				SET		@intResultado =				-1			
			END CATCH		
		END

	IF @intAccion = 8							/*[R] - SQL Leer existencia de registro, previo actualización*/
		BEGIN			
			SELECT	@intResultado = COUNT(*)
			FROM    tbl_CAT_TipoTipificacion	AS C_TT		
			WHERE   (C_TT.vchDescripcion =			@VCDDESCRIPCION)		
		END	

	SELECT @intResultado
	RETURN @intResultado
END

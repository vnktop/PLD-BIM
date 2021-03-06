
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('stp_CRUDConfiguracionPLD') )
BEGIN 
 DROP PROCEDURE stp_CRUDConfiguracionPLD
END 
GO
CREATE PROCEDURE stp_CRUDConfiguracionPLD
	@intResultado					AS INT OUTPUT,
	@intAccion						AS INT,

	@vchIdentificadorInterno		AS VARCHAR(5),
	@sintSistemaID					AS INT,
	@bitBloqueoUsuario				AS BIT,
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
					vchIdentificadorInterno,			sintSistemaID,		bitBloqueoUsuario,		bitEnvioCorreo,		bitBitacora,
					vchMensaje,				vchCorreosPara,		vchCorreosCC
				)
				VALUES
				(
					@vchIdentificadorInterno,			@sintSistemaID,		@bitBloqueoUsuario,		@bitEnvioCorreo,	@bitBitacora,
					@vchMensaje,				@vchCorreosPara,		@vchCorreosCC
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
			SELECT 	vchIdentificadorInterno,			TBM.sintSistemaID,		TBS.vchNombre as vchNombreSistema,		
					CASE WHEN bitBloqueoUsuario = 1 THEN 'SI' ELSE 'NO' END AS vchbitBloqueoUsuario,		bitBloqueoUsuario,		
					CASE WHEN bitEnvioCorreo = 1	THEN 'SI' ELSE 'NO' END AS vchbitEnvioCorreo,			bitEnvioCorreo,
					CASE WHEN bitBitacora = 1		THEN 'SI' ELSE 'NO' END AS vchbitBitacora,				bitBitacora,
					vchMensaje,			vchCorreosPara,			vchCorreosCC
			FROM    tbl_REL_AccionPLDListaNegra		as TBM	LEFT OUTER JOIN
					dbSIE.dbo.tbl_CAT_Sistemas		as TBS	ON	TBM.sintSistemaID = TBS.sintSistemaID						
			WHERE   (vchIdentificadorInterno =		ISNULL(@vchIdentificadorInterno, vchIdentificadorInterno))		AND 
					(TBM.sintSistemaID =	ISNULL(@sintSistemaID, TBM.sintSistemaID))		AND
					(TBM.BITESTATUS = 1)
			ORDER BY vchNombreSistema ASC, vchIdentificadorInterno DESC
			
		END						
	
	IF @intAccion = 3							/*[U] - SQL Actualizar*/
		BEGIN
			BEGIN TRANSACTION			actualizar_ConfiguracionPLD
			BEGIN TRY				
				UPDATE	tbl_REL_AccionPLDListaNegra 
				SET		bitBloqueoUsuario =			@bitBloqueoUsuario,
						bitEnvioCorreo =			@bitEnvioCorreo,
						bitBitacora	=				@bitBitacora,
						vchMensaje =				@vchMensaje,
						vchCorreosPara =			@vchCorreosPara,
						vchCorreosCC =				@vchCorreosCC
				WHERE	(vchIdentificadorInterno =	@vchIdentificadorInterno)	AND
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
				WHERE	(vchIdentificadorInterno =	@vchIdentificadorInterno)	AND
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

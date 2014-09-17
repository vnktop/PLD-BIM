USE [dbPLD]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (	SELECT							1
			FROM							SYSOBJECTS
			WHERE							NAME = 'stp_InsertarMST_DET_Bitacora'
			AND								TYPE = 'P' )
	DROP PROCEDURE		stp_InsertarMST_DET_Bitacora
GO
--exec stp_InsertarMST_DET_Bitacora 0,'ANDRES MANUEL LOPEZ OBRADOR', NULL, NULL, NULL, '3', '5696781', 2, '06/09/2013 0:00:00', 'victor.pineda', 14, 'primer registro de prueba del SP'
CREATE PROCEDURE [dbo].[stp_InsertarMST_DET_Bitacora]	
	@intResultado					INT OUTPUT,
	@vchPersonaCompleto				VARCHAR(500),
	@vchNombre						VARCHAR(100),
	@vchApPaterno					VARCHAR(100),
	@vchApMaterno					VARCHAR(100),
	@vchRelacionCliente				VARCHAR(100),
	@intIdLN						INT,
	@intTipoTipificacionID			INT,
	@datFecha						DATE,
	@vchUsuario						VARCHAR(50),
	@intSistemaID					INT,
	@vchComentario					VARCHAR(100)
AS
BEGIN

	SET NOCOUNT ON
	
	DECLARE		@vchRespuesta	VARCHAR(5)
	DECLARE		@vchDetalle		VARCHAR(256)	
	
	-- El parámetro mandatorio es el nombre completo, por lo tanto siempre debe existir
	IF (ISNULL(@vchPersonaCompleto, '') = '')
	BEGIN
		SET @vchPersonaCompleto = @vchNombre + ' ' + @vchApPaterno + ' ' + @vchApMaterno
	END	
		-- Se evita ingresar registros dúplicados, se simula el ingreso
		IF EXISTS(	SELECT 1 FROM tbl_MST_Bitacora 
		WHERE	
			ISNULL(vchPersonaCompleto, '')	= ISNULL(@vchPersonaCompleto, '')	AND				
			bitEstatus = 1
		)
		BEGIN
			-- El front espera 0 para simular el ingreso de bitácora y el envío de correo
			PRINT 'EXISTE REGISTO, SE SIMULA INGRESO'
			SET		@intResultado =	0
		END	
		ELSE
			BEGIN		
				BEGIN TRANSACTION			trn_InsertarMST_DET_Bitacora
					BEGIN TRY
					--Los sistemas 14 y 15 devuelven ID, para homologar se escribe descripción, como lo hacen los sistemas 4 y 5
					IF (@intSistemaID = 14 OR @intSistemaID = 15)
					BEGIN --SELECT * FROM tbl_CAT_RelacionCliente
						DECLARE @vchRelacionCli VARCHAR(100)
						SELECT @vchRelacionCli = ISNULL(vchDescripcion, '') FROM tbl_CAT_RelacionCliente WHERE intRelacionClienteID = @vchRelacionCliente AND bitEstatus = 1
						SET @vchRelacionCliente = @vchRelacionCli
					END
					PRINT 'VALOR RELACIÓN: ' + @vchRelacionCliente

					-- Se ingresa el maestro de bitácora
					PRINT 'INGRESA MAESTRO'
					INSERT INTO tbl_MST_Bitacora
						(vchPersonaCompleto,
						 vchNombre,			
						 vchApPaterno,		
						 vchApMaterno,		
						 vchRelacionCliente)
					VALUES
						(ISNULL(@vchPersonaCompleto, @vchNombre + ' ' + @vchApPaterno + ' ' + @vchApMaterno) ,
						@vchNombre,			
						@vchApPaterno,		
						@vchApMaterno,		
						@vchRelacionCliente)

					-- Se obtiene el ID del maestro para asignarlo en el detalle
					SELECT @intResultado = IDENT_CURRENT('tbl_MST_Bitacora')
					PRINT 'ID MAESTRO :' + CAST(@intResultado AS VARCHAR(10))

					PRINT 'INGRESA DETALLE'
					INSERT INTO tbl_DET_Bitacora
						(intBitacoraID,
						intIdLN,				
						intTipoTipificacionID,	
						datFecha,				
						vchUsuario,				
						intSistemaID,			
						vchComentario)
					VALUES
						(@intResultado,
						@intIdLN,				
						@intTipoTipificacionID,	
						ISNULL(@datFecha, GETDATE()),				
						@vchUsuario,				
						@intSistemaID,			
						@vchComentario)			
						
				-- El registro de lista negra se inhabilita para la bitácora
				UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @intIdLN
						
				COMMIT TRANSACTION		trn_InsertarMST_DET_Bitacora
					PRINT 'SE EJECUTA COMMIT'
					SET			@vchRespuesta = 'OK'
					SET			@vchDetalle = @intResultado
				END TRY
				BEGIN CATCH
					ROLLBACK TRANSACTION	trn_InsertarMST_DET_Bitacora
					PRINT 'SE EJECUTA ROLLBACK'
					SET			@vchRespuesta = 'NOK'
					SET			@vchDetalle = ERROR_MESSAGE()
				END CATCH
			END
	--SELECT			@vchRespuesta	AS	'Result',
	--				@vchDetalle		AS	'Details'
	--SELECT @intResultado AS RegistroInsert						
	
END
GO
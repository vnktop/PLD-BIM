USE [dbPLD]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (	SELECT							1
			FROM							SYSOBJECTS
			WHERE							NAME = 'stp_ReglaNegocioRegistrosBitacora'
			AND								TYPE = 'P' )
	DROP PROCEDURE		stp_ReglaNegocioRegistrosBitacora
GO
--exec stp_ReglaNegocioRegistrosBitacora 0, 'ENRIQUE PEÑA NIETO'
CREATE PROCEDURE [dbo].[stp_ReglaNegocioRegistrosBitacora]	
	@intResultado							INT OUTPUT,
	@vchNombrePersonaCompleto				VARCHAR(500)	
AS
BEGIN

IF EXISTS(	SELECT 1 FROM tbl_MST_Bitacora 
			WHERE	
				ISNULL(vchPersonaCompleto, '')	= ISNULL(@vchNombrePersonaCompleto, '')	AND
				ISNULL(bitAutorizado, 0)		= 1										AND				
				-- Si la fecha asignada es mayor a la fecha de hoy, entonces el registro esta dentro del periodo de autorización
				CONVERT(VARCHAR, DATEADD(DAY, ISNULL(intVigenciaDias, 0), ISNULL(datFechaAutorizacion, '')), 112) >= CONVERT(VARCHAR, GETDATE(), 112) AND
				-- Solo se ocnsideran registros activos, los registros en false estan asociados a la bitácora
				bitEstatus = 1
		  )
	BEGIN
		SET		@intResultado =	1
	END
ELSE
	BEGIN
		-- Registro por nombre que es cancelado al ser vencidas las reglas y obliga a generar uno nuevo con las listas actualizadas en ese momento
		IF EXISTS(	SELECT 1 FROM tbl_MST_Bitacora 
			WHERE	
				ISNULL(bitAutorizado, 0) = 1 AND 
				ISNULL(intVigenciaDias, 0) > 0 AND 
				ISNULL(datFechaAutorizacion, '') != '' AND 
				ISNULL(vchPersonaCompleto, '') != '' AND
				bitEstatus = 1
				)
			BEGIN
				UPDATE tbl_MST_Bitacora SET bitEstatus = 0 WHERE	vchPersonaCompleto = @vchNombrePersonaCompleto	AND	
																	ISNULL(bitAutorizado, 0) = 1 AND 
																	ISNULL(intVigenciaDias, 0) > 0 AND 
																	ISNULL(datFechaAutorizacion, '') != '' AND 																	
																	bitEstatus = 1
			END			
		SET		@intResultado =	0
	END		
--RETURN @intResultado		
SELECT @intResultado
END
GO

--declare @fecha date 
--declare @result int
--set @fecha = '2013-07-18'
--set @fecha = dateadd(day, ISNULL(12, 0), ISNULL(@fecha, ''))
--if (CONVERT(VARCHAR, ISNULL(@fecha, ''), 112) > CONVERT(VARCHAR, GETDATE(), 112))
--	begin
--		set @result = 0	
--	end
--else
--	begin
--	-- Si la fecha asignada es mayor a la fecha de hoy, entonces el registro esta dentro del periodo de autorización
--		set @result = 1
--	end
--print @fecha  
--print @result


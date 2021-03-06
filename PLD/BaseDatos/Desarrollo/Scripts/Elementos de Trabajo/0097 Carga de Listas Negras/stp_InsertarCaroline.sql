
GO
/****** Object:  StoredProcedure [dbo].[stp_InsertarCaroline]    Script Date: 05/23/2013 20:39:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (	SELECT							1
			FROM							SYSOBJECTS
			WHERE							NAME = 'stp_InsertarCaroline'
			AND								TYPE = 'P' )
	DROP PROCEDURE		stp_InsertarCaroline
GO

-- =============================================
-- Author:		Haydeé Monroy
-- Create date: 11-Abril-2013
-- Description:	Inserta registros en la tabla
-- tbl_MST_WSCaroline
-- =============================================
CREATE PROCEDURE [dbo].[stp_InsertarCaroline]
	
	@intWSCarolineID		int output,
	@intTipoTipificacionID  int,
	@intClienteID			int,
	@intPersonaID           int,
	@intCalificacion		int
	
AS

BEGIN
	
INSERT INTO tbl_MST_WSCaroline
           (intTipoTipificacionID
           ,intClienteID
           ,intPersonaID
           ,intCalificacion
           ,datFecha)
     VALUES
           (@intTipoTipificacionID
           ,@intClienteID
           ,@intPersonaID
           ,@intCalificacion
           ,getdate())


			
	
	
	SELECT @intWSCarolineID = @@IDENTITY 
	
END


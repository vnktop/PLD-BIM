USE dbPLD
GO

IF (OBJECT_ID('stp_ListarProveedores')) IS NOT NULL	
	DROP PROCEDURE stp_ListarProveedores

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===================================================
-- Author:		Lázaro Adrián González Montoya
-- Create date: 19/07/2013
-- Description:	Lista los proveedores de Listas Negras
-- ===================================================
CREATE PROCEDURE stp_ListarProveedores 
AS
BEGIN
	SELECT iProveedorId,
		   vchDescripcion
	  FROM tbl_CAT_Proveedores
	 WHERE bEstatus = 1
END
GO

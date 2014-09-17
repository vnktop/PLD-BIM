USE dbPLD
GO

IF (OBJECT_ID('stp_InsertaProveedor')) IS NOT NULL	
	DROP PROCEDURE stp_InsertaProveedor

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		L�zaro Adri�n Gonz�lez Montoya
-- Create date: 19/07/2013
-- Description:	Permite insertar un proveedor
-- =============================================
CREATE PROCEDURE stp_InsertaProveedor 
	@vchProveedor VARCHAR(100)
AS
BEGIN
	IF @vchProveedor IS NOT NULL
	BEGIN
		IF (SELECT iProveedorId FROM tbl_CAT_Proveedores WHERE vchDescripcion like '%'+@vchProveedor+'%') IS NULL
		BEGIN 
			INSERT INTO tbl_CAT_Proveedores
			(vchDescripcion,bEstatus)
			VALUES(@vchProveedor,1)
		END
	END
END
GO
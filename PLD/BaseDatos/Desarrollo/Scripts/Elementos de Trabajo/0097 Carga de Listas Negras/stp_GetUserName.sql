IF OBJECT_ID('stp_GetUserName') IS NOT NULL
	DROP PROCEDURE 	stp_GetUserName
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO	
-- =============================================
-- Author:		LAZARO ADRIAN GONZALEZ MONTOYA
-- Create date: 13/06/2013
-- Description:	Obtiene el nombre completo del usuario a partir de su login
-- =============================================
CREATE PROCEDURE stp_GetUserName 
	@vchUsuario VARCHAR(50) = NULL,
	@vchNombreCompleto VARCHAR(100) = NULL OUTPUT
AS
BEGIN
	DECLARE @vchNombre		varchar(100)
	DECLARE @vchApPaterno	varchar(100)
	DECLARE @vchApMaterno	varchar(100)

	SET @vchNombre =	(
							SELECT vchNombre
							  FROM dbSIE..tbl_CAT_Usuarios
							 WHERE vchUsuario = @vchUsuario
					    )
	SET @vchApPaterno = (
							SELECT vchApPaterno
							  FROM dbSIE..tbl_CAT_Usuarios
							 WHERE vchUsuario = @vchUsuario
						) 			 
	SET @vchApMaterno = (
							SELECT vchApMaterno
							  FROM dbSIE..tbl_CAT_Usuarios
							 WHERE vchUsuario = @vchUsuario
						)				

	SET @vchNombreCompleto = UPPER(@vchNombre + ' ' + @vchApPaterno + ' ' + @vchApMaterno)
	SELECT @vchNombreCompleto AS vchNombreCompleto
END

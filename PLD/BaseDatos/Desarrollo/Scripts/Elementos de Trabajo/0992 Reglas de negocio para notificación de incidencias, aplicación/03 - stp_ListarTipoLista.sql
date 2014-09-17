USE dbPLD
GO

IF (OBJECT_ID('[stp_ListarTipoLista]')) IS NOT NULL	
	DROP PROCEDURE [stp_ListarTipoLista]
	
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[stp_ListarTipoLista]    
AS     
BEGIN
-- select * from dbo.tbl_CAT_TipoGarantia
SELECT DISTINCT UPPER(vchTipoLista) vchTipoLista FROM tbl_cat_tipolistanegra WHERE bitestatus = 1
END  
go
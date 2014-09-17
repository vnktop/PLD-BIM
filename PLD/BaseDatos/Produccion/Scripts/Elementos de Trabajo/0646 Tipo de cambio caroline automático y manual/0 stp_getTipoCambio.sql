USE dbPLD
GO

IF (OBJECT_ID('stp_getTipoCambio')) IS NOT NULL	
	DROP PROCEDURE stp_getTipoCambio
	
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ====================================================
-- Author:		LAGM
-- Create date: 31072013
-- Description:	Obitene una lista de los tipo de cambio
-- ====================================================
CREATE PROCEDURE stp_getTipoCambio 
AS
BEGIN
	SELECT CM.vchDescripcionCMO,
			   CG.vchDescripcionCGE,
			   TC.decValorCTC,
			   TC.datFchDeCierreCTC
		  FROM lsPrinPLD.dbCaroline.dbo.tbl_CAT_TipoCambio TC
	INNER JOIN lsPrinPLD.dbCaroline.dbo.tbl_CAT_Generales CG
			ON CG.intCatalogoIdCGE = TC.intCambioIdCGE
	INNER JOIN lsPrinPLD.dbCaroline.dbo.tbl_CAT_Moneda CM
			ON CM.intMonedaIdCMO = TC.intMonedaIdCMO
	  ORDER BY datFchDeCierreCTC desc
END
GO

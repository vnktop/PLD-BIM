USE dbPLD
GO

IF (OBJECT_ID('stp_InsertaTipoCambioManual')) IS NOT NULL	
	DROP PROCEDURE stp_InsertaTipoCambioManual
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =====================================================================
-- Author:		LAGM
-- Create date: 01/08/2013
-- Description:	Permite insertar registros de tipo de cambio en Caroline
-- =====================================================================
CREATE PROCEDURE stp_InsertaTipoCambioManual 
	-- Add the parameters for the stored procedure here
	@FechaCierre DATE, 
	@decValor DECIMAL(15,2)	
AS
BEGIN
		INSERT INTO lsPrinPLD.dbCaroline.dbo.tbl_CAT_TipoCambio
		(intMonedaIdCMO, intCambioIdCGE, decValorCTC, datFchDeCierreCTC,vchUserCapturaCTC,datFchCapturaCTC,bitEstatusCTC)
		VALUES
		(2,15,@decValor,@FechaCierre,'SYSTEM',GETDATE(),1),
		(2,16,@decValor,@FechaCierre,'SYSTEM',GETDATE(),1)	
END
GO

--EXEC stp_InsertaTipoCambioManual '20130901',21.3

USE[dbSIE]
GO

DECLARE		@intObjetoPadreId	INT,
			@sintSistemaID		SMALLINT
			
			
SELECT		@sintSistemaID = sintSistemaID
FROM		tbl_CAT_Sistemas
WHERE		vchNombre LIKE 'PLD'


DECLARE
	@pOpcion int,
	@pPermisoID int,
	@pObjeto varchar(50),
	@pNombreObjeto varchar(100),
	@pPagina varchar(100),
	@pObjetoPadre int,
	@pNumObjetos int,
	@pTipoObjeto smallint,
	@pOrden smallint,
	@pOpcionPermiso varchar(100),
	@pSistemaID smallint,
	@pEstatus bit,
	@pUsuarioID int,
	@pIP varchar(15),
	@pResultado int

------------------------------------------------------------------------------------------------------------------
SET		@intObjetoPadreId	=  0
--------------------------------------------
-- Pagina Padre Generador Regulatorio
--------------------------------------------
SET	@pOpcion = 1
SET	@pPermisoID = NULL
SET	@pObjeto = 'Tipo de Cambio'
SET	@pNombreObjeto = '#'
SET	@pPagina = '/PLD/frmInicio.aspx'
SET	@pObjetoPadre = @intObjetoPadreId
SET	@pNumObjetos = 0
SET	@pTipoObjeto = 1
SET	@pOrden = NULL
SET	@pOpcionPermiso = NULL
SET	@pSistemaID = @sintSistemaID
SET	@pEstatus = 1
SET	@pUsuarioID = 389
SET	@pIP = ''
SET	@pResultado = 0

EXECUTE stpOperacionesPermisos
--SELECT
								@pOpcion,
								@pPermisoID,
								@pObjeto,
								@pNombreObjeto,
								@pPagina,
								@pObjetoPadre,
								@pNumObjetos,
								@pTipoObjeto,
								@pOrden,
								@pOpcionPermiso,
								@pSistemaID,
								@pEstatus,
								@pUsuarioID,
								@pIP,
								@pResultado OUTPUT

SELECT @pResultado

--------------------------------------------
-- Pagina Hijo Carga Automática
--------------------------------------------
SET @intObjetoPadreId = IDENT_CURRENT('tbl_CAT_Permisos')
SET	@pOpcion = 1
SET	@pPermisoID = NULL
SET	@pObjeto = 'Carga Automática'
SET	@pNombreObjeto = '#'
SET	@pPagina = '/PLD/TipoCambio/frmTCAutomatico.aspx'
SET	@pObjetoPadre = @intObjetoPadreId
SET	@pNumObjetos = 0
SET	@pTipoObjeto = 1
SET	@pOrden = NULL
SET	@pOpcionPermiso = NULL
SET	@pSistemaID = @sintSistemaID
SET	@pEstatus = 1
SET	@pUsuarioID = 389
SET	@pIP = ''
SET	@pResultado = 0

EXECUTE stpOperacionesPermisos
--SELECT
								@pOpcion,
								@pPermisoID,
								@pObjeto,
								@pNombreObjeto,
								@pPagina,
								@pObjetoPadre,
								@pNumObjetos,
								@pTipoObjeto,
								@pOrden,
								@pOpcionPermiso,
								@pSistemaID,
								@pEstatus,
								@pUsuarioID,
								@pIP,
								@pResultado OUTPUT

SELECT @pResultado

--------------------------------------------
-- Pagina Hijo Carga Manual
--------------------------------------------
SET	@pOpcion = 1
SET	@pPermisoID = NULL
SET	@pObjeto = 'Carga Manual'
SET	@pNombreObjeto = '#'
SET	@pPagina = '/PLD/TipoCambio/frmTCManual.aspx'
SET	@pObjetoPadre = @intObjetoPadreId
SET	@pNumObjetos = 0
SET	@pTipoObjeto = 1
SET	@pOrden = NULL
SET	@pOpcionPermiso = NULL
SET	@pSistemaID = @sintSistemaID
SET	@pEstatus = 1
SET	@pUsuarioID = 389
SET	@pIP = ''
SET	@pResultado = 0

EXECUTE stpOperacionesPermisos
--SELECT
								@pOpcion,
								@pPermisoID,
								@pObjeto,
								@pNombreObjeto,
								@pPagina,
								@pObjetoPadre,
								@pNumObjetos,
								@pTipoObjeto,
								@pOrden,
								@pOpcionPermiso,
								@pSistemaID,
								@pEstatus,
								@pUsuarioID,
								@pIP,
								@pResultado OUTPUT

SELECT @pResultado

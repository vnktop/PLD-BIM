USE[dbSIE]
GO

DECLARE			@intObjetoPadreID		INT
DECLARE			@sintSistemaID			INT
/*
-- Damos de alta al módulo en el catalogo de sistemas
IF NOT EXISTS (	SELECT						1
				FROM						dbSIE..tbl_CAT_Sistemas
				WHERE						vchNombre = 'PLD' )
	BEGIN
		INSERT INTO	dbSIE..tbl_CAT_Sistemas
				(	vchNombre,
					vchDescripcion,
					bitEstatus,
					AUDUSUARIO,
					vchURL,
					vchIP)
		VALUES	(
					'PLD',
					'Modulo de PLD',
					1,
					'wilbert.gomez',
					'/PLD/frmLogin.aspx',
					'/PLD/frmLogin.aspx')

		-- Obtenemos el ID del sistema insertado			
		SET		@sintSistemaID = IDENT_CURRENT('dbSIE..tbl_CAT_Sistemas')
	END

-- Procedimiento para dar de alta un nuevo objeto
	-- valor pOpcion = 1 [INSERTAR]
	--			@pIP
	--			@pUsuarioID		[Son datos de usuario que inserta los datos]
*/
SELECT * FROM dbSIE..tbl_CAT_Sistemas

SET		@sintSistemaID		= 12		--IDENT_CURRENT('dbSIE..tbl_CAT_Sistemas')

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
SET	@pObjeto = 'Lista Restringida'
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

----------------------------------------------
--	-- Hijo: Carga
----------------------------------------------

--SET		@intObjetoPadreID = IDENT_CURRENT('dbSIE..tbl_CAT_Permisos')

--SET	@pOpcion = 1
--SET	@pPermisoID = NULL
--SET	@pObjeto = 'Carga'
--SET	@pNombreObjeto = '#'
--SET	@pPagina = '/PLD/frmInicio.aspx'
--SET	@pObjetoPadre = @intObjetoPadreId
--SET	@pNumObjetos = 0
--SET	@pTipoObjeto = 1
--SET	@pOrden = NULL
--SET	@pOpcionPermiso = NULL
--SET	@pSistemaID = @sintSistemaID
--SET	@pEstatus = 1
--SET	@pUsuarioID = 389
--SET	@pIP = ''
--SET	@pResultado = 0

--EXECUTE stpOperacionesPermisos
----SELECT
--								@pOpcion,
--								@pPermisoID,
--								@pObjeto,
--								@pNombreObjeto,
--								@pPagina,
--								@pObjetoPadre,
--								@pNumObjetos,
--								@pTipoObjeto,
--								@pOrden,
--								@pOpcionPermiso,
--								@pSistemaID,
--								@pEstatus,
--								@pUsuarioID,
--								@pIP,
--								@pResultado OUTPUT

--SELECT @pResultado
--------------------------------------------
	-- Hijo: Carga
--------------------------------------------

SET		@intObjetoPadreID = IDENT_CURRENT('dbSIE..tbl_CAT_Permisos')

SET	@pOpcion = 1
SET	@pPermisoID = NULL
SET	@pObjeto = 'Carga de Lista'
SET	@pNombreObjeto = '#'
SET	@pPagina = '/PLD/ListasNegra/frmListaNegra.aspx'
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
------------------------------------------------------------------------------------------------------------------
SET		@intObjetoPadreId	=  0
--------------------------------------------
-- Pagina Padre Configurador
--------------------------------------------
SET	@pOpcion = 1
SET	@pPermisoID = NULL
SET	@pObjeto = 'Configurador'
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
	-- Hijo: Acciones
--------------------------------------------

SET		@intObjetoPadreID = IDENT_CURRENT('dbSIE..tbl_CAT_Permisos')

SET	@pOpcion = 1
SET	@pPermisoID = NULL
SET	@pObjeto = 'Acciones'
SET	@pNombreObjeto = '#'
SET	@pPagina = '/PLD/Configurador/frmAcciones.aspx'
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
------------------------------------------------------------------------------------------------------------------
SET		@intObjetoPadreId	=  0
--------------------------------------------
-- Pagina Padre Verificador PLD
--------------------------------------------
SET	@pOpcion = 1
SET	@pPermisoID = NULL
SET	@pObjeto = 'Verificador PLD'
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
	-- Hijo: Servicio
--------------------------------------------

SET		@intObjetoPadreID = IDENT_CURRENT('dbSIE..tbl_CAT_Permisos')

SET	@pOpcion = 1
SET	@pPermisoID = NULL
SET	@pObjeto = 'Servicio'
SET	@pNombreObjeto = '#'
SET	@pPagina = '/PLD/VerificadorPLD/VerificadorPLD.aspx'
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
------------------------------------------------------------------------------------------------------------------
SET		@intObjetoPadreId	=  0
--------------------------------------------
-- Pagina Padre Control
--------------------------------------------
SET	@pOpcion = 1
SET	@pPermisoID = NULL
SET	@pObjeto = 'Control'
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
	-- Hijo: Acciones
--------------------------------------------

SET		@intObjetoPadreID = IDENT_CURRENT('dbSIE..tbl_CAT_Permisos')

SET	@pOpcion = 1
SET	@pPermisoID = NULL
SET	@pObjeto = 'Acciones'
SET	@pNombreObjeto = '#'
SET	@pPagina = '/PLD/DesbloqueoUsuarios/wfrDesbloqueoUsuario.aspx'
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
-- Padre: Mantenimiento
--------------------------------------------

SET		@intObjetoPadreID = 0

SET	@pOpcion = 1
SET	@pPermisoID = NULL
SET	@pObjeto = 'Matenimiento'
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
	-- Hijo: Tipo Lista Negra
--------------------------------------------

SET		@intObjetoPadreID = IDENT_CURRENT('dbSIE..tbl_CAT_Permisos')

SET	@pOpcion = 1
SET	@pPermisoID = NULL
SET	@pObjeto = 'Tipo Lista Negra'
SET	@pNombreObjeto = '#'
SET	@pPagina = '/PLD/Mantenimiento/frmMntoTipoListaNegra.aspx'
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

--	Este procedimiento almacena en la tabla dbSIE..tbl_CAT_Permisos
-- Utilizando catalogos tbl_CAT_Objetos y tbl_CAT_TiposObjeto

DECLARE
	@pPermisoRolId int,				--	No es necesario para el alta, se utiliza para el borrado de un permiso
	@pRolSistemaID int,				--	Id de la consulta anterior
	@pRolId int
-- Ahora, damos permiso al perfil, lo primero es obtener el id del rol
SET
	@pRolId  = 1					-- Rol como Administrador

----Insertamos un rol relacionado al nuevo sistema

	---- Rol Administrador
----SELECT * FROM dbSIE..tbl_REL_RolSistema
	
INSERT INTO	dbSIE..tbl_REL_RolSistema
	(sintRolID, sintSistemaID, bitEstatus, AUDUSUARIO)
VALUES
	(@pRolId, @pSistemaId, 1, 'wilbert.gomez')

-- Y con esto se da de alta un permiso y se asocia a un rol.
SELECT * FROM dbSIE..tbl_CAT_Permisos

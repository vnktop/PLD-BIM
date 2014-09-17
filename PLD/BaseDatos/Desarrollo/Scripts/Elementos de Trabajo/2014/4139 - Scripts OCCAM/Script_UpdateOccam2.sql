--      CORRER CON ODBC SIBAMEXDESA 172.30.28.49\Desarrollo
--	dbBIM


	UPDATE Cat 
	SET Cat.sintNumEmpleado = Nom.codigoempleado 
	FROM dbSie.dbo.tbl_CAT_Usuarios AS Cat
	INNER JOIN LSPLD_NOM.ctBANCO_INMOBILI2.dbo.nom10001 Nom 
	ON Cat.vchApPaterno=Nom.apellidopaterno AND Cat.vchApMaterno=Nom.apellidomaterno
	AND codigoempleado NOT IN (346,347,131,649,300)

	UPDATE Cat 
	SET Cat.sintNumEmpleado = Nom.codigoempleado 
	FROM dbSie.dbo.tbl_CAT_Usuarios AS Cat
	INNER JOIN LSPLD_NOM.ctBANCO_INMOBILI2.dbo.nom10001 Nom 
	ON Cat.vchApPaterno=Nom.apellidopaterno AND Cat.vchApMaterno=Nom.apellidomaterno AND Cat.vchNombre=Nom.nombre
	AND codigoempleado IN (346,347,300)

	UPDATE Cat 
	SET Cat.sintNumEmpleado = Nom.codigoempleado 
	FROM dbSie.dbo.tbl_CAT_Usuarios AS Cat 
	INNER JOIN LSPLD_NOM.ctBANCO_INMOBILI2.dbo.nom10001 Nom 
	ON Cat.vchApPaterno=Nom.apellidopaterno AND Cat.vchApMaterno=Nom.apellidomaterno
	AND codigoempleado IN (131)
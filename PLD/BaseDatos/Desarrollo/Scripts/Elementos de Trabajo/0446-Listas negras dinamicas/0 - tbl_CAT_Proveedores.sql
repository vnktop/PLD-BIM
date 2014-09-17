CREATE TABLE tbl_CAT_Proveedores
(
	iProveedorId INT NOT NULL Identity(1,1),
	vchDescripcion VARCHAR(100),
	bEstatus BIT,
	PRIMARY KEY (iProveedorId)	
)

ALTER TABLE tbl_MST_ListaNegra 
		ADD iProveedorId INT 
FOREIGN KEY 
 REFERENCES tbl_CAT_Proveedores (iProveedorId)
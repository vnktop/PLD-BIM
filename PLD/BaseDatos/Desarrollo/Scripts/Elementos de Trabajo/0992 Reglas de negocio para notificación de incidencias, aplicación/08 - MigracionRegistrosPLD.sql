----------------------------------------------------------------------------------
--- EN ESTE PUNTO CARGAR LISTAS NEGRAS NUEVAMENTE, PARA IMPACTAR NUEVA ESTRUCTURA
----------------------------------------------------------------------------------

begin tran
if object_id('dbo.tmp1') is not null
begin
  drop table dbo.tmp1
end
  
  
CREATE TABLE tmp1 (intIdLN INT, VCHTIPOLISTA VARCHAR(100), intTipoTipificacionID INT, vchIdentificadorInterno VARCHAR(100), VCHNOMCOMPLETO VARCHAR(100))
GO
--- alfredo arce arizmendi
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra '','','','alfredo arce arizmendi'
DECLARE @IDLN1 INT
SET @IDLN1 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID1 INT
SET @TTID1 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- alina gutierrez diaz
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra '','','','alina gutierrez diaz'
DECLARE @IDLN2 INT
SET @IDLN2 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID2 INT
SET @TTID2 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
---- ANTONIO RODRIGUEZ VAZQUEZ
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra '','','','ANTONIO RODRIGUEZ VAZQUEZ'
DECLARE @IDLN3 INT
SET @IDLN3 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID3 INT
SET @TTID3 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
---- CANDELARIA DEL ROCIO GORDILLO GORDILLO
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra '','','','CANDELARIA DEL ROCIO GORDILLO GORDILLO'
DECLARE @IDLN4 INT
SET @IDLN4 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID4 INT
SET @TTID4 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- claudia torres gonzalez
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra '','','','claudia torres gonzalez'
DECLARE @IDLN5 INT
SET @IDLN5 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID5 INT
SET @TTID5 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- CRUZ . SANCHEZ
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra '','','','CRUZ . SANCHEZ'
DECLARE @IDLN6 INT
SET @IDLN6 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID6 INT
SET @TTID6 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- DAVID ALFARO GARCES
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra '','','','DAVID ALFARO GARCES'
DECLARE @IDLN7 INT
SET @IDLN7 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID7 INT
SET @TTID7 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- DAVID HERNANDEZ PEREZ
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra '','','','DAVID HERNANDEZ PEREZ'
DECLARE @IDLN8 INT
SET @IDLN8 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID8 INT
SET @TTID8 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- DIEGO VILCHIS MEDRANO
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra '','','','DIEGO VILCHIS MEDRANO'
DECLARE @IDLN9 INT
SET @IDLN9 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID9 INT
SET @TTID9 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- EDGAR HERNANDEZ LOPEZ
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra '','','','EDGAR HERNANDEZ LOPEZ'
DECLARE @IDLN10 INT
SET @IDLN10 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID10 INT
SET @TTID10 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- EDUARDO RAMIREZ LOPEZ
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra '','','','EDUARDO RAMIREZ LOPEZ'
DECLARE @IDLN11 INT
SET @IDLN11 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID11 INT
SET @TTID11 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- ELOY VARGAS ARREOLA
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra '','','','ELOY VARGAS ARREOLA'
DECLARE @IDLN12 INT
SET @IDLN12 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID12 INT
SET @TTID12 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- FLAVIO TORRES RAMIREZ
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra '','','','FLAVIO TORRES RAMIREZ'
DECLARE @IDLN13 INT
SET @IDLN13 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID13 INT
SET @TTID13 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- HECTOR GOMEZ MARTINEZ
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra '','','','HECTOR GOMEZ MARTINEZ'
DECLARE @IDLN14 INT
SET @IDLN14 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID14 INT
SET @TTID14 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- HELADIO LUNA
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra '','','','HELADIO LUNA'
DECLARE @IDLN15 INT
SET @IDLN15 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID15 INT
SET @TTID15 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- JORGE  FLORES MARTINEZ
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra '','','','JORGE  FLORES MARTINEZ'
DECLARE @IDLN16 INT
SET @IDLN16 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID16 INT
SET @TTID16 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- JORGE HUERTA GONZALEZ
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra '','','','JORGE HUERTA GONZALEZ'
DECLARE @IDLN17 INT
SET @IDLN17 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID17 INT
SET @TTID17 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- jorge luis gonzalez curi
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra '','','','jorge luis gonzalez curi'
DECLARE @IDLN18 INT
SET @IDLN18 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID18 INT
SET @TTID18 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- JOSE LUIS ROSALES RODRIGUEZ
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra '','','','JOSE LUIS ROSALES RODRIGUEZ'
DECLARE @IDLN19 INT
SET @IDLN19 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID19 INT
SET @TTID19 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- JUAN FRANCISCO BERMUDEZ ROJAS
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra '','','','JUAN FRANCISCO BERMUDEZ ROJAS'
DECLARE @IDLN20 INT
SET @IDLN20 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID20 INT
SET @TTID20 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- JUAN REYES GONZALEZ
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra '','','','JUAN REYES GONZALEZ'
DECLARE @IDLN21 INT
SET @IDLN21 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID21 INT
SET @TTID21 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- LUIS ALFONSO NAVA CALVILLO
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra '','','','LUIS ALFONSO NAVA CALVILLO'
DECLARE @IDLN22 INT
SET @IDLN22 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID22 INT
SET @TTID22 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- MANUEL ANGEL NUÑEZ SOTO
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra '','','','MANUEL ANGEL NUÑEZ SOTO'
DECLARE @IDLN23 INT
SET @IDLN23 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID23 INT
SET @TTID23 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- MARIA GUADALUPE GONZALEZ RIVERA'
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra '','','','MARIA GUADALUPE GONZALEZ RIVERA'
DECLARE @IDLN24 INT
SET @IDLN24 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID24 INT
SET @TTID24 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- paul davis carstens
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra '','','','paul davis carstens'
DECLARE @IDLN25 INT
SET @IDLN25 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID25 INT
SET @TTID25 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- PEDRO HERNANDEZ SANCHEZ
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra '','','','PEDRO HERNANDEZ SANCHEZ'
DECLARE @IDLN26 INT
SET @IDLN26 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID26 INT
SET @TTID26 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- rodolfo martinez lopez
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra '','','','rodolfo martinez lopez'
DECLARE @IDLN27 INT
SET @IDLN27 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID27 INT
SET @TTID27 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- rodolfo martinez lopez
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra '','','','Victor Álvarez'
DECLARE @IDLN28 INT
SET @IDLN28 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID28 INT
SET @TTID28 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- 'JUANLUIS','RODRIGUEZ','LOPEZ'
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra 'JUANLUIS','RODRIGUEZ','LOPEZ',''
DECLARE @IDLN29 INT
SET @IDLN29 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID29 INT
SET @TTID29 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- 'GUADALUPE','MARTINEZ','MARTINEZ'
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra 'GUADALUPE','MARTINEZ','MARTINEZ',''
DECLARE @IDLN30 INT
SET @IDLN30 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID30 INT
SET @TTID30 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- 'JOEL','DIAZ','TORRES'
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra 'JOEL','DIAZ','TORRES',''
DECLARE @IDLN31 INT
SET @IDLN31 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID31 INT
SET @TTID31 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- 'ANTONIO','GARCIA','TORRES'
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra 'ANTONIO','GARCIA','TORRES',''
DECLARE @IDLN32 INT
SET @IDLN32 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID32 INT
SET @TTID32 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- 'ELOY','HERNANDEZ','GARCIA'
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra 'ELOY','HERNANDEZ','GARCIA',''
DECLARE @IDLN33 INT
SET @IDLN33 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID33 INT
SET @TTID33 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- 'GUSTAVO','GARCIA','GONZALEZ'
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra 'GUSTAVO','GARCIA','GONZALEZ',''
DECLARE @IDLN34 INT
SET @IDLN34 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID34 INT
SET @TTID34 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- 'JULIOCESAR','X','SOTO'
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra 'JULIOCESAR','X','SOTO',''
DECLARE @IDLN35 INT
SET @IDLN35 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID35 INT
SET @TTID35 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1
--- 'ROSAMARIA','X','HERNANDEZ'
INSERT INTO tmp1 
EXEC stp_BuscarListaNegra 'ROSAMARIA','X','HERNANDEZ',''
DECLARE @IDLN36 INT
SET @IDLN36 = (SELECT TOP 1 intIdLN FROM tmp1)
DECLARE @TTID36 INT
SET @TTID36 = (SELECT TOP 1 intTipoTipificacionID FROM tmp1)
DELETE FROM tmp1



PRINT @IDLN1
PRINT @TTID1
PRINT @IDLN2
PRINT @TTID2
PRINT @IDLN3
PRINT @TTID3
PRINT @IDLN4
PRINT @TTID4
PRINT @IDLN5
PRINT @TTID5
PRINT @IDLN6
PRINT @TTID6
PRINT @IDLN7
PRINT @TTID7
PRINT @IDLN8
PRINT @TTID8
PRINT @IDLN9
PRINT @TTID9
PRINT @IDLN10
PRINT @TTID10
PRINT @IDLN11
PRINT @TTID11
PRINT @IDLN12
PRINT @TTID12
PRINT @IDLN13
PRINT @TTID13
PRINT @IDLN14
PRINT @TTID14
PRINT @IDLN15
PRINT @TTID15
PRINT @IDLN16
PRINT @TTID16
PRINT @IDLN17
PRINT @TTID17
PRINT @IDLN18
PRINT @TTID18
PRINT @IDLN19
PRINT @TTID19
PRINT @IDLN20
PRINT @TTID20
PRINT @IDLN21
PRINT @TTID21
PRINT @IDLN22
PRINT @TTID22
PRINT @IDLN23
PRINT @TTID23
PRINT @IDLN24
PRINT @TTID24
PRINT @IDLN25
PRINT @TTID25
PRINT @IDLN26
PRINT @TTID26
PRINT @IDLN27
PRINT @TTID27
PRINT @IDLN28
PRINT @TTID28
PRINT @IDLN29
PRINT @TTID29
PRINT @IDLN30
PRINT @TTID30
PRINT @IDLN31
PRINT @TTID31
PRINT @IDLN32
PRINT @TTID32
PRINT @IDLN33
PRINT @TTID33
PRINT @IDLN34
PRINT @TTID34
PRINT @IDLN35
PRINT @TTID35
PRINT @IDLN36
PRINT @TTID36

--- alfredo arce arizmendi
--INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('ALFREDO ARCE ARIZMENDI','','','','AVALES',1,0,'Eduardo.Ramirez','20130919')
--DECLARE @BID1 INT
--SET @BID1 = IDENT_CURRENT('tbl_MST_Bitacora')
--INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID1,@TTID1,@IDLN1,'20130918','MARIA.ORTEGA',5,'NO ES PEP ES MIEMBRO DE LA ASAMBLEA GRAL DEL INFONAVIT COMO REPRESENTANTE PATRONAL')
--UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN1

--- alina gutierrez diaz
INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('ALINA GUTIERREZ DIAZ','','','','PRINCIPALES FUNCIONARIOS',1,1,'Eduardo.Ramirez','20131004')	
DECLARE @BID2 INT
SET @BID2 = IDENT_CURRENT('tbl_MST_Bitacora')
INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID2,@TTID2,@IDLN2,'20131003','CAROLINA.GARRIDO',5,'HOMONIMO')
UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN2

---- ANTONIO RODRIGUEZ VAZQUEZ
INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('ANTONIO RODRIGUEZ VAZQUEZ','','','','AVALES',1,1,'Eduardo.Ramirez','20130912')	
DECLARE @BID3 INT
SET @BID3 = IDENT_CURRENT('tbl_MST_Bitacora')
INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID3,@TTID3,@IDLN3,'20130912','erika.yanez',5,'HOMONIMO')
UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN3

---- CANDELARIA DEL ROCIO GORDILLO GORDILLO
INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('CANDELARIA DEL ROCIO GORDILLO GORDILLO','','','','PRINCIPALES FUNCIONARIOS',1,0,'Eduardo.Ramirez','20130912')	
DECLARE @BID4 INT
SET @BID4 = IDENT_CURRENT('tbl_MST_Bitacora')
INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID4,@TTID4,@IDLN4,'20130912','EDGAR.GARCIA',5,'PEP EN PROCESO DE DOCUMENTACION')
UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN4

--- claudia torres gonzalez
INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('CLAUDIA TORRES GONZALEZ','','','','ACCIONISTAS',1,1,'Eduardo.Ramirez','20131004')	
DECLARE @BID5 INT
SET @BID5 = IDENT_CURRENT('tbl_MST_Bitacora')
INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID5,@TTID5,@IDLN5,'20130925','FATIMA.JUAREZ',5,'HOMONIMO')
UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN5

--- CRUZ . SANCHEZ
INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('CRUZ . SANCHEZ','','','','CONYUGE',1,1,'Eduardo.Ramirez','20130828')	
DECLARE @BID6 INT
SET @BID6 = IDENT_CURRENT('tbl_MST_Bitacora')
INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID6,@TTID6,@IDLN6,'20130827','PAMELA.GUERRERO',4,'HOMONIMO')
UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN6

--- DAVID ALFARO GARCES
--INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('DAVID ALFARO GARCES','','','','AVALES',1,1,'Eduardo.Ramirez','20130930')	
--DECLARE @BID7 INT
--SET @BID7 = IDENT_CURRENT('tbl_MST_Bitacora')
--INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID7,@TTID7,@IDLN7,'20130930','VICTOR.ESPINOSA',5,'homonimo')
--UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN7

--- DAVID HERNANDEZ PEREZ
INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('DAVID HERNANDEZ PEREZ','','','','AVALES',1,1,'Eduardo.Ramirez','20130718')	
DECLARE @BID8 INT
SET @BID8 = IDENT_CURRENT('tbl_MST_Bitacora')
INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID8,@TTID8,@IDLN8,'20130718','carlos.arevalo',5,'homonimo')
UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN8

--- DIEGO VILCHIS MEDRANO
INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('DIEGO VILCHIS MEDRANO','','','','REPRESENTANTE LEGAL',1,1,'Eduardo.Ramirez','20131004')	
DECLARE @BID9 INT
SET @BID9 = IDENT_CURRENT('tbl_MST_Bitacora')
INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID9,@TTID9,@IDLN9,'20130926','ISMAEL.LUEVANO',5,'HOMONIMO')
UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN9

--- EDGAR HERNANDEZ LOPEZ
INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('EDGAR HERNANDEZ LOPEZ','','','','APODERADOS HCM',1,1,'Eduardo.Ramirez','20130909')	
DECLARE @BID10 INT
SET @BID10 = IDENT_CURRENT('tbl_MST_Bitacora')
INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID10,@TTID10,@IDLN10,'20130830','gabriela.limon',5,'HOMONIMO')
UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN10

--- EDUARDO RAMIREZ LOPEZ
INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('EDUARDO RAMIREZ LOPEZ','','','','ACCIONISTAS',1,1,'Eduardo.Ramirez','20130909')	
DECLARE @BID11 INT
SET @BID11 = IDENT_CURRENT('tbl_MST_Bitacora')
INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID11,@TTID11,@IDLN11,'20130830','IRMA.SALINAS',5,'Homonimo')
UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN11

--- ELOY VARGAS ARREOLA
--INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('ELOY VARGAS ARREOLA','','','','DEUDOR SOLIDARIO',1,0,'Eduardo.Ramirez','20130909')	
--DECLARE @BID12 INT
--SET @BID12 = IDENT_CURRENT('tbl_MST_Bitacora')
--INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID12,@TTID12,@IDLN12,'20130902','JORGE.ALCALA',5,'PEP. FALTA QUE ENVIEN EL CUESTIONARIO ORIGINAL')
--UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN12

--- FLAVIO TORRES RAMIREZ
INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('FLAVIO TORRES RAMIREZ','','','','AVALES',1,1,'Eduardo.Ramirez','20130917')	
DECLARE @BID13 INT
SET @BID13 = IDENT_CURRENT('tbl_MST_Bitacora')
INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID13,@TTID13,@IDLN13,'20130917','FATIMA.JUAREZ',5,'HOMONIMO DE FLAVIO ERNESTO GALARZA TORRES')
UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN13

--- HECTOR GOMEZ MARTINEZ
INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('HECTOR GOMEZ MARTINEZ','','','','AVALES',1,1,'Eduardo.Ramirez','20130919')	
DECLARE @BID14 INT
SET @BID14 = IDENT_CURRENT('tbl_MST_Bitacora')
INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID14,@TTID14,@IDLN14,'20130919','pammela.romero',5,'hOMONIMO. HAY 16 HECTOR GOMEZ PERO NINGUNO DE SEGUNDO APELLIDO MARTINEZ')
UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN14

--- HELADIO LUNA
--INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('HELADIO LUNA','','','','CLIENTE',1,1,'Eduardo.Ramirez','20130923')	
--DECLARE @BID15 INT
--SET @BID15 = IDENT_CURRENT('tbl_MST_Bitacora')
--INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID15,@TTID15,@IDLN15,'20130920','ROGELIO.HEREDIA',4,'HOMONIMO DE REGIDOR EN ZACATECAS VENCIDO')
--UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN15

--- JORGE  FLORES MARTINEZ
--INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('JORGE  FLORES MARTINEZ','','','','CLIENTE',1,1,'Eduardo.Ramirez','20130917')	
--DECLARE @BID16 INT
--SET @BID16 = IDENT_CURRENT('tbl_MST_Bitacora')
--INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID16,@TTID16,@IDLN16,'20130917','federico.romero',4,'PEP vencido de Jorge Carlos Flores Martínez')
--UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN16

--- JORGE HUERTA GONZALEZ
--INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('JORGE HUERTA GONZALEZ','','','','CLIENTE',1,1,'Eduardo.Ramirez','20131004')	
--DECLARE @BID17 INT
--SET @BID17 = IDENT_CURRENT('tbl_MST_Bitacora')
--INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID17,@TTID17,@IDLN17,'20131002','PAMELA.GUERRERO',4,'HOMONIMO')
--UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN17

--- jorge luis gonzalez curi
INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('JORGE LUIS GONZALEZ CURI','','','','AVALES',1,0,'Eduardo.Ramirez','20130919')	
DECLARE @BID18 INT
SET @BID18 = IDENT_CURRENT('tbl_MST_Bitacora')
INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID18,@TTID18,@IDLN18,'20130918','ROGELIO.HEREDIA',5,'PEP DOCUMENTADO')
UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN18

--- JOSE LUIS ROSALES RODRIGUEZ
INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('JOSE LUIS ROSALES RODRIGUEZ','','','','CLIENTE',1,1,'Eduardo.Ramirez','20130917')	
DECLARE @BID19 INT
SET @BID19 = IDENT_CURRENT('tbl_MST_Bitacora')
INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID19,@TTID19,@IDLN19,'20130913','AMANDA.GARCIA',4,'Homonimo de funcionario de Pemex')
UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN19

--- JUAN FRANCISCO BERMUDEZ ROJAS
INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('JUAN FRANCISCO BERMUDEZ ROJAS','','','','APODERADOS',1,0,'Eduardo.Ramirez','20131004')	
DECLARE @BID20 INT
SET @BID20 = IDENT_CURRENT('tbl_MST_Bitacora')
INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID20,@TTID20,@IDLN20,'20130924','FATIMA.JUAREZ',5,'PEP DOCUMENTADO')
UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN20

--- JUAN REYES GONZALEZ
INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('JUAN REYES GONZALEZ','','','','ACCIONISTAS',1,1,'Eduardo.Ramirez','20131004')	
DECLARE @BID21 INT
SET @BID21 = IDENT_CURRENT('tbl_MST_Bitacora')
INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID21,@TTID21,@IDLN21,'20130924','ALEJANDRO.TAPIA',5,'HOMONIMO')
UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN21

--- LUIS ALFONSO NAVA CALVILLO
INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('LUIS ALFONSO NAVA CALVILLO','','','','ACCIONISTAS',1,0,'Eduardo.Ramirez','20130913')	
DECLARE @BID22 INT
SET @BID22 = IDENT_CURRENT('tbl_MST_Bitacora')
INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID22,@TTID22,@IDLN22,'20130912','VICTOR.ESPINOSA',5,'PEP DOCUMENTADO')
UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN22

--- MANUEL ANGEL NUÑEZ SOTO
--INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('MANUEL ANGEL NUÑEZ SOTO','','','','AVALES',1,0,'Eduardo.Ramirez','20130813')	
--DECLARE @BID23 INT
--SET @BID23 = IDENT_CURRENT('tbl_MST_Bitacora')
--INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID23,@TTID23,@IDLN23,'20130812','Mauricio.Mendoza',5,'Es un PEP vencido')
--UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN23

--- MARIA GUADALUPE GONZALEZ RIVERA'
INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('MARIA GUADALUPE GONZALEZ RIVERA','','','','CLIENTE',1,0,'Eduardo.Ramirez','20130923')	
DECLARE @BID24 INT
SET @BID24 = IDENT_CURRENT('tbl_MST_Bitacora')
INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID24,@TTID24,@IDLN24,'20130920','ROGELIO.HEREDIA',4,'VISTO ANTES')
UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN24

--- paul davis carstens
INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('PAUL DAVIS CARSTENS','','','','REPRESENTANTE LEGAL PARA AVAL',1,0,'Eduardo.Ramirez','20131004')	
DECLARE @BID25 INT
SET @BID25 = IDENT_CURRENT('tbl_MST_Bitacora')
INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID25,@TTID25,@IDLN25,'20131001','gustavo.luna',5,'PRIMO DE PEP')
UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN25

--- PEDRO HERNANDEZ SANCHEZ
INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('PEDRO HERNANDEZ SANCHEZ','','','','CLIENTE',1,1,'Eduardo.Ramirez','20130923')	
DECLARE @BID26 INT
SET @BID26 = IDENT_CURRENT('tbl_MST_Bitacora')
INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID26,@TTID26,@IDLN26,'20130920','ROGELIO.HEREDIA',4,'HOMONIMO DE FUNCIONARIO INACTIVO DE LA CNA  ')
UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN26

--- rodolfo martinez lopez
INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('RODOLFO MARTINEZ LOPEZ','','','','COACREDITADO',1,1,'Eduardo.Ramirez','20130917')	
DECLARE @BID27 INT
SET @BID27 = IDENT_CURRENT('tbl_MST_Bitacora')
INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID27,@TTID27,@IDLN27,'20130917','federico.romero',4,'homonimo pedir identificacion. el homonimno es Fortunato Rodolfo Lopez Martinez')
UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN27

--- rodolfo martinez lopez
INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('VICTOR ÁLVAREZ','','','','ANALISTA DE CREDITO',1,1,'Eduardo.Ramirez','20130918')	
DECLARE @BID28 INT
SET @BID28 = IDENT_CURRENT('tbl_MST_Bitacora')
INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID28,@TTID28,@IDLN28,'20130918','MA.CASTELLANOS',5,'homonimo')
UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN28

--- 'JUANLUIS','RODRIGUEZ','LOPEZ'
INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('','JUANLUIS','RODRIGUEZ','LOPEZ','CLIENTE',1,1,'Eduardo.Ramirez','20130806')	
DECLARE @BID29 INT
SET @BID29 = IDENT_CURRENT('tbl_MST_Bitacora')
INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID29,@TTID29,@IDLN29,'20130806','PAMELA.GUERRERO',4,'homonimo')
UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN29

--- 'GUADALUPE','MARTINEZ','MARTINEZ'
--INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('','GUADALUPE','MARTINEZ','MARTINEZ','CLIENTE',1,1,'Eduardo.Ramirez','20130819')	
--DECLARE @BID30 INT
--SET @BID30 = IDENT_CURRENT('tbl_MST_Bitacora')
--INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID30,@TTID30,@IDLN30,'20130819','DALILA.CRUZ',4,'Homonimo de PEP vencido. cliente en veracruz cuando el homónimo es de Nuevo León')
--UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN30

--- 'JOEL','DIAZ','TORRES'
INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('','JOEL','DIAZ','TORRES','CLIENTE',1,1,'Eduardo.Ramirez','20130820')	
DECLARE @BID31 INT
SET @BID31 = IDENT_CURRENT('tbl_MST_Bitacora')
INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID31,@TTID31,@IDLN31,'20130820','MATILDE.ALVAREZ',4,'homónimo')
UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN31

--- 'ANTONIO','GARCIA','TORRES'
INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('','ANTONIO','GARCIA','TORRES','CLIENTE',1,1,'Eduardo.Ramirez','20130828')	
DECLARE @BID32 INT
SET @BID32 = IDENT_CURRENT('tbl_MST_Bitacora')
INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID32,@TTID32,@IDLN32,'20130827','carlos.delolmo',4,'HOMONIMOI')
UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN32

--- 'ELOY','HERNANDEZ','GARCIA'
--INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('','ELOY','HERNANDEZ ','GARCIA','CLIENTE',1,1,'Eduardo.Ramirez','20130909')	
--DECLARE @BID33 INT
--SET @BID33 = IDENT_CURRENT('tbl_MST_Bitacora')
--INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID33,@TTID33,@IDLN33,'20130904','PAMELA.GUERRERO',4,'homonimo')
--UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN33

--- 'GUSTAVO','GARCIA','GONZALEZ'
INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('','GUSTAVO','GARCIA ','GONZALEZ','CLIENTE',1,1,'Eduardo.Ramirez','20130912')	
DECLARE @BID34 INT
SET @BID34 = IDENT_CURRENT('tbl_MST_Bitacora')
INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID34,@TTID34,@IDLN34,'20130911','PAMELA.GUERRERO',4,'HOMONIMO')
UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN34

--- 'JULIOCESAR','X','SOTO'
INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('','JULIOCESAR','X','SOTO','CLIENTE',1,1,'Eduardo.Ramirez','20130917')	
DECLARE @BID35 INT
SET @BID35 = IDENT_CURRENT('tbl_MST_Bitacora')
INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID35,@TTID35,@IDLN35,'20130913','PAMELA.GUERRERO',4,'Homonimo de funcionario de Pemez')
UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN35

--- 'ROSAMARIA','X','HERNANDEZ'
--INSERT INTO tbl_MST_Bitacora (vchPersonaCompleto, vchNombre, vchApPaterno, vchApMaterno, vchRelacionCliente, bitProceso, bitHomonimo, vchUsuarioAutoriza, datFechaAutorizacion) VALUES ('','ROSAMARIA','X','HERNANDEZ','CLIENTE',1,1,'Eduardo.Ramirez','20130925')	
--DECLARE @BID36 INT
--SET @BID36 = IDENT_CURRENT('tbl_MST_Bitacora')
--INSERT INTO tbl_DET_Bitacora (intBitacoraID, intTipoTipificacionID, intIdLN, datFecha, vchUsuario, intSistemaID, vchComentario) VALUES (@BID36,@TTID36,@IDLN36,'20130925','PAMELA.GUERRERO',4,'Homonimo de PEP vencido')
--UPDATE tbl_MST_ListaNegra SET bitEstatus = 0 WHERE intIdLN = @IDLN36


drop table dbo.tmp1

commit

SELECT mst.intBitacoraID, det.intIdLN, det.vchUsuario, det.intSistemaID, case when mst.vchPersonaCompleto != null then mst.vchNombre + ' ' + mst.vchApPaterno + ' ' + mst.vchApMaterno  else vchPersonaCompleto end nombrecom,
mst.vchRelacionCliente, det.vchComentario, mst.bitAutorizado, det.datFecha, mst.datFechaAutorizacion, mst.bitHomonimo, mst.vchUsuarioAutoriza
FROM 
TBL_MST_BITACORA mst inner join TBL_DET_BITACORA det on mst.intBitacoraID = det.intBitacoraID


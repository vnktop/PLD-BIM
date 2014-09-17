// Javascript
// FUNCIONES PARA AJAX
var gVGen = "20071126V1";
var msID;
var msTablaNom;
var msCampoCve;
var msCampoDes;
var msCampoCon;
var msValorCon;
var msCampoNum;
var mlMulCom;
var mlRegVac;
var mlRegTod;
var msValDef;
var msCampoOrd;

var msNomForma;
var msPagina;

var msVarJS;
var mbErrGlo = false;

var mbMosMsg = false;

function c$(x) {
    return document.getElementById(x);
}

function p$(x) {
    return window.parent.document.getElementById(x);
}

function ConsultaDatos(sID, sDatos, Asincrono, bMosMsg) {
    var ospan_Msg = c$("span_Msg");
    var url = "Datos_AJAX.asp";
    var sDat = "id=" + sID;
    if (sID == '' || sID == undefined) return;
    if (sDatos == '' || sDatos == undefined) return;
    if (Asincrono == undefined) Asincrono = true;
    if (bMosMsg == undefined || bMosMsg == null) bMosMsg = true;
    sDat += sDatos;
    ospan_Msg.style.display = "";
    ospan_Msg.innerHTML = '<span class="Mensajes">Buscando la informaci&oacute;n en el sistema...</span>';
    HabilitaCtr(false);
    msID = "Sis_ConDat";
    window.status = "Realizando una consulta al servidor...";
    mbMosMsg = bMosMsg;
    PeticionAJAX(url, sDat, Asincrono);
    return false;
}

function ConsultaDatJS(sID, sCat, varJS) {
    var ospan_Msg = c$("span_Msg");
    var url = "Datos_AJAX.asp";
    var sDat = "id=" + sID;
    if (sID == '' || sID == undefined) return;
    if (varJS == undefined) return;
    sDat += sCat;
    ospan_Msg.style.display = "";
    ospan_Msg.innerHTML = '<span class="Mensajes">Buscando la informaci&oacute;n en el sistema...</span>';
    HabilitaCtr(false);
    msID = "Sis_KeyCom";
    msVarJS = varJS;
    window.status = "Verificando datos en el servidor...";
    PeticionAJAX(url, sDat, false);
    return false;
}

function GeneraCboOpt(sRespuesta) {
    if (sRespuesta == "") {
        //alert("fungen.js\GeneraCboOpt()\n\nNO SE OBTUVIERON REGISTROS");
        /*HabilitaCtr(false);
        var objCbo  = c$(msCampoCve);
        var lNumReg = objCbo.options.length;
        for(var i=0; i<lNumReg;i++) {
        objCbo.selectedIndex=0;
        objCbo.remove(objCbo.selectedIndex);
        }*/
        return '<span class="Mensajes">No se obtuvieron registros</span>';
    }

    var aDat = eval("new Array(" + sRespuesta + ")");
    var lNum = aDat.length;
    if (lNum <= 1) return;
    window.status = "Mostrando los registros obtenidos..."
    if (mlMulCom == 0) {
        var objCbo = c$(msCampoCve);
        var lNumReg = objCbo.options.length;
        for (var i = 0; i < lNumReg; i++) {
            objCbo.selectedIndex = 0;
            objCbo.remove(objCbo.selectedIndex);
        }
        //objCbo.options.innerHTML="";
        if (mlRegVac == 1) objCbo.options.add(new Option("", ""))
        if (mlRegTod == 1) objCbo.options.add(new Option("<<TODOS>>", ""))
        for (var i = 1; i < lNum; i++) {
            var aReg = aDat[i];
            objCbo.options.add(new Option(aReg[1], aReg[0]))
        }
        if (msValDef != "")
            objCbo.value = msValDef
        else
        //alert("fungen.js\GeneraCboOpt()\n\nNO SE OBTUVIERON REGISTROS");
        //alert("ERROR: "+msValDef);
            mbErrGlo = true;
    }
    return "";
}

function GenCboGen(sIDCbo, sObj, vVal, bMulCbo, bRegVac, bRegTod, vValDef) {
    var ospan_Msg = c$("span_Msg");
    var url = "Datos_AJAX.asp";
    var sDat = "id=Cbo_" + sIDCbo;
    if (bMulCbo == undefined || bMulCbo == null) bMulCbo = false;
    if (bRegVac == undefined || bRegVac == null) bRegVac = false;
    if (bRegTod == undefined || bRegTod == null) bRegTod = false;
    if (vValDef == undefined) vValDef = null;
    sDat += "&CmpCon=" + escape(vVal);
    ospan_Msg.style.display = "";
    ospan_Msg.innerHTML = '<span class="Mensajes">Espere por favor...</span>';
    HabilitaCtr(false);
    msID = "Gen_CboNvo";

    msCampoCve = sObj;
    mlMulCom = (bMulCbo) ? 1 : 0;
    mlRegVac = (bRegVac) ? 1 : 0;
    mlRegTod = (bRegTod) ? 1 : 0;
    msValDef = (vValDef == null) ? "" : vValDef.toString();
    window.status = "Obteniendo información del servidor...";
    PeticionAJAX(url, sDat, false);
    return false;
}
/*------------------------------------------------------------------------------------*/
// Llena las opciones de un combo
function GeneraComboGen(TablaNom, CampoCve, CampoDes, CampoCon, ValorCon, CampoNum, MulCom, RegVac, RegTod, ValDef, CampoOrd) {
    var ospan_Msg = c$("span_Msg");
    var url = "Datos_AJAX.asp";
    var sDat = "id=Gen_CboOpt";

    if (MulCom == undefined) MulCom = 0;
    if (RegVac == undefined) RegVac = 1;
    if (RegTod == undefined) RegTod = 0;
    if (ValDef == undefined) ValDef = "";
    if (CampoOrd == undefined) CampoOrd = "";

    if (CampoNum == undefined) CampoNum = "";
    if (CampoCon == undefined) CampoCon = "";
    if (ValorCon == undefined) ValorCon = "";

    if (TablaNom == '' || TablaNom == undefined) return;
    if (CampoCve == '' || CampoCve == undefined) return;
    if (CampoDes == '' || CampoDes == undefined) return;

    sDat += "&NomTab=" + escape(TablaNom);
    sDat += "&CamCve=" + escape(CampoCve);
    sDat += "&CamDes=" + escape(CampoDes);
    sDat += "&CamCon=" + escape(CampoCon);
    sDat += "&ValCon=" + escape(ValorCon);
    sDat += "&ValNum=" + escape(CampoNum);
    sDat += "&CamOrd=" + escape(CampoOrd);
    ospan_Msg.style.display = "";
    ospan_Msg.innerHTML = '<span class="Mensajes">Obteniendo los registros del cat&aacute;logo...</span>';
    HabilitaCtr(false);
    msID = "Gen_CboOpt";

    var lenCve = CampoCve.length;
    var PosSep = CampoCve.indexOf("|")
    CampoCve = CampoCve.substring(PosSep + 1, lenCve);

    msTablaNom = TablaNom;
    msCampoCve = CampoCve;
    msCampoDes = CampoDes;
    msCampoCon = CampoCon;
    msValorCon = ValorCon;
    msCampoNum = CampoNum;
    mlMulCom = MulCom;
    mlRegVac = RegVac;
    mlRegTod = RegTod;
    msValDef = ValDef;
    msCampoOrd = CampoOrd;
    window.status = "Obteniendo los registros del catálogo...";
    PeticionAJAX(url, sDat, false);
    return false;
}

function GuardaDatos(sID, sDatos, sNomForma, sPagina, Asincrono) {
    var ospan_Msg = c$("span_Msg");
    var url = "ActDat_AJAX.asp";
    var sDat = "id=" + sID;
    if (Asincrono == undefined) Asincrono = true;
    sDat += sDatos;
    ospan_Msg.style.display = "";
    ospan_Msg.innerHTML = '<span class="Mensajes">Actualizando/guardando la información en el sistema...</span>';
    msID = "Sis_GuaDat";
    msNomForma = sNomForma;
    msPagina = sPagina;
    window.status = "Guardando/Actualizando la información...";
    PeticionAJAX(url, sDat, Asincrono);
    return false;
}

function GetXmlHttpObject(handler) {
    var objXmlHttp = null;
    if (navigator.userAgent.indexOf("Opera") >= 0) {
        alert("Error de Navegador.\n\n El Navegador OPERA no es soportado");
        return
    }
    if (navigator.userAgent.indexOf("MSIE") >= 0) {
        var strName = "Msxml2.XMLHTTP"
        if (navigator.appVersion.indexOf("MSIE 5.5") >= 0)
            strName = "Microsoft.XMLHTTP"
        try {
            objXmlHttp = new ActiveXObject(strName)
            objXmlHttp.onreadystatechange = handler;
            return objXmlHttp
        } catch (e) {
            mbErrGlo = true;
            DesHabilitaCtr();
            alert("Error. Scripting for ActiveX might be disabled\n" + e.description)
            return
        }
    }
    if (navigator.userAgent.indexOf("Mozilla") >= 0) {
        objXmlHttp = new XMLHttpRequest()
        objXmlHttp.onload = handler
        objXmlHttp.onerror = handler
        return objXmlHttp
    }
}

function ObtenDatosCampo(sRespuesta) {
    if (sRespuesta == "") {
        //alert("fungen.js\nObtenDatosCampo()\n\nSINREGISTROS");
        HabilitaCtr(false);
        return (mbMosMsg) ? '<span class="Mensajes">No se obtuvieron registros</span>' : '';
        //	} else if (sRespuesta.substr(0,13)=="['Dat_AvaMul'") {
        //		alert(sRespuesta);
    }
    var aDat;
    try {
        aDat = eval("new Array(" + sRespuesta + ")");
    } catch (e) {
        //alert("fungen.js\nObtenDatosCampo()\n\nERROR: " + e.description + "\n\n" + sRespuesta);
        mbErrGlo = true;
        HabilitaCtr(false);
        return "ERROR: " + e.description + "\n\n" + sRespuesta;
    }
    var lNum = aDat.length;
    if (lNum <= 1) return;
    window.status = "Mostrando los registros obtenidos..."
    for (var i = 1; i < lNum; i++) {
        var aReg = aDat[i];
        var obj = c$(aReg[0]);
        if (obj != undefined) {
            //alert(aReg[0] + " = " + aReg[1]);
            obj.value = aReg[1];
        }
        else {
            //alert("fungen.js\nObtenDatosCampo()\n\n"+aReg);
            mbErrGlo = true;
        }
    }
    return "";
}

function ObtenDatosVarJS(sRespuesta) {
    if (sRespuesta == "") {
        //alert("fungen.js\ObtenDatosVarJS()\n\nNO SE OBTUVIERON REGISTROS");
        HabilitaCtr(false);
        return "No se obtuvieron registros";
    }
    var aDat = eval("new Array(" + sRespuesta + ")");
    var lNum = aDat.length;
    if (lNum <= 1) return "";
    window.status = "Mostrando los registros obtenidos..."
    eval(msVarJS + " = new Array(" + sRespuesta + ")")
    return "";
}

function ObtResAjaxSrv() {
    if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
        var ospan_Msg = c$("span_Msg");
        var sRespuesta = xmlHttp.responseText;
        var lStatus = xmlHttp.status;
        var sMsg = '<span class="Mensajes">';
        if (lStatus == 200) {
            VerificaSesionSistema(sRespuesta);
            switch (msID) {
                case "Ver_Llave":
                    switch (sRespuesta) {
                        case 'OK':
                            HabilitaCtr(true);
                            sMsg = '';
                            break;
                        default:
                            alert("MENSAJE DEL SISTEMA\n\nEl cat\u00e1logo no puede ser dado de alta.\n\nYa existe el registro en la base de datos.\n\n\n" + sRespuesta);
                            sMsg += 'Cat&aacute;logo existente en el sistema<br>Seleccione uno distinto.';
                    }
                    break;
                case "Gen_CboOpt":
                    HabilitaCtr(true);
                    sMsg = GeneraCboOpt(sRespuesta);
                    break;
                case "Gen_CboNvo":
                    HabilitaCtr(true);
                    //alert(sRespuesta);
                    sMsg = GeneraCboOpt(sRespuesta);
                    sMsg = "";
                    break;
                case "Gen_CboNvoRef":
                    HabilitaCtr(true);
                    sMsg = GeneraCboOptRef(sRespuesta);
                    sMsg = "";
                    return;
                    break;
                case "Sis_GuaDat":
                    switch (sRespuesta) {
                        case 'OK':
                            if (msNomForma != "" && msNomForma != undefined) {
                                if (msPagina != "" && msPagina != undefined) {
                                    var oForma = eval("document.forms." + msNomForma);
                                    oForma.action = msPagina;
                                    oForma.submit();
                                }
                            }
                            sMsg = '';
                            break;
                        default:
                            alert("MENSAJE DEL SISTEMA\n_______________________________________________\n¡ No se puede realizar la actualizaci\u00f3n/guardado de datos!\n_______________________________________________\n\n" + sRespuesta);
                            sMsg += 'No se pudo realizar el guardado/actualización de datos.';
                    }
                    break;
                case "Sis_ConDat":
                    //alert(sRespuesta)
                    sMsg = ObtenDatosCampo(sRespuesta);
                    if (sMsg == "") HabilitaCtr(true);
                    break;
                case "Sis_KeyCom":
                    sMsg = ObtenDatosVarJS(sRespuesta);
                    if (sMsg == "") HabilitaCtr(true);
                    break;
                default:
                    alert("NO IMPLEMENTADO");
            }
            if (sMsg == "") {
                window.status = "Listo";
                ospan_Msg.style.display = "none";
            } else {
                window.status = "ADVERTENCIA: Mensaje del sistema";
                ospan_Msg.style.display = "";
                ospan_Msg.innerHTML = sMsg + '</span>';
            }
        } else {
            sMsg = "ERROR INTERNO DEL SISTEMA\nSe encontr\u00f3 un error al procesar la solicitud";
            window.status = "ERROR INTERNO " + lStatus;
            ospan_Msg.style.display = "";
            ospan_Msg.innerHTML = sRespuesta;
            if (sMsg != "") alert(sMsg);
        }
    }
}

function PeticionAJAX(url, datos, bAsincrona) {
    xmlHttp = GetXmlHttpObject(ObtResAjaxSrv);
    //window.status="Verificando la clave del catálogo...";
    xmlHttp.open('POST', url, bAsincrona);
    xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xmlHttp.setRequestHeader('Accept-Language', 'sp')
    xmlHttp.setRequestHeader('Pragma', 'no-cache')
    xmlHttp.setRequestHeader('charset', 'iso-8859-1');
    xmlHttp.send(datos);
    return;
}

function VerificaSesionSistema(sRespuesta) {
    if (typeof (sRespuesta) == "string") {
        var sTimeOut = "TIMEOUT";
        var sLeftMsg = sRespuesta.substr(0, sTimeOut.length);
        if (sTimeOut == sLeftMsg) {
            var sMsg = "ERROR INTERNO DEL SISTEMA\n\n\tLa sesi\u00f3n ha terminado.\n\n";
            sMsg += "El sistema ha cerrado su sesi\u00f3n.\n";
            sMsg += "Favor de salirse de  la aplicaci\u00f3n y volver a entrar al sistema.\n";
            sMsg += "Gracias.";
            alert(sMsg);
            window.location = "Salir.asp"
        }
    }
}

function VerificaLlave(DatBas, Tabla, Campo, Valor) {
    var ospan_Msg = c$("span_Msg");
    var oDatBas = c$(DatBas);
    var url = "Datos_AJAX.asp";
    var sDat = "id=Ver_Llave";
    if (oDatBas.value == '' || oDatBas.value == undefined) return;
    if (Tabla == '' || Tabla == undefined) return;
    if (Campo == '' || Campo == undefined) return;
    if (Valor == '' || Valor == undefined) return;
    sDat += "&NomDatBas=" + escape(oDatBas.value);
    sDat += "&NomTabla=" + escape(Tabla);
    sDat += "&NomCampo=" + escape(Campo);
    sDat += "&ValCampo=" + escape(Valor);
    ospan_Msg.style.display = "";
    ospan_Msg.innerHTML = '<span class="Mensajes">Verificando la clave del cat&aacute;logo...</span>';
    HabilitaCtr(false);
    msID = "Ver_Llave";
    window.status = "Verificando datos en el servidor...";
    PeticionAJAX(url, sDat, true);
    return false;
}

// FUNCIONES PARA MENEJO DE MENSAJES
function Msg_handleErr(msg, url, l, sMsg, bUsaPag) {
    var stxt = "";
    if (sMsg == '') {
        stxt += "ERROR DEL SISTEMA.\n\n";
        stxt += "¡ADVERTENCIA!.\n";
        stxt += "Notificar del error a sistemas.\n\n";
        if (!bUsaPag)
            stxt += "NO CONTINUE USANDO LA PÁGINA ACTUAL.\n\n\n";
        stxt += "Se encontró un error en la página actual.\n\n";
        stxt += "Error: " + msg + "\n";
        stxt += "URL: " + url + "\n";
        stxt += "Línea: " + l + "\n\n";
        stxt += "Hacer click en OK para continuar.\n\n";
    } else
        stxt = sMsg;
    alert(stxt);
}

function OcultaMensaje() {
    var ospan_Msg = c$("span_Msg");
    ospan_Msg.style.display = "none";
    ospan_Msg.innerHTML = "";
    window.status = "Listo";
}

// FUNCIONES VARIAS
function CambiaCero(Obj) {
    // Si tiene como caracater unico un cero lo cambiamos por un espacio vacio
    if (Obj.value == "") Obj.value = "0";
}

function CambiaVacio(Obj) {
    // Si tiene como caracater unico un cero lo cambiamos por un espacio vacio
    if (Obj.value == "") Obj.value = "";
}

function CopiaCbo(sCboOri, sCboNue, sValDef) {
    var oCboOri = c$(sCboOri);
    var oCboNue = c$(sCboNue);
    if (oCboOri != undefined && oCboNue != undefined) {
        IniCboEle(oCboNue);
        lNumReg = oCboOri.options.length;
        for (var i = 0; i < lNumReg; i++) {
            oCboNue.options.add(new Option(oCboOri.options[i].text, oCboOri.options[i].value))
        }
        IniCtrFrm(oCboNue.id);
        if (sValDef != undefined && sValDef != null) oCboNue.value = sValDef;
    }
}

function IniCbo(e, oCbo, sCboBorra) {
    var vkeyCode = (document.all) ? event.keyCode : e.keyCode;
    if (vkeyCode == 27) {
        oCbo.selectedIndex = -1;
        oCbo.value = "";
        if (sCboBorra != undefined) {
            var oCboDel = c$(sCboBorra);
            if (oCboDel != undefined) {
                var lNumReg = oCboDel.options.length;
                for (var i = 0; i < lNumReg; i++) {
                    oCboDel.selectedIndex = 0;
                    oCboDel.remove(oCboDel.selectedIndex);
                }
            }
        }
    }
}

function IniCboEle(oCbo) {
    if (oCbo != undefined) {
        var lNumReg = oCbo.options.length;
        for (var i = 0; i < lNumReg; i++) {
            oCbo.selectedIndex = 0;
            oCbo.remove(oCbo.selectedIndex);
        }
    }
}

function ObtenFechaYMD_DMY(sFec) {
    var vFec = c$(sFec).value;
    if (vFec != "") {
        if (vFec.length == 8) {
            var sAnio = vFec.substr(0, 4);
            var sMes = vFec.substr(4, 2);
            var sDia = vFec.substr(6, 2);
            if (!(isNaN(parseInt(sAnio)) && isNaN(parseInt(sMes)) && isNaN(parseInt(sDia)))) {
                return sDia + "/" + sMes + "/" + sAnio
            }
        }
    }
    return "";
}

function ltrim(argvalue) {
    while (1) {
        if (argvalue.substring(0, 1) != " ")
            break;
        argvalue = argvalue.substring(1, argvalue.length);
    }
    return argvalue;
}

function rtrim(argvalue) {
    while (1) {
        if (argvalue.substring(argvalue.length - 1, argvalue.length) != " ")
            break;
        argvalue = argvalue.substring(0, argvalue.length - 1);
    }
    return argvalue;
}

function trim(argvalue) {
    var tmpstr = ltrim(argvalue);
    return rtrim(tmpstr);
}

// FUNCIONES DE CUESTIONES "VISUALES"
function ColRowMM(obj) {
    obj.style.background = "#CCD7E4";
}
function ColRowMOP(obj) {
    obj.style.background = "#E8E8E8";
}
function ColRowMON(obj) {
    obj.style.background = "#FFFCD9";
}
// --- Llena las opciones de un combo con datos precargados en una var JS
function GenCboJS(oCbo, varJS, lCve, lDes, sValDef) {
    if (oCbo != undefined && oCbo != null) {
        if (lCve == undefined || lCve == null) lCve = 0;
        if (lDes == undefined || lDes == null) lDes = 1;
        IniCboEle(oCbo);
        lNumReg = varJS.length;
        for (var i = 1; i < lNumReg; i++)
            oCbo.options.add(new Option(varJS[i][lDes], varJS[i][lCve]))

        IniCtrFrm(oCbo.id);
        if (sValDef != undefined && sValDef != null) oCbo.value = sValDef;
    }
}
function genArrCbo(oCbo) {
    var aCbo = new Array();
    if (oCbo == undefined) return aCbo;
    aCbo[0] = oCbo.id;
    var lNum = parseInt(oCbo.options.length);
    for (var i = 1; i <= lNum; i++) {
        aCbo[i] = new Array();
        aCbo[i][0] = oCbo.options[i - 1].value;
        aCbo[i][1] = oCbo.options[i - 1].text;
    }
    return aCbo;
}
function ObtArrHTML_Align_Otro(sCadAli) {
    var aReg = "";
    if (sCadAli != "") {
        var aCol = sCadAli.split("|");
        var lCol = aCol.length;
        if (BrowserID() == "IE") {
            for (var i = 0; i < lCol; i++) { aCol[i] = ""; }
        } else {
            for (var i = 0; i < lCol; i++) {
                var sAlign = ""
                switch (aCol[i]) {
                    case "r": sAlign = "right"; break;
                    case "c": sAlign = "center"; break;
                    default: sAlign = "left";
                }
                aCol[i] = ' align="' + sAlign + '" ';
            }
        }
        aReg = aCol;
    }
    return aReg;
}
function ObtCadHTML_Align_IE(sCadAli) {
    var sCadReg = "";
    if (BrowserID() == "IE" && sCadAli != "") {
        var aCol = sCadAli.split("|");
        var lCol = aCol.length;
        sCadReg += (lCol > 0) ? "<colgroup>" : "";
        for (var i = 0; i < lCol; i++) {
            var sAlign = ""
            switch (aCol[i]) {
                case "r": sAlign = "right"; break;
                case "c": sAlign = "center"; break;
                default: sAlign = "left";
            }
            sCadReg += '<col align="' + sAlign + '">'
        }
        sCadReg += (lCol > 0) ? "</colgroup>" : "";
    }
    return sCadReg;
}

function ResaltaCampo(sObj) {
    var obj = c$("TD_" + sObj); // Asignamos al objeto el renglon 
    var objCap = c$(sObj);
    obj.style.color = "BLUE"; // Cambiamos a letra azul 
    try {
        var oCamBack = false;
        var oReadOnly = false;
        var oDisabled = false;
        var oChecked = false;
        if (typeof (objCap.readOnly) != undefined)
            oReadOnly = objCap.readOnly;
        if (typeof (objCap.disabled) != undefined)
            oDisabled = objCap.disabled;
        if (typeof (objCap.checked) != undefined) {
            if (objeto.toUpperCase().substr(0, 3) == 'CHK')
                oChecked = true;
            else
                oChecked = objCap.checked;
        }
        if (!(oReadOnly || oDisabled || oChecked))
            objCap.style.backgroundColor = "#FFFF99";
    } catch (e) {
        //alert("ERROR " + e.number + "\n" + e.description);
    }
}

function RestauraCampo(sObj) {
    var obj = c$("TD_" + sObj); // Asignamos al objeto el renglon de la tabla (TD) 
    var objCap = c$(sObj);
    obj.style.color = "BLACK"; // Cambiamos a letra negra 
    try {
        var oCamBack = false;
        var oReadOnly = false;
        var oDisabled = false;
        var oChecked = false;
        if (typeof (objCap.readOnly) != undefined)
            oReadOnly = objCap.readOnly;
        if (typeof (objCap.disabled) != undefined)
            oDisabled = objCap.disabled;
        if (typeof (objCap.checked) != undefined) {
            if (objeto.toUpperCase().substr(0, 3) == 'CHK')
                oChecked = true;
            else
                oChecked = objCap.checked;
        }
        if (!(oReadOnly || oDisabled || oChecked))
            objCap.style.backgroundColor = "WHITE";
    } catch (e) {
        //alert("ERROR " + e.number + "\n" + e.description);
    }
}

// FUNCIONES DE VALIDACIÓN
function ValidaEntero(sCmp, Separador) {
    var obj = c$(sCmp);
    if (Separador == undefined) Separador = "S";
    if (obj.value == "") obj.value = 0;
    obj.value = QC(obj.value);  // Quitamos comas
    if (ValidaNumero(sCmp, "campo entero") == false) {
        obj.value = 0;
    } else {
        // Verificamos que no tenga puntos decimales
        if (obj.value.indexOf(".") > 0) {
            alert("Solo enteros sin decimales.");
            obj.value = FormatoNum(obj.value, 0);
            obj.focus();
        } else {
            if (Separador == "S")
                obj.value = FormatoNum(obj.value, 0);
            else
                obj.value = obj.value;
        }
    }
}

function ValidaFecha(sCmp) {
    try {
        var obj = c$(sCmp);
        var cadFec = obj.value;
        if (cadFec == "") return false;
        if (cadFec.substr(0, 2) == "00") return false;
        var cmpFec = new Date(cadFec);
        if (isNaN(cmpFec)) {
            return false;
        } else {
            if (cmpFec.toString() == "")
                return false;
            else
                return true;
        }
    } catch (err) {
        return false
    }
    return true;
}

function ValidaFechaYMD(sCmp) {
    try {
        var obj = c$(sCmp);
        var cadFec = obj.value;
        if (cadFec == "") return false;
        if (cadFec.length != 8) return false;
        if (cadFec.substr(6, 2) == "00") return false;
        var cmpFec = new Date(cadFec.substr(0, 4), cadFec.substr(4, 2), cadFec.substr(6, 2));
        if (isNaN(cmpFec)) {
            return false;
        } else {
            if (cmpFec.toString() == "")
                return false;
            else
                return true;
        }
    } catch (err) {
        return false
    }
    return true;
}

function ValidaGen(sobj, sMsg) {
    obj = c$(sobj);
    if (trim(obj.value) == "") {
        alert("Proporciona " + sMsg);
        obj.focus();
        return false
    }
}

function ValidaImporte(sCmp, lNumDec) {
    var obj = c$(sCmp)
    if (obj.value == "") obj.value = 0;
    obj.value = QC(obj.value);
    if (ValidaNumero(sCmp, "campo numérico") == false)
        obj.value = 0;
    obj.value = FormatoNum(obj.value, lNumDec);
}

function ValidaNumero(sObj, sMsg) {
    var obj = c$(sObj);
    if (trim(obj.value) == "") {
        alert("Proporciona " + sMsg);
        obj.focus();
        return 0;
    } else if (isNaN(obj.value)) {
        alert("Formato no v\u00e1lido para " + sMsg);
        obj.focus();
        return 0;
    }
}

function ValidaNumMC(sObj, sMsg) {
    var obj = c$(sObj);
    if (trim(obj.value) == "") {
        alert("Proporciona " + sMsg);
        obj.focus();
        return 0;
    } else if (isNaN(obj.value)) {
        alert("Formato no v\u00e1lido para " + sMsg);
        obj.focus();
        return 0;
    } else if (parseInt(obj.value) < 0) {
        alert("El " + sMsg + " debe ser mayor o igual a cero");
        obj.focus();
        return 0;
    }
}

function ValidaPorcentaje(sCmp, lNumDec) {
    var obj = c$(sCmp);
    if (obj.value == "") obj.value = 0;
    obj.value = QC(obj.value);
    if (ValidaNumero(sCmp, "campo numérico") == false) {
        obj.value = 0;
    } else {
        if (parseFloat(obj.value) > 100) {
            alert("El porcentaje no puede ser mayor a 100.");
            obj.value = 100;
            obj.focus();
        }
    }
    obj.value = FormatoNum(obj.value, lNumDec);
}

function ValidaRangoFechaYMD(sFecIni, sFecFin, bObliga) {
    if (bObliga == undefined || bObliga == null) bObliga = false;
    var vFecIni = c$(sFecIni).value;
    var vFecFin = c$(sFecFin).value;
    if (vFecIni != "" && vFecFin != "") {
        if (vFecIni.length == 8 && vFecFin.length == 8) {
            var lAnioIn = parseInt(vFecIni.substr(0, 4), 10);
            var lMesIni = parseInt(vFecIni.substr(4, 2), 10);
            var lDiaIni = parseInt(vFecIni.substr(6, 2), 10);
            var lAnioFi = parseInt(vFecFin.substr(0, 4), 10);
            var lMesFin = parseInt(vFecFin.substr(4, 2), 10);
            var lDiaFin = parseInt(vFecFin.substr(6, 2), 10);
            if (!(isNaN(lAnioIn) && isNaN(lMesIni) && isNaN(lDiaIni))) {
                if (!(isNaN(lAnioFi) && isNaN(lMesFin) && isNaN(lDiaFin))) {
                    var dFecIni = new Date(lAnioIn, lMesIni - 1, lDiaIni);
                    var dFecFin = new Date(lAnioFi, lMesFin - 1, lDiaFin);
                    return (dFecIni > dFecFin) ? false : true;
                }
            }
        }
    }
    return (bObliga) ? false : true;
}

// OTRAS FUNCIONES
// Función para detectar el navegador y la versión
function BrowserID(bVersion, bVerCom) {
    var sBrowserID = '';
    var sBrwId;
    var oNavUA = navigator.userAgent;
    var oNavAV = navigator.appVersion;
    if (bVersion == undefined) bVersion = false;
    if (bVerCom == undefined) bVerCom = false;

    if (oNavUA.indexOf("MSIE") != -1)
        sBrowserID = "IE"; // Microsoft Internet Explorer
    else if (oNavUA.indexOf("Firefox") != -1)
        sBrowserID = "FF"; // FireFox
    else if (oNavUA.indexOf("Opera") != -1)
        sBrowserID = "NS"; // Netscape
    else if (oNavUA.indexOf("Mozilla") != -1)
        sBrowserID = "OP"; // Opera
    else
        sBrowserID = "Desconocido";

    sBrwId = sBrowserID;
    if (bVersion) {
        var tmp;
        var versionindex;
        switch (sBrwId) {
            case "IE":
                tmp = oNavAV.split("MSIE");
                sBrowserID += "|" + parseFloat(tmp[1]);
                break;
            case "FF":
                versionindex = oNavUA.indexOf("Firefox") + 8
                sBrowserID += "|" + oNavUA.charAt(versionindex);
                break;
            default:
                sBrowserID += "|No_Implementado";
        }
    }

    if (bVerCom) {
        var tmp;
        var versionindex;
        switch (sBrwId) {
            case "IE":
                tmp = oNavAV.split("MSIE");
                sBrowserID += "|" + tmp[1].substring(0, tmp[1].indexOf(";"));
                break;
            case "FF":
                versionindex = oNavUA.indexOf("Firefox") + 8
                sBrowserID += "|" + oNavUA.substring(versionindex);
                break;
            default:
                sBrowserID += "|No_Implementado";
        }
    }
    sBrowserID = sBrowserID.replace(/\s/, "")
    return sBrowserID;
}

function SoloNumeros(oObj, bDec) {
    if (document.all) {
        var lEvtKeyCod = event.keyCode;
        if (lEvtKeyCod < 48 || lEvtKeyCod > 57) {
            if (bDec == undefined || bDec == null) bDec = false
            if (bDec) {
                if (lEvtKeyCod == 46) {
                    if (oObj.value.indexOf(".") == -1) return;
                }
            }
            event.keyCode = 0;
        }
    }
}

function CtrSoloNumeros(oCtr) {
    var sVal = oCtr.value;
    sVal = sVal.replace(/(\D)*/gi, "")
    oCtr.value = sVal;
}

/* ********************************************* */
function HabCtrl(sCtrl, bEdo, bNormal) {
    if (sCtrl != undefined && sCtrl != "") {
        var sCtrls = sCtrl.split("|");
        var lNumCtr = sCtrls.length;
        for (var i = 0; i < lNumCtr; i++) {
            if (sCtrls[i] != "") {
                var oCtr = c$(sCtrls[i]);
                if (oCtr != undefined && oCtr != null) {
                    oCtr.disabled = !bEdo;
                    if (oCtr.type == "button" || oCtr.type == "file") {
                        //oCtr.style.cursor = (bEdo) ? "hand"    : "not-allowed";
                        oCtr.style.cursor = (bEdo) ? "pointer" : "not-allowed";
                        oCtr.style.color = (bEdo) ? "#FFAA26" : "#C0C0C0";
                        if (bNormal != undefined && bNormal != null && bNormal == true)
                            oCtr.style.color = "#FFFFFF"
                    }
                }
            }
        }
    }
}

function IniCtrFrm(sCtrl) {
    if (sCtrl != undefined && sCtrl != "") {
        var sCtrls = sCtrl.split("|");
        var lNumCtr = sCtrls.length;
        for (var i = 0; i < lNumCtr; i++) {
            if (sCtrls[i] != "") {
                var oCtr = c$(sCtrls[i]);
                if (oCtr != undefined && oCtr != null) {
                    switch (oCtr.type) {
                        case "select-one": oCtr.value = ""; oCtr.selectedIndex = -1; break;
                        case "text": oCtr.value = ""; break;
                    }
                }
            }
        }
    }
}

function ObtValCtr(sCtrl) {
    var sVal = "";
    if (sCtrl != undefined && sCtrl != "") {
        var sCtrls = sCtrl.split("|");
        var lNumCtr = sCtrls.length;
        for (var i = 0; i < lNumCtr; i++) {
            if (sCtrls[i] != "") {
                var oCtr = c$(sCtrls[i]);
                if (oCtr != undefined) sVal += oCtr.value + "|";
            }
        }
    }
    return sVal;
}

// Funcion que ayuda manejar si es visible, habilitado un control que depende del valor de otro control
function CtrDepOtrCtr(vVal, sCtr, sCtrDep, vDef, vDefDIF, bVis, bDis, bVisDIF, bDisDIF, bStyVis) {
    if (bVis == undefined) bVis = true;
    if (bDis == undefined) bDis = false;
    if (bVisDIF == undefined) bVisDIF = false;
    if (bDisDIF == undefined) bDisDIF = true;
    if (bStyVis == undefined) bStyVis = false;
    var oCtr = c$(sCtr);
    var oCtrDep = c$(sCtrDep);
    if (oCtr != undefined && oCtrDep != undefined) {
        var aVal = vVal.split("|");
        var lNum = aVal.length;
        var bVal = false;
        for (var i = 0; i < lNum; i++) {
            if (aVal[i] == oCtr.value) {
                bVal = true;
                break;
            }
        }
        if (bVal) {
            if (bStyVis)
                oCtrDep.style.visibility = (bVis) ? "visible" : "hidden";
            else
                oCtrDep.style.display = (bVis) ? "" : "none";
            oCtrDep.disabled = bDis;
            if (vDef != undefined) oCtrDep.value = vDef;
        } else {
            if (bStyVis)
                oCtrDep.style.visibility = (bVisDIF) ? "visible" : "hidden";
            else
                oCtrDep.style.display = (bVisDIF) ? "" : "none";
            oCtrDep.disabled = bDisDIF;
            if (vDefDIF != undefined) oCtrDep.value = vDefDIF;
        }
    }
}

/* ********************************************* */
function FormatoNumero(pObj, pDec, pRelleno, pLado) {
    var Numero = trim(QC(pObj.value));
    if (isNaN(Numero)) Numero = 0;
    if (Numero == "") Numero = 0;
    if (pDec == 0 && pRelleno != 0) {
        var Ceros = "";
        var NumCer = parseInt(pRelleno) - parseInt(Numero.length);
        for (var i = 1; i <= NumCer; i++) Ceros += "0";
        pObj.value = (pLado == "I") ? Ceros + Numero : Numero + Ceros;
    } else {
        pObj.value = formatValue(Numero, pDec)
    }
}

function formatDecimal(vVal, bAgrCer, lNumDec) {
    var numDec = (lNumDec == null || lNumDec == undefined) ? 2 : lNumDec;
    var lNum = Math.pow(10, numDec);
    vVal = Math.round(parseFloat(vVal) * lNum) / lNum;
    vVal = vVal.toString();
    if (vVal.indexOf(".") == 0) vVal = "0" + vVal;
    if (bAgrCer == true) {
        if (vVal.indexOf(".") == -1 && lNumDec) vVal += ".";
        while ((vVal.indexOf(".") + 1) > (vVal.length - lNumDec))
            vVal += "0";
    }
    if (lNumDec <= 0 && vVal.indexOf(".") >= 0) {
        vVal = vVal.substring(0, vVal.indexOf("."));
    }
    return vVal;
}

function formatValue(vVal, lNumDec) {
    var vOriginal = vVal;
    var residuo;
    var sCarFor = "";
    var j = 0;
    vVal = formatDecimal(vVal, true, lNumDec);
    if (lNumDec > 0) {
        vValEnt = vVal.substring(0, vVal.indexOf("."));
        vValReg = vVal.substring(vVal.indexOf("."), vVal.length);
    } else {
        vValEnt = vVal;
        vValReg = "";
    }
    for (var i = (vValEnt.length - 1); i >= 0; i--) {
        j++;
        residuo = j % 3;
        vValReg = vValEnt.substring(i, i + 1) + sCarFor + vValReg;
        sCarFor = (residuo == 0) ? "," : "";
    }
    return vValReg;
}

function FormatoNumeroSC(pObj) {
    var Numero = QC(pObj.value);
    if (isNaN(parseFloat(Numero))) Numero = 0;
    pObj.value = Numero;
}

function FormatoNumeroSCSC(pObj) {
    var Numero = QC(pObj.value);
    if (isNaN(parseFloat(Numero))) Numero = "";
    pObj.value = Numero;
}

function Reemplaza(Cadena, CadBusca, CadRemp) {
    if ((CadBusca == CadRemp) || (parseInt(CadRemp.indexOf(CadBusca)) > -1)) {
        errmessage = "ERROR Función 'Reemplaza': \n";
        errmessage += "El segundo y el tercer argumento pueden ser los mismos";
        errmessage += "o bien, el tercer argumento, contiene al segundo.\n";
        errmessage += "Esto ocasionaría un ciclo infinito al realizar el reemplezo de la cadena.";
        alert(errmessage);
        return Cadena;
    }
    while (Cadena.indexOf(CadBusca) != -1) {
        var leading = Cadena.substring(0, Cadena.indexOf(CadBusca));
        var trailing = Cadena.substring(Cadena.indexOf(CadBusca) + CadBusca.length, Cadena.length);
        Cadena = leading + CadRemp + trailing;
    }
    return Cadena;
}

function QC(Numero) {
    return Reemplaza(Numero, ",", "");
}

function FormatoNum(Numero, Digitos) {
    return (trim(Numero) != "") ? formatValue(Numero, Digitos) : Numero;
}

// Funciones de Bloqueo del Teclado
function fIEPKeyDown() {
    var key_f5 = 116;
    var key_esc = 27;
    var key_back = 8;
    var key_enter = 13;
    var sOrigen = '';
    if (key_f5 == event.keyCode) {
        parent.document.PagActual.location.href = self.document.location.href;
        location.reload();
        parent.document.PagActual.focus();
        event.keyCode = 0;
        return false;
    } else if (event.altKey && (event.keyCode == 37 || event.keyCode == 39)) {
        return false; 		 //CTRL+C             CTRL+V               CTRL+X               CTRL+E
    } else if (event.ctrlKey && (event.keyCode == 67 || event.keyCode == 86 || event.keyCode == 88 || event.keyCode == 69)) {
        return true;
    } else if (event.ctrlKey && (event.keyCode != 17)) {
        event.keyCode = 0;
        return false;
    } else if (event.ctrlKey && (event.keyCode == 78 || event.keyCode == 82)) {
        return false;            // Ctrl+H            // Ctrl+Q
    } else if (event.ctrlKey && (event.keyCode == 72 || event.keyCode == 81)) {
        return false;
    } else if (event.keyCode == 122) {
        event.keyCode = 0;
        return false;
    } else if (event.keyCode == 114) {
        event.keyCode = 0;
        return false;
    } // window.event.keyCode == 505???

    sOrigen = event.srcElement.type;
    if (sOrigen == undefined)
        sOrigen = '';
    else
        sOrigen = sOrigen.toLowerCase();

    if (key_back == event.keyCode) {
        switch (sOrigen) {
            case 'text':
            case 'textarea':
            case 'password':
                if (event.srcElement.readOnly) {
                    event.keyCode = 0;
                    return false;
                }
                break;
            default:
                //"select-one", undefined
                event.keyCode = 0;
                return false;
        }
        /*		} else if (key_esc==event.keyCode) {
        switch(sOrigen) {
        case 'select-one':
        var sObj=event.srcElement.id;
        if (document.forms.length==1) {
        var oObj=eval("document.forms[0]." + sObj);
        oObj.selectedIndex=-1;
        }
        } */
    }
}

// MANEJO DE EVENTOS
function addEventToObject(oCtr, sEvent, nameFunction) {
    if (window.attachEvent)
        oCtr.attachEvent("on" + sEvent, nameFunction);
    else if (window.addEventListener)
        oCtr.addEventListener(sEvent, nameFunction, false);
}

function removeEventToObject(oCtr, sEvent, nameFunction) {
    if (window.detachEvent)
        oCtr.detachEvent("on" + sEvent, nameFunction);
    else if (window.removeEventListener)
        oCtr.removeEventListener(sEvent, nameFunction, false);
}

function GeneraCboOptRef(sRespuesta) {
    if (sRespuesta == "") {
        //HabilitaCtr(false);
        var objCbo = c$(msCampoCve);
        var lNumReg = objCbo.options.length;
        for (var i = 0; i < lNumReg; i++) {
            objCbo.selectedIndex = 0;
            objCbo.remove(objCbo.selectedIndex);
        }
        //var Resp = '<span class="Mensajes">No se obtuvieron registros</span>';
        return "";
        //return '<span class="Mensajes">No se obtuvieron registros</span>';
    }
    else {
        var aDat = eval("new Array(" + sRespuesta + ")");
        var lNum = aDat.length;
        if (lNum <= 1) return;
        window.status = "Mostrando los registros obtenidos..."
        if (mlMulCom == 0) {
            var objCbo = c$(msCampoCve);
            var lNumReg = objCbo.options.length;
            for (var i = 0; i < lNumReg; i++) {
                objCbo.selectedIndex = 0;
                objCbo.remove(objCbo.selectedIndex);
            }
            //objCbo.options.innerHTML="";
            if (mlRegVac == 1) objCbo.options.add(new Option("", ""))
            if (mlRegTod == 1) objCbo.options.add(new Option("<<TODOS>>", ""))
            for (var i = 1; i < lNum; i++) {
                var aReg = aDat[i];
                objCbo.options.add(new Option(aReg[1], aReg[0]))
            }
            if (msValDef != "")
                objCbo.value = msValDef
            else
            //alert("fungen.js\GeneraCboOpt()\n\nNO SE OBTUVIERON REGISTROS");
            //alert("ERROR: "+msValDef);
                mbErrGlo = true;
        }
        return "";
    }
}

function GenCboGenRef(sIDCbo, sObj, vVal, bMulCbo, bRegVac, bRegTod, vValDef) {
    var ospan_Msg = c$("span_Msg");
    var url = "Datos_AJAX.asp";
    var sDat = "id=Cbo_" + sIDCbo;
    if (bMulCbo == undefined || bMulCbo == null) bMulCbo = false;
    if (bRegVac == undefined || bRegVac == null) bRegVac = false;
    if (bRegTod == undefined || bRegTod == null) bRegTod = false;
    if (vValDef == undefined) vValDef = null;
    sDat += "&CmpCon=" + escape(vVal);
    //ospan_Msg.style.display="";
    //ospan_Msg.innerHTML='<span class="Mensajes">Espere por favor...</span>';
    HabilitaCtr(false);
    msID = "Gen_CboNvoRef";
    msCampoCve = sObj;
    mlMulCom = (bMulCbo) ? 1 : 0;
    mlRegVac = (bRegVac) ? 1 : 0;
    mlRegTod = (bRegTod) ? 1 : 0;
    msValDef = (vValDef == null) ? "" : vValDef.toString();
    window.status = "Obteniendo información del servidor...";
    PeticionAJAX(url, sDat, false);
    return false;
}

function Salir(strRuta) {
    var sID = Math.round(Math.random() * 10000000000);
    var winX = screen.availWidth;
    var winY = screen.availHeight;
    sID = "E" + sID;
    window.open(strRuta, sID, "menubar=yes,toolbar=yes,location=yes,directories=yes,status=yes,resizable=yes,scrollbars=yes,top=0,left=0,screenX=0,screenY=0,Width=" + winX + ",Height=" + winY);
    parent.window.close();
}

function DameFechaSQL(pDia, pMes, pAnio) {
    var sDia = '';
    var sMes = '';
    var sAnio = '';
    var sFecha = '';

    // Obtiene fecha
    sDia = CompletaCadena(pDia.toString());
    sMes = CompletaCadena(pMes.toString());
    sAnio = pAnio.toString();
    sFecha = (sAnio + sMes + sDia);

    // Si fecha vacía, NULL
    if (sFecha == "") {
        return "NULL";
    }

    // Si fecha incompleta, NULL
    if (sFecha.length < 8) {
        return "NULL";
    }

    // Devuelve resultado
    return (sAnio + sMes + sDia);
}
// Obtiene mes de la fecha
function ObtieneMesFecha(pIndex) {
    //pIndex = pIndex - 1
    if (pIndex.toString().length == 1) {
        return "0" + pIndex.toString();
    }
    else {
        return pIndex.toString();
    }
}


//Valida diferente tipo de campos para cajas de texto/numeros etc.
function Verificacion(Objeto, Tipo) {
    var LongitudValor = Objeto.value.length + 1
    var SubCadena = String.fromCharCode(window.event.keyCode).toUpperCase();
    // PARA ACENTOS
    if (window.event.keyCode == 180 ||
                      window.event.keyCode == 225 ||
                      window.event.keyCode == 233 ||
                      window.event.keyCode == 237 ||
                      window.event.keyCode == 243 ||
                      window.event.keyCode == 250 ||
                      window.event.keyCode == 193 ||
                      window.event.keyCode == 201 ||
                      window.event.keyCode == 205 ||
                      window.event.keyCode == 211 ||
                      window.event.keyCode == 218 ||
                      window.event.keyCode == 13) {
        window.event.keyCode = String.fromCharCode(window.event.keyCode).charCodeAt(0);
        return;
    }
    //aasdfasdf

    var Cadena = ""
    switch (Tipo) {
        case 1:  //Letras
            var cadStr = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ '
            break;
        case 2: //Números
            var cadStr = "0123456789"
            break;
        case 3:  //Letras y Números
            var cadStr = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '
            break;
        case 4:  //Decimales RCR
            var cadStr = '0123456789.'
            break;
        case 5:  //Hora
            var cadStr = '0123456789:'
            break;
        case 6:  //CURP y RFC
            var cadStr = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'
            break;
        case 7:  //Especial
            var cadStr = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ- '
            break;
        case 8:  //Telefono
            var cadStr = '0123456789-'
            break;
        case 9:  //Ffecha
            var cadStr = '0123456789/'
            break;
        case 10:  //DOMICILIO
            var cadStr = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ#. '
            break;
        case 11:  //NÚMEROS SIN CEROS
            var cadStr = '123456789'
            break;
        case 12: //CFG. 22-MAY-03 SOLO NÚMEROS O PALABRA 'ADMON' SOLO PARA AUTENTIFICACIÓN DE USUARIO
            var cadStr = '0123456789ADMON'
            break;
        case 13:  //OBSERVACIONES
            var cadStr = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ#.;-:,()/ %"$ÁÉÍÓÚáéíóú'
            break;
        case 14:  //Decimales RCR
            var cadStr = '0123456789.-'
            break;
        case 18:  //Dictamen
            var cadStr = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-/()'
            break;
        case 19:  //SOLO LECTURA
            var cadStr = ''
            break;
    }
    if (LongitudValor > 0) {
        for (i = 1; i <= cadStr.length; i++) {
            if ((cadStr.substring(i, i - 1) == SubCadena) || (window.event.keyCode == 209) || (window.event.keyCode == 241)) {
                Cadena = cadStr.substring(i, i - 1);
            }
        }
        if (Cadena.length == 0) {
            window.event.keyCode = 0
        }
        else {
            window.event.keyCode = String.fromCharCode(window.event.keyCode).toUpperCase().charCodeAt(0);
        }
        return;
    }
}


//valida el rfc con 4 letras 6 numeros 3 combinacion de ambos
function chkrfcpf(Objeto) {
    var LongitudValor = Objeto.value.length + 1
    var SubCadena = String.fromCharCode(window.event.keyCode).toUpperCase();
    var vcadena = Objeto.value

    if (LongitudValor > 0 && LongitudValor < 5) {
        Tipo = 1
    }
    else {
        if (LongitudValor < 11) {
            Tipo = 2
        }
        else {
            Tipo = 3;
        }

    }
    //validar las 4 primeras posiciones de texto
    var Cadena = ""
    switch (Tipo) {
        case 1:  //Letras
            var cadStr = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ '
            break;
        case 2: //Números
            var cadStr = "0123456789"
            break;
        case 3: //Números y letras
            var cadStr = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            break;

    }
    if (LongitudValor > 0) {
        for (i = 1; i <= cadStr.length; i++) {
            if ((cadStr.substring(i, i - 1) == SubCadena) || (window.event.keyCode == 209) || (window.event.keyCode == 241)) {
                Cadena = cadStr.substring(i, i - 1);
            }
        }
        if (Cadena.length == 0) {
            window.event.keyCode = 0
        }
        else {
            if (LongitudValor < 14) {
                window.event.keyCode = String.fromCharCode(window.event.keyCode).toUpperCase().charCodeAt(0);
            }
            else {
                window.event.keyCode = 0
            }
        }
        return;
    }
}

function valRFCPFPM(Objeto) {

    var LongitudValor = Objeto.value.length + 1
    var SubCadena = String.fromCharCode(window.event.keyCode).toUpperCase();
    var vcadena = Objeto.value


    var chkF = document.getElementById('chkFisica');
    var chkM = document.getElementById('chkMoral');
    //  var btn1 = rbtn.cells[0].innerHTML;
    // var btn2 = rbtn.cells[1].innerHTML

    //    if (btn1.search(/CHECKED/) == -1 && btn2.search(/CHECKED/) == -1) {
    //        alert("Seleccione el tipo de persona");
    //        Objeto.value = "";
    //        return false;
    //    }

    if (chkF.checked == false && chkM.checked == false) {
        alert("Seleccione el tipo de persona");
        Objeto.value = "";
        return false;
    }

    if (chkF.checked) {
        //Apartado Persona Fisica
        if (LongitudValor > 0 && LongitudValor < 5) {
            Tipo = 1
        }
        else {
            if (LongitudValor < 11) {
                Tipo = 2
            }
            else {
                Tipo = 3;
            }

        }
        //validar las 4 primeras posiciones de texto
        var Cadena = ""
        switch (Tipo) {
            case 1:  //Letras
                var cadStr = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
                break;
            case 2: //Números
                var cadStr = "0123456789"
                break;
            case 3: //Números y letras
                var cadStr = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                break;

        }
        if (LongitudValor > 0) {
            for (i = 1; i <= cadStr.length; i++) {
                if ((cadStr.substring(i, i - 1) == SubCadena) || (window.event.keyCode == 209) || (window.event.keyCode == 241)) {
                    Cadena = cadStr.substring(i, i - 1);
                }
            }
            if (Cadena.length == 0) {
                window.event.keyCode = 0
            }
            else {
                if (LongitudValor < 14) {
                    window.event.keyCode = String.fromCharCode(window.event.keyCode).toUpperCase().charCodeAt(0);
                }
                else {
                    window.event.keyCode = 0
                }
            }
            return;
        }
    }
    //Apartado Persona Moral
    else {
        if (LongitudValor > 0 && LongitudValor < 4) {
            Tipo = 1
        }
        else {
            if (LongitudValor < 10) {
                Tipo = 2
            }
            else {
                Tipo = 3;
            }

        }
        //validar las 4 primeras posiciones de texto
        var Cadena = ""
        switch (Tipo) {
            case 1:  //Letras
                var cadStr = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
                break;
            case 2: //Números
                var cadStr = "0123456789"
                break;
            case 3: //Números y letras
                var cadStr = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                break;

        }
        if (LongitudValor > 0) {
            for (i = 1; i <= cadStr.length; i++) {
                if ((cadStr.substring(i, i - 1) == SubCadena) || (window.event.keyCode == 209) || (window.event.keyCode == 241)) {
                    Cadena = cadStr.substring(i, i - 1);
                }
            }
            if (Cadena.length == 0) {
                window.event.keyCode = 0
            }
            else {
                if (LongitudValor < 14) {
                    window.event.keyCode = String.fromCharCode(window.event.keyCode).toUpperCase().charCodeAt(0);
                }
                else {
                    window.event.keyCode = 0
                }
            }
            return;
        }
    }

}
//valida el rfc persona moral con 3 letras 6 numeros 3 combinacion de ambos
function chkrfcpm(Objeto) {
    var LongitudValor = Objeto.value.length + 1
    var SubCadena = String.fromCharCode(window.event.keyCode).toUpperCase();
    var vcadena = Objeto.value

    if (LongitudValor > 0 && LongitudValor < 4) {
        Tipo = 1
    }
    else {
        if (LongitudValor < 10) {
            Tipo = 2
        }
        else {
            Tipo = 3;
        }

    }
    //validar las 4 primeras posiciones de texto
    var Cadena = ""
    switch (Tipo) {
        case 1:  //Letras
            var cadStr = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ '
            break;
        case 2: //Números
            var cadStr = "0123456789"
            break;
        case 3: //Números y letras
            var cadStr = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            break;

    }
    if (LongitudValor > 0) {
        for (i = 1; i <= cadStr.length; i++) {
            if ((cadStr.substring(i, i - 1) == SubCadena) || (window.event.keyCode == 209) || (window.event.keyCode == 241)) {
                Cadena = cadStr.substring(i, i - 1);
            }
        }
        if (Cadena.length == 0) {
            window.event.keyCode = 0
        }
        else {
            if (LongitudValor < 14) {
                window.event.keyCode = String.fromCharCode(window.event.keyCode).toUpperCase().charCodeAt(0);
            }
            else {
                window.event.keyCode = 0
            }
        }
        return;
    }
}



//valida el curp con 4 alfanumericos 6 numericos 6 alfa numericos 2 numericos
function validaCurp(Objeto) {
    var LongitudValor = Objeto.value.length + 1
    var SubCadena = String.fromCharCode(window.event.keyCode).toUpperCase();
    var vcadena = Objeto.value

    if (LongitudValor > 0 && LongitudValor < 5) {
        Tipo = 1
    }
    else {
        if (LongitudValor < 11) {
            Tipo = 2
        }
        else {
            if (LongitudValor < 17) {
                Tipo = 1;
            }
            else {
                Tipo = 2;
            }
        }

    }
    //validar las 4 primeras posiciones de texto
    var Cadena = ""
    switch (Tipo) {
        case 1:  //Letras
            var cadStr = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ '
            break;
        case 2: //Números
            var cadStr = "0123456789"
            break;
    }
    if (LongitudValor > 0) {
        for (i = 1; i <= cadStr.length; i++) {
            if ((cadStr.substring(i, i - 1) == SubCadena) || (window.event.keyCode == 209) || (window.event.keyCode == 241)) {
                Cadena = cadStr.substring(i, i - 1);
            }
        }
        if (Cadena.length == 0) {
            window.event.keyCode = 0
        }
        else {
            if (LongitudValor < 19) {
                window.event.keyCode = String.fromCharCode(window.event.keyCode).toUpperCase().charCodeAt(0);
            }
            else {
                window.event.keyCode = 0
            }
        }
        return;
    }
}

//Obtiene el id del registro seleccionado y hace un postBack al servidor dentyro de la busqueda inteligente
function IAmSelected(source, eventArgs) {
    document.getElementById('hdnValue').value = eventArgs.get_value();
    //window.alert(document.getElementById('ctl00_ContentPlaceHolderContenido_tabAsignacion_tabDatoSol_wucBusquedaIntelig_hdnValue').value);
    __doPostBack('hdnValue', '');

    //    document.getElementById('ctl00_ContentPlaceHolderContenido_tabAsignacion_tabDatoSol_wucBusquedaIntelig_hdnValue').value = eventArgs.get_value();
    //    //window.alert(document.getElementById('ctl00_ContentPlaceHolderContenido_tabAsignacion_tabDatoSol_wucBusquedaIntelig_hdnValue').value);
    //    __doPostBack('ctl00_ContentPlaceHolderContenido_tabAsignacion_tabDatoSol_wucBusquedaIntelig_hdnValue', '');

}

//Funcion que Envia mensaje de confirmacion y tambien ejecuta o cancela el proc eso en cuestion.

function Confirmacion(Texto) {
    //var seleccion = confirm("acepta el mensaje ?");
    var seleccion = confirm(Texto);
    return seleccion;
}

function ValidRFC(RFC) {

    var chkF = document.getElementById('chkFisica');
    var chkM = document.getElementById('chkMoral');

    RFC.value = RFC.value.replace(/ /g, "");

    if (RFC.value == "") {
        return;
    }

    var rfcStr = RFC.value;
    var strCorrecta

    if (chkF.checked) {
        if (rfcStr.length == 12) {
            strCorrecta = ' ' + rfcStr;
        }
        else {
            strCorrecta = rfcStr;
        }
        var validPF = '^(([A-Z]|[a-z]|\s){1})(([A-Z]|[a-z]){3})([0-9]{6})((([A-Z]|[a-z]|[0-9]){3}))';
        var validRfcPF = new RegExp(validPF);
        var matchArrayPF = strCorrecta.match(validRfcPF);
        if (matchArrayPF == null) {
            alert('El Formato del RFC para la persona Física\nno tiene el formato correcto');
            //  RFC.value = "";
            RFC.focus();
            return false;
        }
        else {
            return true;
        }

    }
    if (chkM.checked) {
        if (rfcStr.length == 11) {
            strCorrecta = ' ' + rfcStr;
        }
        else {
            strCorrecta = rfcStr;
        }
        var validPM = '^(([A-Z]|[a-z]|\s){1})(([A-Z]|[a-z]){2})([0-9]{6})((([A-Z]|[a-z]|[0-9]){3}))';
        var validRfcPM = new RegExp(validPM);
        var matchArrayPM = strCorrecta.match(validRfcPM);
        if (matchArrayPM == null) {
            alert('El Formato del RFC para la persona Moral\nno tiene el formato correcto');
            // RFC.value = "";
            RFC.focus();
            return false;
        }
        else {
            return true;
        }
    }
}

//Valia datos Obligaorios de l grid
function ValidaDatosGrid(gridID, arreglo) {
    var objGridView = c$(gridID);
    var totalRows = objGridView.rows.length - 1;
    var totalCols = objGridView.rows[0].cells.length;
    var j = 0;
    var x = 0;

    var colNoValidadas = arreglo;

    if (totalRows == 0) {
        alert('Debe Agregar Superficie de Terreno');
        return false;
    }

    //        alert('Rows=>' + totalRows);
    //        alert('Cols=>' + totalCols);

    //Recorre las Filas del Grid
    for (x = 1; x <= totalRows; x++)
    //Recorre las Columnas del Grid
        for (j = 1; j <= totalCols - 1; j++) {

            //Recupera el Texto de el Cabecero
            var txtHead = objGridView.rows[0].cells[j].outerText;
            //alert('j :' + j + ' =>' + ($.inArray(j, colNoValidadas)));
            if ($.inArray(j, colNoValidadas) < 0)
            //Verifica si es Nuemrico el dato
                if (!isNaN(parseFloat(objGridView.rows[x].cells[j].children[0].value))) {
                    //Verifica que el dato sea mayor a Cero
                    if (objGridView.rows[x].cells[j].children[0].value <= 0) {
                        alert('La Columna: ' + txtHead + '\n En la Fila ' + x + '\n Debe Ser Mayor que 0');
                        return false;
                    }
                } else {

                    //Verifica si esta vacia la celda
                    if (objGridView.rows[x].cells[j].children[0].value == "") {
                        alert('La Columna: ' + txtHead + '\n En la Fila ' + x + '\n Falta llenar el Dato');
                        return false;
                    }
                }

            }

            return true;
        }

        function TruncaDecimales(valor, decimales) {

            var strRes = String(valor);
            if (strRes.indexOf(".") == -1) {
                strRes += ".";
                for (var i = 0; i < decimales; i++) {
                    strRes += "0";
                }
            }
            strRes = strRes.substring(0, strRes.indexOf(".") + decimales + 1);
            
            return strRes;
        }

        function Longitud(text, minimo, max) {

            var cadena = text.value.trim();

            if (cadena.length < minimo) {

                alert("La cadena debe tener un minimo de: " + minimo + " caracteres");
                text.value = "";
            }
            if (cadena.length > max) {
                alert("La cadena debe tener un maximo de: " + max + " caracteres");
                text.value = "";
            }

            
        }
var nSegs;
function Cerrar() {
    var sID = Math.round(Math.random() * 10000000000);
    var winX = screen.availWidth;
    var winY = screen.availHeight;
    sID = "E" + sID;
    parent.window.close();
    /*if (window.opener) {
        window.location = "Salir.aspx";
    } else {*/
        window.open("frmLogin.aspx", sID, "menubar=yes,toolbar=yes,location=yes,directories=yes,status=yes,resizable=yes,scrollbars=yes,top=0,left=0,screenX=0,screenY=0,Width=" + winX + ",Height=" + winY);
    //}
}

function Cierra() {
    var oMsg = c$("MsgClose");
    var sMsg = '';
    if (nSegs == 0) {
        sMsg += 'La aplicaci&oacute;n se est&aacute; cerrando de forma autom&aacute;tica';
        oMsg.innerHTML = sMsg;
        setTimeout("Cerrar()", 750);
    } else {
        sMsg += 'La aplicaci&oacute;n se cerrar&aacute; de forma autom&aacute;tica en ' + nSegs + ' segundos';
        oMsg.innerHTML = sMsg;
        nSegs--;
        setTimeout("Cierra()", 1000);
    }
}

function VerOpener() {
    //alert(window.opener)
    /*if (window.opener) {
        window.location = "Salir.aspx"
        parent.window.close();
    } else {*/
    setTimeout('nSegs=5;Cierra()', 0);
    //}
}


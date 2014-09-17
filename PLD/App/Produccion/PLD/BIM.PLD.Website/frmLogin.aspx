<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmLogin.aspx.cs" Inherits="BIM.PLD.Website.frmLogin" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script language="javascript" type="text/javascript">
        function Redirecciona(strRuta)
        {
            var sID = Math.round(Math.random() * 10000000000);
            var winX = screen.availWidth;
            var winY = screen.availHeight;
            sID = "E" + sID;
            window.open(strRuta, sID,
                                        "menubar=yes,toolbar=yes,location=yes,directories=yes,status=yes,resizable=yes" + 
                                        ",scrollbars=yes,top=0,left=0,screenX=0,screenY=0,Width=" +
                                        winX + ",Height=" + winY);
            parent.window.close();
        }

        function Abre() {
            var features;
            var version;
            var width = window.screen.availWidth;
            var height = window.screen.availHeight;
            version = window.navigator.appVersion.substring(window.navigator.appVersion.indexOf('MSIE') + 5, window.navigator.appVersion.indexOf('MSIE') + 8);
            features = 'status=1, menubar=0, directories=0, resizable=1, scrollbars=0, left=0, top = 0, width=' + width + ', height=' + height;
            if (version == '6.0') {
                window.open('frmInicio.aspx', '', features);
                window.opener = '';
                window.close();
            }
            else if (version == '7.0') {
                window.open('frmInicio.aspx', '', features);
                window.open('', '_parent', '');
                window.close();
            }
            else if (version == '8.0') {
                window.open('frmInicio.aspx', '', features);
                window.open('', '_parent', '');
                window.close();
            }
            else if (version == '9.0') {
                window.open('frmInicio.aspx', '', features);
                window.open('', '_parent', '');
                window.close();
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>

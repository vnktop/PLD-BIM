<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="wucNotificacionMsj.ascx.cs"
    Inherits="Unival.UserControl.Comun.wucNotificacionMsj" %>
<%--    <link href="App_Themes/HCMTheme/notificationmsg.css" rel="stylesheet" type="text/css" />--%>
<div>
    <div id="centerdiv" style="display: inline; text-align: center">
        <asp:UpdatePanel ID="updBtn" runat="server">
            <ContentTemplate>
              <%--  <asp:Button ID="bnnPrueb" Text="prueb" runat="server" OnClick="btnPrueb_Onclick" />--%>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <%--    <div id="msg1" style="z-index: 100000 !important;">
        <div id="modal1">
            <div id="mdlTop" class="modaltop">
                <div class="modaltitle">
                    MENSAJE</div>
                <span id="closebutton" style="cursor: hand">
                    <img id="imgClose" alt="Hide Popup" src="" border="0" />
                </span>
            </div>
            <div class="modalbody">
                You received <a href=""><strong><span id="modalbody"></span></strong></a>&nbsp;Email(s).
            </div>
        </div>
    </div>--%>
</div>

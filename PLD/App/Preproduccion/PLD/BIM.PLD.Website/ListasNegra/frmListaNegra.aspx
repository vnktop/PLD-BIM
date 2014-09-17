<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="frmListaNegra.aspx.cs" Inherits="BIM.PLD.Website.ListasNegra.frmListaNegra" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AjaxToolkit" %>
<%@ Register Src="~/UserControl/Comun/Mensaje.ascx" TagName="wucMensajeSistema" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        #upnFileUpLoad
        {
            width: 200px;
            height: 100px;
            border: 1px solid gray;
        }
        #UpdateProgress1
        {
            width: 200px;
            background-color: #FFC080;
            bottom: 0%;
            left: 0px;
            position: absolute;
        }
        .style4
        {
            width: 222px;
        }
        .style5
        {
            width: 14px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
    <uc1:wucMensajeSistema ID="wucMensajeSistema" runat="server" />
    <asp:Panel ID="pnlBusquedaLPD" runat="server" HorizontalAlign="Center">
        <asp:UpdatePanel ID="upnFileUpLoad" runat="server">
            <ContentTemplate>
                <table class="Tabla" width="35%">
                    <tr>
                        <td colspan="4" class="Titulo" align ="center">
                            MOTOR DE CARGA- PLD
                        </td>
                    </tr>
                    <tr>
                        <td class="TD" align="right">
                            <asp:Label ID="lblArchivoDesc" runat="server" Text="Archivo:" CssClass="Label"></asp:Label>
                        </td>
                        <td class="style4">
                            <asp:FileUpload ID="fupArchivo" runat="server" />
                        </td>
                        <td class="style5">
                            
                        </td>
                    </tr>
                    <tr>
                    <td align = "right">
                            <asp:Label ID="lblProveedor" runat="server" Text="Proveedor:" CssClass="Label"></asp:Label>
                            
                        </td>
                        <td align ="left" class="style4">
                            <asp:DropDownList ID = "ddlProveedores" runat="server">
                                <asp:ListItem Text="[Seleccione el proveedor...]" Value="0"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:Label ID="Error" runat="server" Text="*" Style="display:none;" ForeColor="Red" ></asp:Label>
                        </td>
                        <td class="style5">
                        
                            <%--<asp:RequiredFieldValidator
                                        ID="rfvddlProveedores" runat="server" Text="*"
                                        ForeColor="Red" ControlToValidate="ddlProveedores" InitialValue="0"
                                        ErrorMessage="- Selecciona el proveedor." Display="Dynamic"
                                        ValidationGroup="gpvValidacionListas">
                            </asp:RequiredFieldValidator>--%>
                        </td>
                        <td>
                            <asp:ImageButton   id="iBtnAddProveedor" runat="server"
                                               AlternateText="ImageButton 1"
                                               ImageAlign="left"
                                               ImageUrl="../Images/add.png"
                                               OnClick="iBtnAddProveedor_Click" Height="19px"
                                               ToolTip="Agregar proveedor" 
                                Width="17px"/>
                        </td>                        
                    </tr>

                    <tr>
                        <td></td>
                        <td align = "right" class="style4">
                            <asp:Button ID="btnCargarArchivo" runat="server" CausesValidation="true" 
                                CssClass="Boton" OnClick="btnCargarArchivo_Click" 
                                OnClientClick="ShowProgress();" Text="Subir Archivo" 
                                Width="124px" />
                        </td>
                        <td colspan="1" class="style5">
                            &nbsp;</tr>                    
                </table>
                <asp:HiddenField ID="hdnFile" runat="server" />
    <asp:Button ID="btnShowPopUp_AgregarProveedor" runat="server" Style="display:none; " />
    <AjaxToolkit:ModalPopupExtender ID="mpeAgregarProveedor" runat="server"
        TargetControlID="btnShowPopUp_AgregarProveedor"
        PopupControlID="pnlPopupAgregarProveedor"
        PopupDragHandleControlID="pnlAgregarProveedor"
        BackgroundCssClass="modalBackground"
        CancelControlID="btnCancelarAgregar"
        Drag="false"
        DynamicServicePath="" Enabled="true">
    </AjaxToolkit:ModalPopupExtender>       
                    
    <asp:Panel ID="pnlPopupAgregarProveedor" runat="server" Width="320px" HorizontalAlign="Center" Style="display:inline; ">
        <asp:Panel ID="pnlAgregarProveedor" runat="server" BackColor="White" Width="100%">               
            <table class="Tabla" width="100%">
                <tr>                           
                    <td class="Titulo" colspan="3">
                        <center>
                            Agregar Proveedor
                        </center>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="center">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <asp:Label ID="lblNombreProveedor" text="Nombre Proveedor: " runat="server" CssClass="Label"></asp:Label>
                        <asp:TextBox ID="txtProveedor" runat="server" CssClass="textbox" 
                            Width="300px" Height="24px"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="rfvtxtProveedor" runat="server" 
                                                    ControlToValidate="txtProveedor" Display="Dynamic" 
                                                    ErrorMessage="Capturar Nombre Proveedor" InitialValue="" 
                                                    SetFocusOnError="True" Text="*" ToolTip="Capturar Nombre de Proveedor" 
                                                    ValidationGroup="AgregarValidation" />
                    </td>
                </tr>

                <tr>
                    <td align="left">
                        <asp:Button ID="btnCancelarAgregar" runat="server" Text="Cancelar" CssClass="Boton" CausesValidation="false" /> 
                    </td>

                    <td></td>
                    <td align="right">
                        <asp:Button ID="btnAceptarAgregar" runat="server" Text="Aceptar" CssClass="Boton" CommandName="6" CausesValidation="true" ValidationGroup="AgregarValidation" OnClick="btnAceptarAgregar_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </asp:Panel>

    </ContentTemplate>
        <Triggers>                
            <asp:PostBackTrigger ControlID="btnCargarArchivo" />
            <asp:PostBackTrigger ControlID="ddlProveedores" />
        </Triggers>                    
    </asp:UpdatePanel>        
    </asp:Panel>

    <br />
    <br />
    &nbsp;<%-- <AjaxToolkit:UpdatePanelAnimationExtender BehaviorID="animation2" TargetControlID="upnFileUpLoad" ID="UpdatePanelAnimationExtender1" runat="server">
    <Animations>
    
    </Animations>
   
    
    </AjaxToolkit:UpdatePanelAnimationExtender>--%><%--<asp:UpdatePanel ID="upnDetallesListaNegra" runat="server">
        <ContentTemplate>--%>
    <%--        </ContentTemplate>
    </asp:UpdatePanel>--%>
    <script language="javascript" type="text/javascript">
<!--
        //var prm = Sys.WebForms.PageRequestManager.getInstance();
        function MuestraCargando() {
            /**/
            document.getElementById('imLoading').visibility = 'visible';
        }
        function OcultaCargando() {
            /**/
            document.getElementById('imLoading').visibility = 'hidden;'
        }

        function leeNombreArchivo(File) {
            document.getElementById('<%=hdnFile.ClientID%>').value = File.value;
        }



        var prm = Sys.WebForms.PageRequestManager.getInstance();
        function CancelAsyncPostBack() {
            if (prm.get_isInAsyncPostBack()) {
                prm.abortPostBack();
            }
        }

        function alerta() {
            
           document.getElementById('imLoading').style.display = 'inline';
        }
        function ShowProgress() 
        {
                document.getElementById('ctl00_UpdateProgress1').style.display = "inline";
        }
        

    </script>
</asp:Content>

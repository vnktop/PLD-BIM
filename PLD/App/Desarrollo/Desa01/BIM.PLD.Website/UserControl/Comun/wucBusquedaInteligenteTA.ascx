<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="wucBusquedaInteligenteTA.ascx.cs" 
    Inherits="BIM.PLD.Website.UserControl.Comun.wucBusquedaInteligenteTA" %>

<%@ Register Src="~/UserControl/Comun/Mensaje.ascx" TagName="wucMensaje" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<style type="text/css">
.select  
{    
border:         1px solid #ccc;
padding:        6px 4px;
outline:        none;       
margin:         0;   
display:        block;
background:     #fff;  
font-family:    Tahoma, Helvetica, sans-serif;
font-size:      11px;
font-style:     normal;
font-weight:    bold;
color:          #006847;
}  
</style> 
<style type="text/css">
    .style1
    {
        width: 5%;
    }
    .style2
    {
        width: 20%;
    }
</style>
<style type="text/css">
        .AutoExtender
        {
            font-family: Verdana, Helvetica, sans-serif;
            font-size: .8em;
            font-weight: normal;
            border: solid 1px #006699;
            line-height: 20px;
            padding: 10px;
            background-color: White;
            margin-left:10px;
            text-align: left;
        }
        .AutoExtenderList
        {
            border-bottom: dotted 1px #006699;
            cursor: pointer;
            color: Maroon;
            background-color: #FFF4C8;
        }
        .AutoExtenderHighlight
        {
            color: White;
            background-color: #006699;
            cursor: pointer;
        }
        #divwidth
        {
          width: 680px !important;    
        }
        #divwidth div
       {
        width: 680px !important;   
       }
       .Watermark
        {
            width: 100%;
            margin: 5px;
            color: Gray;
            text-align: center; 
        }
 </style>  
<script type="text/javascript">
    // Work around browser behavior of "auto-submitting" simple forms
    var frm = document.getElementById("aspnetForm");
    if (frm) {
        frm.onsubmit = function () { return true; };
    }
    //Obtiene el id del registro seleccionado y hace un postBack al servidor dentyro de la busqueda inteligente
    function IAmSelected(source, eventArgs) {
        document.getElementById('hdnValue').value = eventArgs.get_value();
        __doPostBack('hdnValue', '');
    }
</script>
<asp:UpdatePanel ID="upMain" runat="server">
    <ContentTemplate>
<uc1:wucMensaje ID="wucMensajeSistema" runat="server" />
<table width="100%">
    <tr>
        <td class="style1">
        </td>
        <td align="right" class="style2">
            <asp:Label ID="lblBusqueda" runat="server" Text="Busqueda:" BackColor="" CssClass="Label"></asp:Label>
        </td>
        <td align="left">
            <asp:HiddenField ID="hdnValue" OnValueChanged="hdnValue_ValueChanged" runat="server" />
            <asp:DropDownList ID="ddlCatTipoListaNegra" runat="server" CssClass="select"></asp:DropDownList>
        </td>
        <td>
            <asp:RequiredFieldValidator ID="rfvddlCatTipoListaNegra" runat="server" ControlToValidate="ddlCatTipoListaNegra" ErrorMessage="seleccionar valor de tipo tipificación" InitialValue="0" Text="*"></asp:RequiredFieldValidator>                       
        </td>
       <td>
        <asp:UpdatePanel ID="upEdicioAgregar" runat="server">
            <ContentTemplate>
                <table>
                    <tr>
                        <td>
                            <asp:ImageButton ID="ibtEditar" runat="server" ImageUrl="~/App_Images/edit.gif" 
                                BackColor="Transparent" Width="16px" Height="16px" ToolTip="EDITAR" 
                                ValidationGroup="EscenarioEdicion" onclick="ibtEditar_Click"/>
                        </td>                            
                        <td>
                            <asp:ImageButton ID="ibAgregar" runat="server" 
                                ImageUrl="~/App_Images/AddRecord.png" BackColor="Transparent" 
                                CausesValidation="false" Width="16px" Height="16px" ToolTip="AGREGAR" 
                                onclick="ibAgregar_Click"/>
                        </td>
                        <%--<td>
                            <asp:RequiredFieldValidator ID="rfvddlBusquedaTipoAccion" runat="server" ControlToValidate="ddlBusquedaTipoAccion" Display="Dynamic" ErrorMessage="SELECCIONAR ITEM PARA EDICIÓN" InitialValue="-1" ValidationGroup="EscenarioEdicion" TEXT="SELECCIONAR ITEM PARA EDICIÓN"></asp:RequiredFieldValidator>
                        </td>--%>
                        </tr>
                </table>
            </ContentTemplate>                                   
        </asp:UpdatePanel> 
        </td>
    </tr>
</table>

<asp:UpdatePanel ID="upPanelRegistro" runat="server">
    <ContentTemplate>
                
    <asp:Button ID="btnShowPopUp_EditarAgregarRegistro" runat="server" Style="display:none; " />
    <AjaxToolkit:ModalPopupExtender ID="mpeEditarAgregarRegistro" runat="server"
        TargetControlID="btnShowPopUp_EditarAgregarRegistro"
        PopupControlID="pnlPopupEditarAgregarRegistro"
        PopupDragHandleControlID="pnlEditarAgregarRegistro"
        BackgroundCssClass="modalBackground"
        CancelControlID="btnCancelar"
        Drag="false"
        DynamicServicePath="" Enabled="true">
    </AjaxToolkit:ModalPopupExtender>                                   
    <asp:Panel ID="pnlPopupEditarAgregarRegistro" runat="server" Width="320px" HorizontalAlign="Center" Style="display:none; ">
        <asp:Panel ID="pnlEditarAgregarRegistro" runat="server" BackColor="White" Width="100%">               
            <table class="Tabla" width="100%">
                <tr>                           
                    <td class="Titulo" colspan="3">
                        <center>
                            REGISTRO TIPO TIPIFICACIÓN
                        </center>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbTitIdTipoTipificación" runat="server" CssClass="Label" Text="ID TIPO TIPIFICACIÓN"></asp:Label>                        
                    </td>
                    <td>
                        <asp:Label ID="lbTitTipoTipificacion" runat="server" CssClass="Label" Text="TIPO TIPIFICACIÓN"></asp:Label>
                    </td>                  
                </tr>
                <tr>
                    <td align="center">
                        <asp:Label ID="lbIdTipoTipificacionValor" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tbTipoTipificacionValor" runat="server" Width="150px" ValidationGroup="AgregarEditar"></asp:TextBox>
                    </td>
                </tr>
                <tr>                      
                    <td align="left">
                        <asp:RequiredFieldValidator ID="rfvtbRegistroTipoAccion" runat="server" Display="Dynamic" ControlToValidate="tbTipoTipificacionValor" Text="INGRESAR REGISTRO" ValidationGroup="AgregarEditar"></asp:RequiredFieldValidator>
                    </td>
                    <td align="left">
                        <%--<asp:RequiredFieldValidator ID="rfvtbIDCNBV" runat="server" Display="Dynamic" ControlToValidate="tbIDCNBV" Text="INGRESAR CLAVE" ValidationGroup="AgregarEditar"></asp:RequiredFieldValidator>--%>
                    </td>
                </tr>
                <tr>
                    <td align="left"> 
                        <asp:Button ID="btnAceptarAccion" runat="server" CssClass="Boton" OnClick="accion" ValidationGroup="AgregarEditar" />
                    </td>                           
                    <td align="right">
                        <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="Boton" CausesValidation="false" />
                    </td>         
                </tr>
            </table>
        </asp:Panel>
    </asp:Panel>    
    </ContentTemplate>     
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="ibtEditar" />
    </Triggers> 
</asp:UpdatePanel>
</ContentTemplate>
</asp:UpdatePanel>
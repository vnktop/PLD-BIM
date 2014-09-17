<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="frmAcciones.aspx.cs" Inherits="BIM.PLD.Website.Configurador.frmAcciones" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register TagPrefix="hcm" TagName="cMensajes" Src="~/UserControl/Comun/Mensaje.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">   
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
<style type="text/css">.customCalloutStyle div, .customCalloutStyle td{border: solid 1px Black;background-color: #9C2052;font-family: Arial;font-size: 11px;font-weight:bold;color:White;}</style>
<script type="text/javascript">
     function soloNumeros(e) {

         var unicode = e.charCode ? e.charCode : e.keyCode
         if (unicode < 48 || unicode > 57) {
             return false
         }
     }
     function soloNumerosDecimal(e) {
         var unicode = e.charCode ? e.charCode : e.keyCode
         if (unicode < 46 || unicode > 57) {
             if (unicode = 47) {
                 return false
             }
             return false
         }
     }
     function CountCharactersControlTxtMe(obj) {
         var lbl = document.getElementById('<%=lblContadorMe.ClientID%>');
         cant = obj.value.length;
         lbl.innerHTML = cant + " de [100]";
     }

</script>   
<style type="text/css">
    div#AdjResultsDiv
    {
        width: expression((screen.width-30));
        height: expression((screen.height/2.55));
        overflow: scroll;
        position: relative;
    }
        
    div#AdjResultsDiv th
    {
        top: expression(document.getElementById("AdjResultsDiv").scrollTop-2);
        left: expression(parentNode.parentNode.parentNode.parentNode.scrollLeft);
        position: relative;
        z-index: 999999;
    }
        
        
    div#div-datagrid
    {
        width: 420px;
        height: 200px;
        overflow: auto;
        scrollbar-base-color: #ffeaff;
    }
        
    /* Locks the left column */
        
    td.locked
    {
        font-size: 7pt;
        text-align: left;
        background-color: inherit;
        color: Black;
        position: relative;
        cursor: default;
        left: expression(document.getElementById("AdjResultsDiv").scrollLeft-2); /*IE5+ only*/
    }
        
        
        
    /* Keeps the header as the top most item. Important for top left item*/
        
    th.locked
    {
        z-index: 99;
    }
        
        
    /* DataGrid Item and AlternatingItem Style*/
        
    .GridRow
    {
        font-size: 7pt;
        color: black;
        font-family: Verdana;
        background-color: #ffffff;
        height: 15px;
    }
        
    .GridAltRow
    {
        font-size: 7pt;
        color: black;
        font-family: Verdana;
        background-color: #eeeeee;
        height: 15px;
    }
</style>  
<style type="text/css">
        div#AdjResultsDivCorreos
        {
            width: expression((screen.width-800));
            height: expression((screen.height/5));
            overflow: scroll;
            position: relative;
        }
        
        div#AdjResultsDivCorreos th
        {
            top: expression(document.getElementById("AdjResultsDivCorreos").scrollTop-2);
            left: expression(parentNode.parentNode.parentNode.parentNode.scrollLeft);
            position: relative;
            z-index: 999999;
        }
        
        
        div#div-datagrid
        {
            width: 420px;
            height: 200px;
            overflow: auto;
            scrollbar-base-color: #ffeaff;
        }
        
        /* Locks the left column */
        
        td.locked
        {
            font-size: 7pt;
            text-align: left;
            background-color: inherit;
            color: Black;
            position: relative;
            cursor: default;
            left: expression(document.getElementById("AdjResultsDivCorreos").scrollLeft-2); /*IE5+ only*/
        }
        
        
        
        /* Keeps the header as the top most item. Important for top left item*/
        
        th.locked
        {
            z-index: 99;
        }
        
        
        /* DataGrid Item and AlternatingItem Style*/
        
        .GridRow
        {
            font-size: 7pt;
            color: black;
            font-family: Verdana;
            background-color: #ffffff;
            height: 15px;
        }
        
        .GridAltRow
        {
            font-size: 7pt;
            color: black;
            font-family: Verdana;
            background-color: #eeeeee;
            height: 15px;
        }
    </style>    
 <style type="text/css">
        body
        {
            font-family: Arial;
            font-size: 10pt;
        }
        .Grid td
        {
            background-color: #A1DCF2;
            color: black;
            font-size: 10pt;
            line-height:200%
        }
        .Grid th
        {
            background-color: #3AC0F2;
            color: White;
            font-size: 10pt;
            line-height:200%
        }
        .ChildGrid td
        {
            background-color: #eee !important;
            color: black;
            font-size: 10pt;
            line-height:200%
        }
        .ChildGrid th
        {
            background-color: #6C6C6C !important;
            color: White;
            font-size: 10pt;
            line-height:200%
        }
    </style>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>    
<script type="text/javascript">
        $("[src*=plus]").live("click", function () {
            $(this).closest("tr").after("<tr><td></td><td colspan = '999'>" + $(this).next().html() + "</td></tr>")
            $(this).attr("src", "../App_Images/minus.png");
        });
        $("[src*=minus]").live("click", function () {
            $(this).attr("src", "../App_Images/plus.png");
            $(this).closest("tr").next().remove();
        });
    </script>              
<script src="../JavaScript/JQuery/jquery-1.6.2.min.js" type="text/javascript"></script>
<script src="../JavaScript/JQuery/jquery-ui.js" type="text/javascript"></script>
<script src="../JavaScript/JQuery/ui.core.js" type="text/javascript"></script>
<link href="../Styles/sliding-panel.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript">
    $(document).ready(function () {
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
        function EndRequestHandler() {
        }
        $(".trigger").click(function () {
            $(".panel").toggle("fast");
            $(this).toggleClass("active");                            
            return false;
        });
    });
    function OcultarPanel() {  
        if ($("#ddlTipoSistema option:selected").text() == 0 || $("#ddlTipoLista option:selected").text() == 0) {         
            return false;           
        }      
    }       
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderContenido" runat="server">
    <asp:UpdatePanel ID="upJquery" runat="server">
    <ContentTemplate>
    <center>
        <asp:Label ID="lblTitulo" runat="server" Text="Configuración de acciones para PLD"
            ForeColor="#006600" Font-Size="Large"></asp:Label>
    </center>        
    <div class="panel">
            <h3>
               CONFIGURACIÓN APLICACIONES PLD
            </h3>
            <div class="content" style="width:425px; text-align:center;">
            <center>
                <table>
                    <tr>
                        <td colspan="3" style="text-align: center" width="49%px">
                            <asp:Label ID="lblTitTipoSistema" runat="server" CssClass="Label" Text="TIPO DE SISTEMA" 
                                Width="100%"></asp:Label>
                        </td>
                        <td width="2%">
                            &nbsp;</td>
                        <td colspan="3" style="text-align: center" width="49%">
                            <asp:Label ID="lblTitTipoLista" runat="server" CssClass="Label" 
                                Text="TIPO DE LISTA" Width="100%"></asp:Label>                            
                        </td>
                    </tr>
                    <tr>
                        <td width="47%">
                            <asp:DropDownList ID="ddlTipoSistema" runat="server" CssClass="select" Width="100%">
                            </asp:DropDownList>
                        </td>
                        <td width="1%">
                            <asp:RequiredFieldValidator ID="rfvddlTipoSistema" runat="server" 
                                ControlToValidate="ddlTipoSistema" Display="Dynamic" 
                                ErrorMessage="Seleccionar tipo de sistema" InitialValue="0" 
                                SetFocusOnError="True" Text="*" ToolTip="Seleccionar tipo de sistema"></asp:RequiredFieldValidator>
                        </td>
                        <td width="1%">
                            &nbsp;</td>
                        <td width="2%">
                            &nbsp;</td>
                        <td width="47%">
                            <asp:DropDownList ID="ddlTipoLista" runat="server" CssClass="select" Width="100%">                                
                            </asp:DropDownList>
                        </td>
                        <td width="1%">
                            <asp:RequiredFieldValidator ID="rfvddlTipoLista" runat="server" 
                                ControlToValidate="ddlTipoLista" Display="Dynamic" 
                                ErrorMessage="Seleccionar tipo de lista" InitialValue="0" SetFocusOnError="True" 
                                Text="*" ToolTip="Seleccionar tipo de lista"></asp:RequiredFieldValidator>
                        </td>
                        <td width="1%">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="7" width="100%">                
                            <table width="100%">
                                <tr>
                                    <td width="50%" style="text-align: left">
                                        <%--<asp:Button ID="btnBuscarMB" runat="server" CssClass="Boton" Text="BUSCAR" CommandName="2" OnClick="menu" CausesValidation="false" />--%>
                                    </td>
                                    <td width="50%" style="text-align: right">
                                        <asp:Button ID="btnAccionMB" runat="server" OnClick="menu" CssClass="Boton" Text="CONFIGURAR" CommandName="BUSCAR" OnClientClick="OcultarPanel();" />
                                    </td>
                                </tr>
                            </table>                
                        </td>                   
                    </tr>
                </table>
            </center>                          
            </div>
        </div>


</ContentTemplate>
</asp:UpdatePanel>

<a class="trigger" href="#">BUSQUEDA</a>

<asp:UpdatePanel ID="upMain" runat="server">
    <ContentTemplate>
        <div>
            <hcm:cMensajes ID="cMensajes" runat="server" />
        </div>
               
        <asp:Panel ID="pResultadoMotorBusqueda" runat="server" >

        <div style="margin-bottom: 10px;">  
            <div style="border: dashed 1px #222222;">        
                <div id="up_container" > 

            <asp:UpdatePanel ID="upResultadoMotorBusqueda" runat="server">
            <ContentTemplate> 
                
            <%--<div id="background" style="text-align: center; vertical-align: middle; height: 380; padding: 12px; overflow: auto;">--%>                                                       
            <%--<div id="AdjResultsDiv"> --%>         
            <%--<div id="AdjResultsDiv" style="text-align: center; vertical-align: middle; line-height: 44px; height: 380; padding: 12px;  overflow: auto;">                        --%>
            <center>
            <asp:GridView ID="gvResultadoMotorBusqueda" runat="server" AutoGenerateColumns="false"
                AllowSorting="false" PageSize="5" AllowPaging="true"  
                OnRowDataBound="gvResultadoMotorBusqueda_OnRowDataBound"   
                OnPageIndexChanging="gvResultadoMotorBusqueda_OnPageIndexChanging"          
                EmptyDataText="NO EXISTEN REGISTROS">
                <Columns>     
                        <asp:TemplateField>
                            <ItemTemplate>
                                <img alt = "" style="cursor: pointer" src="../App_Images/plus.png" />
                                <asp:Panel ID="pnlDetalles" runat="server" Style="display: none">                                       
                                    <asp:GridView ID="gvBusquedaSistema" runat="server" AutoGenerateColumns="false" OnRowDataBound="gvBusquedaSistema_OnRowDataBound"                                          
                                        OnRowCommand="gvBusquedaSistema_OnRowCommand" DataKeyNames="intTipoTipificacionID, sintSistemaID">                                        
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <%# Convert.ToInt32(DataBinder.Eval(Container, "DataItemIndex")) + 1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>                                                             
                                            <asp:TemplateField HeaderText="TIPO DE LISTA">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblgvTipoLista" runat="server" Text='<%# Bind("vchIdentificadorInterno") %>'></asp:Label>                                                    
                                                </ItemTemplate>                   
                                            </asp:TemplateField>                    
                                            <asp:TemplateField HeaderText="BLOQUEO USUARIO">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblgvBloqueoUsuario" runat="server" Text='<%# Bind("vchbitBloqueoUsuario") %>'></asp:Label>   
                                                </ItemTemplate>                   
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="BLOQUEO PROCESO">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblgvBloqueoProceso" runat="server" Text='<%# Bind("vchbitBloqueoProceso") %>'></asp:Label>   
                                                </ItemTemplate>                   
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="ENVIO CORREO" ControlStyle-Width="100">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblgvEnvioCorreo" runat="server" Text='<%# Bind("vchbitEnvioCorreo") %>' ></asp:Label>
                                                </ItemTemplate>                   
                                            </asp:TemplateField>   
                                                <asp:TemplateField HeaderText="CREAR BITÁCORA" ControlStyle-Width="100">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblgvCrearBitacora" runat="server" Text='<%# Bind("vchbitBitacora") %>' ></asp:Label>
                                                </ItemTemplate>                   
                                            </asp:TemplateField>   
                                            <asp:TemplateField HeaderText="MENSAJE">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblgvMensaje" runat="server" Text="[...]" ToolTip='<%# Bind("vchMensaje") %>'></asp:Label>   
                                                </ItemTemplate>                   
                                            </asp:TemplateField>
                
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="ibtEditar" runat="server" ImageUrl="~/App_Images/edit.gif"
                                                        BackColor="Transparent" CausesValidation="false" Width="16px" Height="16px"
                                                        CommandName="ACTUALIZAR" CommandArgument='<%# Bind("intTipoTipificacionID" %> + "," + <%# Bind("sintSistemaID") %>' ToolTip="EDITAR"/>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:ImageButton style="display:none;" ID="ibtEliminar" runat="server" ImageUrl="../Images/delete.png"
                                                        BackColor="Transparent" CausesValidation="false" Width="16px" Height="16px"
                                                        CommandName="ELIMINAR" CommandArgument='<%# Eval("intTipoTipificacionID") + "," + Eval("sintSistemaID") %>' ToolTip="ELIMINAR"/>
                                                </ItemTemplate>
                                            </asp:TemplateField>                    
                                        </Columns>
                                        <AlternatingRowStyle CssClass="alternatingrowstyle" />
                                            <HeaderStyle CssClass="headerstyle" />
                                            <RowStyle CssClass="rowstyle" />                                                                                                           
                                        </asp:GridView>                                                                                                                                            
                                    </asp:Panel>
                                </ItemTemplate>
                        </asp:TemplateField>
                            <asp:TemplateField HeaderText="TIPO DE SISTEMA">
                            <ItemTemplate>
                                <asp:Label ID="lblgvTipoSistema" runat="server" Text='<%# Bind("vchNombreSistema") %>'></asp:Label>   
                            </ItemTemplate>                   
                        </asp:TemplateField>  
                        </Columns>
                <PagerTemplate>
                    <asp:Label ID="lbTemplate" runat="server" Text="Muestra Filas: " CssClass="Label">
                    </asp:Label>
                    <asp:DropDownList ID="dlBandeja" runat="server" AutoPostBack="true" CausesValidation="false"
                        Enabled="true" OnSelectedIndexChanged="ddlBandeja_SelectedIndexChanged">
                        <asp:ListItem Value="5" />
                        <asp:ListItem Value="10" />
                        <asp:ListItem Value="15" />
                        <asp:ListItem Value="20" />
                        <asp:ListItem Value="25" />
                    </asp:DropDownList>
                    &nbsp; Página
                    <asp:TextBox ID="txtBandeja" runat="server" AutoPostBack="true" OnTextChanged="txtBandeja_TextChanged"
                        Width="40" MaxLength="10">
                    </asp:TextBox>
                    de
                    <asp:Label ID="lbBandejaTotal" runat="server" />
                    &nbsp;
                    <asp:Button ID="btnBandeja_I" runat="server" CommandName="Page" CausesValidation="false"
                        ToolTip="Pagina Anterior" CommandArgument="Prev" CssClass="previous" />
                    <asp:Button ID="btnBandeja_II" runat="server" CommandName="Page" CausesValidation="false"
                        ToolTip="Pagina Siguiente" CommandArgument="Next" CssClass="next" />
                </PagerTemplate> 
                <AlternatingRowStyle CssClass="alternatingrowstyle" />
                <HeaderStyle CssClass="headerstyle" />
                <RowStyle CssClass="rowstyle" />
            </asp:GridView>
            </center>
            <%-- </div>--%>             
            </ContentTemplate>
            <%--<Triggers >
                <asp:AsyncPostBackTrigger ControlID="btnBuscarMB" EventName="click" />
            </Triggers>--%>
            </asp:UpdatePanel> 
                
                </div>
            </div>
        </div>
               
        </asp:Panel>

        <asp:Button ID="btnShowPopUp_AccionRegistro" runat="server" Style="display:none; " />
        <AjaxToolkit:ModalPopupExtender ID="mpeAccionRegistro" runat="server"
            TargetControlID="btnShowPopUp_AccionRegistro"
            PopupControlID="pnlPopupAccionRegistro"
            PopupDragHandleControlID="pnlAccionRegistro"
            BackgroundCssClass="modalBackground"
            CancelControlID="btnCancelarAccion"
            Drag="false"
            DynamicServicePath="" Enabled="true">
        </AjaxToolkit:ModalPopupExtender>       
                    
        <asp:Panel ID="pnlPopupAccionRegistro" runat="server" Width="400px" HorizontalAlign="Center" Style="display:none;">
            <asp:Panel ID="pnlAccionRegistro" runat="server" BackColor="White" Width="100%">               
                <table class="Tabla" width="100%">
                    <tr>                           
                        <td class="Titulo" colspan="2">
                            <center>
                                CONFIGURACIÓN PLD
                            </center>
                        </td>
                    </tr>
                    <tr>                       
                        <td align="right">
                            <asp:Label ID="lbTitTipoSistema" runat="server" CssClass="Label" Text="TIPO SISTEMA"></asp:Label>
                        </td>
                        <td align="left">
                            <asp:Label ID="lbTipoSistemaPanelValor" runat="server" CssClass="Label"></asp:Label>
                        </td>     
                    </tr>
                    <tr>                                
                        <td align="right">
                            <asp:Label ID="lbTitTipoLista" runat="server" CssClass="Label" Text="TIPO LISTA"></asp:Label>
                        </td>
                        <td align="left">
                            <asp:Label ID="lbTipoListaPanelValor" runat="server" CssClass="Label"></asp:Label>
                        </td>                               
                    </tr>
                    <tr>
                        <td style="text-align: right" width="40%">
                            <asp:Label ID="lblTitBloqueoUsuario" runat="server" CssClass="Label" 
                                Text="BLOQUEO USUARIO" Width="100%"></asp:Label>
                        </td>                        
                        <td style="text-align: left" width="60%">
                            <table>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="cbBloqueousuario" runat="server" 
                                                />
                                    </td>
                                    <td>
                                    
                                    </td>                                    
                                </tr>                               
                            </table>                            
                        </td>                        
                    </tr>
                    <tr>
                        <td style="text-align: right" width="40%">
                            <asp:Label ID="Label1" runat="server" CssClass="Label" 
                                Text="BLOQUEO PROCESO" Width="100%"></asp:Label>
                        </td>                        
                        <td style="text-align: left" width="60%">
                            <table>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="cbBloqueoProceso" runat="server" 
                                                />
                                    </td>
                                    <td>
                                    
                                    </td>                                    
                                </tr>                               
                            </table>                            
                        </td>                        
                    </tr>
                    <tr>
                        <td style="text-align: right" width="40%">
                            <asp:Label ID="lblTitEnvioCorreo" runat="server" CssClass="Label" 
                                Text="ENVIAR CORREO" Width="100%"></asp:Label>
                        </td>                        
                        <td style="text-align: left" width="60%">
                            <table>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="cbBloqueoCorreo" runat="server" OnCheckedChanged="mostrarPanel" AutoPostBack="true"/>                                                 
                                    </td>
                                    <td>
                                        <asp:ImageButton ID="ibtEditarCorreos" runat="server" ImageUrl="~/App_Images/edit.gif"
                                            BackColor="Transparent" CausesValidation="false" Width="16px" Height="16px"
                                            ToolTip="EDITAR CORREOS" OnClick="mostrarPanelCorreosEdicion"/>
                                    </td>
                                </tr>
                            </table>                            
                        </td>      
                    </tr>
                    <tr>
                        <td style="text-align: right" width="40%">
                            <asp:Label ID="lblTitBitacora" runat="server" CssClass="Label" 
                                Text="CREAR BITÁCORA" Width="100%"></asp:Label>
                        </td>                        
                        <td style="text-align: left" width="60%">
                            <table>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="cbCrearBitacora" runat="server" 
                                                />
                                    </td>
                                    <td>
                                    
                                    </td>                                    
                                </tr>                               
                            </table>                            
                        </td>          
                    </tr>
                    <tr>
                        <td style="text-align: right" width="40%">
                            <asp:Label ID="lblTitMensaje" runat="server" CssClass="Label" 
                                Text="MENSAJE" Width="100%"></asp:Label>
                        </td>                        
                        <td style="text-align: left" width="60%">
                            <table>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="tbMensaje" runat="server" MaxLength="100" Width="220" TextMode="MultiLine" Height="80" CssClass="textbox"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblContadorMe" runat="server" ForeColor="Red" Text="0 de [100]"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            
                        </td>    
                    </tr>
                    <tr>                  
                        <td colspan="2">
                            <table width="400px">
                                <tr>
                                    <td align="left" width="50%"> 
                                        <asp:Button ID="btnAccion" runat="server" CssClass="Boton" OnClick="menu" CausesValidation="false" />
                                    </td>                        
                                    <td align="right" width="50%">
                                        <asp:Button ID="btnCancelarAccion" runat="server" Text="Cancelar" 
                                            CssClass="Boton" CausesValidation="false" 
                                            />
                                    </td>   
                                </tr>
                            </table>
                        </td>                             
                    </tr>
                </table>
            </asp:Panel>
        </asp:Panel>  
               

        <asp:UpdatePanel ID="upAsignarCorreo" runat="server">
        <ContentTemplate>                     
        <asp:Button ID="btnShowPopUp_AsignacionCorreo" runat="server" Style="display:none; " />
        <AjaxToolkit:ModalPopupExtender ID="mpeAsignacionCorreo" runat="server"
            TargetControlID="btnShowPopUp_AsignacionCorreo"
            PopupControlID="pnlPopupAsignacionCorreo"
            PopupDragHandleControlID="pnlAsignacionCorreo"
            BackgroundCssClass="modalBackground"
          
            Drag="false"
            DynamicServicePath="" Enabled="true">
        </AjaxToolkit:ModalPopupExtender>                                                
        <asp:Panel ID="pnlPopupAsignacionCorreo" runat="server" Width="800px" HorizontalAlign="Center" Style="display:none;">
            <asp:Panel ID="pnlAsignacionCorreo" runat="server" BackColor="White" Width="100%">               
                <table class="Tabla" width="100%">
                    <tr>                           
                        <td class="Titulo" colspan="1">
                            <center>
                                CONFIGURACIÓN CUENTAS DE CORREO
                            </center>
                        </td>
                    </tr>
                
                    <tr>                               
                        <td style="text-align: left" width="80%">
                            <table>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="tbCorreoPara" runat="server" MaxLength="256" Width="1" ValidationGroup="asignarCorreo" CssClass="textbox" Visible="false"></asp:TextBox>
                                        <table width="100%">                  
                                            <tr>
                                                <td>
                                                    <asp:Panel ID="pnlCollapseBusqueda" runat="server" CssClass="collapsePanel" HorizontalAlign="Center"
                                                        Style="overflow: hidden;">
                                                        <asp:UpdatePanel runat="server" UpdateMode="Conditional" ID="UPD_Correo">
                                                            <ContentTemplate>
                                                                <div id="AdjResultsDivCorreos" class="Tabla" style="text-align: center; vertical-align: middle; overflow: auto;">      
                                                                <asp:GridView ID="grdContact" runat="server" AutoGenerateColumns="False" 
                                                                    OnRowCancelingEdit="grdContact_RowCancelingEdit" OnRowDataBound="grdContact_RowDataBound"
                                                                    CssClass="tablestyle" OnRowEditing="grdContact_RowEditing" OnRowUpdating="grdContact_RowUpdating"
                                                                    OnRowCommand="grdContact_RowCommand"  ShowHeader="true" OnRowDeleting="grdContact_RowDeleting">
                                                                    <AlternatingRowStyle CssClass="alternatingrowstyle" />
                                                                    <HeaderStyle CssClass="headerstyle" />
                                                                    <RowStyle CssClass="rowstyle" />
                                                                    <Columns>
                                                                        <asp:TemplateField>
                                                                            <HeaderTemplate>
                                                                                <asp:Label ID="lbHeader" runat="server" Text="CORREO"></asp:Label>
                                                                            </HeaderTemplate>
                                                                            <ItemTemplate>
                                                                                <%# Convert.ToInt32(DataBinder.Eval(Container, "DataItemIndex")) + 1 %></ItemTemplate>
                                                                            <ItemStyle Font-Size="X-Small" HorizontalAlign="Center" Width="15px" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField>
                                                                                <ItemTemplate>
                                                                                <asp:Label ID="lbTipoCorreo" runat="server" Text='<%# Bind("strTipoCorreo") %>'></asp:Label>
                                                                            </ItemTemplate>  
                                                                            <HeaderTemplate>
                                                                                    <table>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:RadioButton ID="cbTO" runat="server" Checked="true" Text="PARA" GroupName="tipoCorreo" BorderColor="Transparent" BorderWidth="0" BorderStyle="None" />
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:RadioButton ID="cbCC" runat="server" Text="CC" GroupName="tipoCorreo" BorderColor="Transparent" BorderWidth="0" BorderStyle="None" />
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </HeaderTemplate>
                                                                            <EditItemTemplate>
                                                                                <table>
                                                                                    <tr>         
                                                                                        <td>
                                                                                            <asp:RadioButton ID="cbTOEdit" runat="server" Text="PARA" GroupName="tipoCorreo" BorderColor="Transparent" BorderWidth="0" BorderStyle="None"  />
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:RadioButton ID="cbCCEdit" runat="server" Text="CC" GroupName="tipoCorreo" BorderColor="Transparent" BorderWidth="0" BorderStyle="None"/>
                                                                                        </td>  
                                                                                    </tr>
                                                                                </table>   
                                                                            </EditItemTemplate>     
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Correo" HeaderStyle-HorizontalAlign="Left">
                                                                            <EditItemTemplate>
                                                                                <table>
                                                                                    <tr>                                                                                                                                                                     
                                                                                        <td>
                                                                                            <asp:TextBox ID="txtCorreo" runat="server" Text='<%# Bind("strCorreo") %>' Width="200px" MaxLength="100"></asp:TextBox>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:RegularExpressionValidator ID="regexEmailValid" ValidationGroup="correo" runat="server"
                                                                                                ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtCorreo"
                                                                                                ErrorMessage="Formato Incorrecto"></asp:RegularExpressionValidator>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:RequiredFieldValidator ID="rfv_txtCorreo" runat="server" ErrorMessage="<b>Correo Invalido</b><br />Dato obigatorio."
                                                                                                ControlToValidate="txtCorreo" Display="None" ValidationGroup="correo" InitialValue="" />
                                                                                        </td>
                                                                                        <td>
                                                                                        <asp:RegularExpressionValidator runat="server" ID="revtxtCorreo"
                                                                                            ControlToValidate="txtCorreo"
                                                                                            ValidationExpression="^[\s\S]{0,100}$"
                                                                                            ErrorMessage="Correo no mauor a 100 caracteres"
                                                                                            ValidationGroup="correo"
                                                                                            Display="Dynamic">*</asp:RegularExpressionValidator>
                                                                                        </td>
                                                                                        <td>
                                                                                            <AjaxToolkit:ValidatorCalloutExtender ID="vce_txtCorreo" runat="server" Enabled="True"
                                                                                                TargetControlID="rfv_txtCorreo" CssClass="customCalloutStyle" PopupPosition="BottomRight"/>                                                                                            
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:HiddenField ID="hdnID" runat="server" Value='<%# Bind("strCorreo") %>' />
                                                                                            <asp:HiddenField ID="hdTipo" runat="server" Value='<%# Bind("strTipoCorreo") %>' />
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>                                                                                
                                                                            </EditItemTemplate>
                                                                            <HeaderTemplate>
                                                                                <table>
                                                                                    <tr>                                                                                       
                                                                                        <td>
                                                                                            <asp:TextBox ID="txtNewCorreo" runat="server" Width="200px" MaxLength="100"></asp:TextBox>        
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:RegularExpressionValidator ID="regexEmailValid1" ValidationGroup="correoAdd"
                                                                                                runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                                                                ControlToValidate="txtNewCorreo" ErrorMessage="Formato Incorrecto"></asp:RegularExpressionValidator>        
                                                                                        </td>
                                                                                        <td>
                                                                                                <asp:RequiredFieldValidator ID="rfv_txtNewCorreo" runat="server" ErrorMessage="<b>Correo Invalido</b><br />Dato obigatorio."
                                                                                                ControlToValidate="txtNewCorreo" Display="None" ValidationGroup="correoAdd" InitialValue="" />
                                                                                        </td>
                                                                                        <td>
                                                                                                <asp:RegularExpressionValidator runat="server" ID="revtxtNewCorreo"
                                                                                                ControlToValidate="txtNewCorreo"
                                                                                                ValidationExpression="^[\s\S]{0,100}$"
                                                                                                ErrorMessage="Correo no mayor a 100 caracteres"
                                                                                                ValidationGroup="correoAdd"
                                                                                                Display="Dynamic">*</asp:RegularExpressionValidator>
                                                                                        </td>
                                                                                        <td>
                                                                                            <AjaxToolkit:ValidatorCalloutExtender ID="vce_txtNewCorreo" runat="server" Enabled="True"
                                                                                                TargetControlID="rfv_txtNewCorreo" CssClass="customCalloutStyle" PopupPosition="BottomRight"/>        
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </HeaderTemplate>                                                                                                                                                  
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblCorreo" runat="server" Text='<%# Bind("strCorreo") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Editar" ShowHeader="False" HeaderStyle-HorizontalAlign="Left">
                                                                            <EditItemTemplate>
                                                                                <asp:LinkButton ID="lbkUpdate" runat="server" ValidationGroup="correo" CommandName="Update"
                                                                                    Text="Actualizar"></asp:LinkButton>
                                                                                <asp:LinkButton ID="lnkCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                                    Text="Cancelar"></asp:LinkButton>
                                                                            </EditItemTemplate>                                                                                                                                         
                                                                            <HeaderTemplate>
                                                                                <asp:LinkButton ID="lnkAdd" runat="server" ValidationGroup="correoAdd" CommandName="Insert"
                                                                                    Text="Agregar" ></asp:LinkButton>
                                                                            </HeaderTemplate>
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="lnkEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                                                                    Text="Editar"></asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:CommandField  ShowDeleteButton="True" />
                                                                    </Columns>
                                                                </asp:GridView>
                                                                <asp:Label ID="lbMensajesCorreo" runat="server" ForeColor="Red"></asp:Label>
                                                                </div>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator ID="rfvtbCorreoPara" runat="server" ControlToValidate="tbCorreoPara" Text="*" ToolTip="ASIGNAR CORREO PARA" ValidationGroup="asignarCorreo"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="revtbCorreoPara" runat="server" ControlToValidate="tbCorreoPara" ErrorMessage="*" ToolTip="verificar entrada de correo" SetFocusOnError="true" ValidationGroup="asignarCorreo" ValidationExpression="^(\w([-_+.']*\w+)+@(\w(-*\w+)+\.)+[a-zA-Z]{2,4}[,;])*\w([-_+.']*\w+)+@(\w(-*\w+)+\.)+[a-zA-Z]{2,4}$"></asp:RegularExpressionValidator>

                                    </td>
                                </tr>                               
                            </table>                                                       
                        </td>                        
                    </tr>                               
                    <tr>                  
                        <td colspan="1">
                            <table width="100%">
                                <tr>
                                    <td align="left" width="50%"> 
                                        <asp:Button ID="btnAceptarCorreo" runat="server" Text="Aceptar" CssClass="Boton" CausesValidation="true" ValidationGroup="asignarCorreo" OnClick="mantenerPanel" />
                                    </td>                        
                                    <td align="right" width="50%">
                                        <asp:Button ID="btnCancelarCorreo" runat="server" Text="Cancelar" CssClass="Boton" CausesValidation="false" OnClick="mantenerPanelUncheck"/>
                                    </td>   
                                </tr>
                            </table>
                        </td>                             
                    </tr>
                </table>
            </asp:Panel>
        </asp:Panel>  
            </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="cbBloqueoCorreo" />
        </Triggers>
    </asp:UpdatePanel>              
    
    <asp:Button ID="btnShowPopUp_EliminarRegistro" runat="server" Style="display:none; " />
    <AjaxToolkit:ModalPopupExtender ID="mpeEliminarRegistro" runat="server"
        TargetControlID="btnShowPopUp_EliminarRegistro"
        PopupControlID="pnlPopupEliminarRegistro"
        PopupDragHandleControlID="pnlEliminarRegistro"
        BackgroundCssClass="modalBackground"
        CancelControlID="btnCancelarEliminar"
        Drag="false"
        DynamicServicePath="" Enabled="true">
    </AjaxToolkit:ModalPopupExtender>       
                    
    <asp:Panel ID="pnlPopupEliminarRegistro" runat="server" Width="320px" HorizontalAlign="Center" Style="display:none; ">
        <asp:Panel ID="pnlEliminarRegistro" runat="server" BackColor="White" Width="100%">               
            <table class="Tabla" width="100%">
                <tr>                           
                    <td class="Titulo" colspan="3">
                        <center>
                            CONFIGURACIÓN PLD
                        </center>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="center">
                        <asp:Label ID="lblMensajeEliminarRegsitro" runat="server" CssClass="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="left"> 
                        <asp:Button ID="btnAceptarEliminar" runat="server" Text="Aceptar" CssClass="Boton" OnClick="menu" CommandName="ELIMINAR" CausesValidation="false" />
                    </td>
                    <td></td>
                    <td align="right">
                        <asp:Button ID="btnCancelarEliminar" runat="server" Text="Cancelar" CssClass="Boton" CausesValidation="false" />
                    </td>         
                </tr>
            </table>
        </asp:Panel>
    </asp:Panel>      
                  
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true" ShowSummary="false" HeaderText="Existen campos faltantes en la captura." DisplayMode="List"  />        
   
    </ContentTemplate>
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="btnAccionMB" />
    </Triggers>
</asp:UpdatePanel>
</asp:Content>

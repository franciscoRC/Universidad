<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/UniMasterOne.Master" CodeBehind="frmUniversidadEdit.aspx.vb" Inherits="UniversidadWeb.frmUniversidadEdit" %>

<%@ Register Assembly="DevExpress.Web.v18.1, Version=18.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<%--<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>--%>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">




    <%-- Contenedor principal --%>
    <div class="container-fluid">


        <%-- Titulos/encabezados --%>
        <div class="row">
            <div class="col-md-2 offset-md-10">
                <%-- Etiqueta para indicar Alta/Edicion --%>
                <h5 class="text-center text-primary" id="lblABC" runat="server">[Alta]
                </h5>
            </div>
            <div class="col-md-12">
                <%-- Titulo de esta opcion del sistema --%>
                <h3 class="text-center text-primary">Universidades
                </h3>
            </div>
        </div>

        <%--
             Inician los campos de Captura
        --%>

        <div class="col-md-12">

            <%--Todos los controles de captura se manejan dentro de un cntrol aspxPageControl (devexpress). Cuando es mucha informacion
                se usaran Pestañas para agrupar los campos relacionados --%>
            <dx:ASPxPageControl CssClass="tabla-adaptable text-info" ID="pgCtrlPrincipal" runat="server"
                ActiveTabIndex="0" Width="100%" ClientInstanceName="pgCtrlPrincipal">

                <%--Inician las paginas (pestañas)--%>
                <TabPages>
                    <dx:TabPage Name="Generales" Text="Generales">
                        <ContentCollection>
                            <dx:ContentControl runat="server">

                                <%--Div principal que contiene todos los controles de esta pestaña--%>

                                <div class="row">
                                    <div class="form-group col-md-12">
                                        <label class="text-info" for="txtNombre">Nombre</label>
                                        <dx:ASPxTextBox CssClass="form-control" ID="txtNombre" runat="server" MaxLength="200" Width="100%">
                                        </dx:ASPxTextBox>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label class="text-info" runat="server" for="txtDomicilio1">Calle/Numero:</label>
                                        <dx:ASPxTextBox CssClass="form-control" ID="txtDomicilio1" runat="server" MaxLength="100" Width="100%">
                                        </dx:ASPxTextBox>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label class="text-info" for="txtDomicio2">Colonia:</label>
                                        <dx:ASPxTextBox CssClass="form-control" ID="txtDomicilio2" runat="server" MaxLength="100" Width="100%">
                                        </dx:ASPxTextBox>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label class="text-info" for="txtDomicilio3">Ciudad/Edo/CP:</label>
                                        <dx:ASPxTextBox CssClass="form-control" ID="txtDomicilio3" runat="server" MaxLength="100" Width="100%">
                                        </dx:ASPxTextBox>
                                    </div>
                                </div>

                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:TabPage>
                </TabPages>

            </dx:ASPxPageControl>

        </div>

    </div>

    <br />

    <div class="col-md-12">

        <%-- LINEA DIVISION PARA BOTONS DE ACCION --%>
        <hr />


        <%-- ERRORES DE VALIDACION --%>
        <div class="row">
            <div class="col-md-12">
                <h4>
                    <asp:Label CssClass="text-warning" ID="lblErroresValidacion" runat="server" Text="Errores..."></asp:Label>
                </h4>
            </div>

        </div>
        <%-- FIN - ERRORES DE VALIDACION --%>


        <%-- BOTONES DE ACCION: GRABAR/CANCELAR --%>
        <div class="col-md-12">
            <div class="form-group col-md-3 offset-md-9 text-center">
                <asp:Button CssClass="btn btn-primary" ID="btnGrabar" runat="server" Text="Grabar" />
                <asp:Button CssClass="btn btn-warning" ID="btnCancelar" runat="server" Text="Cancelar" />
            </div>
        </div>
        <br />
    </div>


    <%-- SECCION:  ORIGENES DE DATOS DE CAPTURA (Altas, Bajas, Cambios, Consultas) --%>


    <%-- SECCION:  ORIGENES DE DATOS SOLO DE CONSULTA (TABLAS CON LLAVES FORANEAS) --%>
</asp:Content>


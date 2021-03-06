﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/UniMasterOne.Master" CodeBehind="frmCicloList.aspx.vb" Inherits="UniversidadWeb.frmCicloList" %>
<%@ Register Assembly="DevExpress.Web.v18.1, Version=18.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <%-- Contenedor principal --%>
    <div class="container-fluid">
               
        <%-- Titulo/encabezado de la opcion --%>
        <div class="row">
            <div class="col-md-12">
                <h3 class="text-center text-primary">
                    Ciclos
                </h3>
            </div>
        </div>

        <div class="row">

            <div class="col-md-12">

                <%-- Se declara el nombre para el gridview, el origen de datos para A,B,C., nombre del campo llave primaria,
                                y los eventos que se manejan por codigo (updating, inserting, etc.)  --%>
                <dx:ASPxGridView CssClass="tabla-adaptable" ID="gvwCiclos" runat="server" Width="100%"
                    AutoGenerateColumns="False" DataSourceID="dsCiclos" KeyFieldName="ID">
                    <%-- los botones de accion se configuran como imagenes, se indica la ruta donde se encuentran --%>
                    <SettingsCommandButton>
                        <DeleteButton Image-Url="Images/Iconos/Eliminar.ico">
                        </DeleteButton>
                        <ClearFilterButton Image-Url="Images/Iconos/Vaciar.ico" Image-ToolTip="Quitar filtros">
                        </ClearFilterButton>
                    </SettingsCommandButton>
                    <%-- Seccion: columnas del gridview, la primer columna para acciones, es requisito que todas los campos de la tabla 
                                    tengan su correspcolumna y se escriban igual (con mayusc y minusculas) --%>
                    <Columns>
                        <%-- Propiedad: VisibleIndex indica el orden de izq a derecha   --%>
                        <%-- Propiedad: Visible indica si la columna es visible para el usuario--%>
                        <%-- Primer columna: para config botones habilitados, ancho de columna y tipo de botones (texto o imagenes)   --%>
                        <dx:GridViewCommandColumn ButtonType="Image" ShowNewButtonInHeader="false" ShowNewButton="False"
                            ShowEditButton="False" ShowDeleteButton="True" ShowClearFilterButton="true" Width="70" VisibleIndex="0">
                            <CustomButtons>
                                <dx:GridViewCommandColumnCustomButton ID="gvwCiclosInsertar" Image-ToolTip="Nuevo">
                                    <Image Url="Images/Iconos/Nuevo.ico"></Image>
                                </dx:GridViewCommandColumnCustomButton>
                                <dx:GridViewCommandColumnCustomButton ID="gvwCiclosEditar" Image-ToolTip="Editar">
                                    <Image Url="Images/Iconos/Editar.ico"></Image>
                                </dx:GridViewCommandColumnCustomButton>
                            </CustomButtons>
                        </dx:GridViewCommandColumn>
                        <%-- Columna para llave principal: Siempre va al principio, readonly y es NO visible --%>
                        <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="1" Visible="false">
                        </dx:GridViewDataTextColumn>
                        <%-- Inician todas las demás columnas de la tabla --%>
                        
                        <dx:GridViewDataTextColumn FieldName="Nombre" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="FechaIni" VisibleIndex="5" PropertiesDateEdit-DisplayFormatString="dd/MM/yy" Width="75px">                            
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataDateColumn FieldName="FechaFin" VisibleIndex="7" PropertiesDateEdit-DisplayFormatString="dd/MM/yy" Width="75px">                            
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="Colegiatura" VisibleIndex="9" Width="85px">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataComboBoxColumn FieldName="CarreraID" Caption="Carrera" VisibleIndex="11"  Width="300px">
                                <PropertiesComboBox DataSourceID="dsCarreras" TextField="Nombre" ValueField="ID">
                                </PropertiesComboBox>
                        </dx:GridViewDataComboBoxColumn>
                        <%-- Campo que se usa para filtrar solo los registro de la sucursal  --%>
                        <%--<dx:GridViewDataTextColumn FieldName="UniID" VisibleIndex="11" Visible="False">
                        </dx:GridViewDataTextColumn>--%>
                     </Columns>
                    <Styles>
                        <%-- Estilos para elgridview alternancia de colores por fila --%>
                        <AlternatingRow Enabled="true" />
                    </Styles>
                    <%-- Permitimos que el usuario cambie elancho de las columnas--%>
                    <SettingsResizing ColumnResizeMode="NextColumn" />
                    <%-- Configuracion de la paginacion --%>
                    <SettingsPager Position="Bottom" PageSizeItemSettings-Visible="true">
                        <PageSizeItemSettings Items="10,25,50,100" />
                    </SettingsPager>
                    <%-- Cuando el usuario desee eliminar un registro, se le pedirá que confirme --%>
                    <%--Si el texto no cabe en la columna, se despliegan elipsis (puntos)--%>
                    <SettingsBehavior ConfirmDelete="true" AllowEllipsisInText="true" />
                    <%-- ShowGroupPanel: Mostrar barra de agrupacion de campos? --%>
                    <%-- ShowFilterRow: Mostrar barra para filtrar los registros? --%>
                    <%-- ShowFooter: Mostrar barra de Pie inferior? --%>
                    <%-- AutoFilterCondition: Como buscar las coincidencias de texto en el filtrado? --%>
                    <Settings ShowGroupPanel="True" ShowFilterRow="True" ShowFooter="True" AutoFilterCondition="Contains" />
                    <TotalSummary>
                        <%-- Total/Resumen que se muestra al Pie. Tipo:suma, conteo. Sobre que campo se aplica y el formato de despliegue  --%>
                        <%--<dx:ASPxSummaryItem FieldName="Nombre" SummaryType="Count" DisplayFormat="{0:###,###} elemento(s)"/>--%>
                    </TotalSummary>
                    <%-- ShowDetailRow: el gridview contiene otro gridview anidado? --%>
                    <%--<SettingsDetail ShowDetailRow="True" />--%>
                    <Templates>
                        <%-- Area Templates. Donde se programa el formulario de captura y donde anidan otros gridview (master-detail)  --%>

                        <EmptyDataRow>
                            <%--Seccion que se activa cuando no hay ningun registro a desplegar en el gridview--%>
                            <div class="row">

                                <div class="col-md-4 offset-md-4">
                                    <%--Se despliega el sig mensaje--%>
                                            Aun no se registran datos...
                                            <br />
                                    <%--Se despliega boton para insertar un registro--%>
                                    <dx:ASPxButton ID="btnInsertar" runat="server" Text="Agregar nuevo" OnClick="btnInsertar_Click" OnInit="btnInsertar_Init">
                                    </dx:ASPxButton>
                                </div>
                            </div>
                        </EmptyDataRow>
                    </Templates>
                </dx:ASPxGridView>
 
            </div>
        </div>
    </div><br />


    <%-- FIN Contenedor principal --%>

    <%-- SECCION:  ORIGENES DE DATOS DE CAPTURA (Altas, Bajas, Cambios, Consultas) --%>

    <%--Referencias--%>
    <asp:SqlDataSource ID="dsCiclos" runat="server" ConnectionString="<%$ ConnectionStrings:UniversidadConnectionString %>" OldValuesParameterFormatString="original_{0}"
        SelectCommand="SELECT [ID], [Nombre], [FechaIni], [FechaFin], [Colegiatura], [CarreraID] FROM [Ciclos] ORDER BY [Nombre] DESC"
        DeleteCommand="DELETE FROM [Ciclos] WHERE [ID] = @original_ID AND [Nombre] = @original_Nombre AND [FechaIni] = @original_FechaIni AND [FechaFin] = @original_FechaFin AND [Colegiatura] = @original_Colegiatura AND [CarreraID] = @original_CarreraID" ConflictDetection="CompareAllValues" InsertCommand="INSERT INTO [Ciclos] ([Nombre], [FechaIni], [FechaFin], [Colegiatura], [CarreraID]) VALUES (@Nombre, @FechaIni, @FechaFin, @Colegiatura, @CarreraID)" UpdateCommand="UPDATE [Ciclos] SET [Nombre] = @Nombre, [FechaIni] = @FechaIni, [FechaFin] = @FechaFin, [Colegiatura] = @Colegiatura, [CarreraID] = @CarreraID WHERE [ID] = @original_ID AND [Nombre] = @original_Nombre AND [FechaIni] = @original_FechaIni AND [FechaFin] = @original_FechaFin AND [Colegiatura] = @original_Colegiatura AND [CarreraID] = @original_CarreraID">
        <DeleteParameters>
            <asp:Parameter Name="original_ID" Type="Int32" />
            <asp:Parameter Name="original_Nombre" Type="String" />
            <asp:Parameter Name="original_FechaIni" DbType="Date" />
            <asp:Parameter Name="original_FechaFin" DbType="Date" />
            <asp:Parameter Name="original_Colegiatura" Type="Decimal" />
            <asp:Parameter Name="original_CarreraID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Nombre" Type="String" />
            <asp:Parameter Name="FechaIni" DbType="Date" />
            <asp:Parameter Name="FechaFin" DbType="Date" />
            <asp:Parameter Name="Colegiatura" Type="Decimal" />
            <asp:Parameter Name="CarreraID" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Nombre" Type="String" />
            <asp:Parameter Name="FechaIni" DbType="Date" />
            <asp:Parameter Name="FechaFin" DbType="Date" />
            <asp:Parameter Name="Colegiatura" Type="Decimal" />
            <asp:Parameter Name="CarreraID" Type="Int32" />
            <asp:Parameter Name="original_ID" Type="Int32" />
            <asp:Parameter Name="original_Nombre" Type="String" />
            <asp:Parameter Name="original_FechaIni" DbType="Date" />
            <asp:Parameter Name="original_FechaFin" DbType="Date" />
            <asp:Parameter Name="original_Colegiatura" Type="Decimal" />
            <asp:Parameter Name="original_CarreraID" Type="Int32" />
        </UpdateParameters>

    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsCarreras" runat="server" ConnectionString="<%$ ConnectionStrings:UniversidadConnectionString %>" SelectCommand="SELECT [ID], [Nombre] FROM [Carreras] ORDER BY [Nombre]"></asp:SqlDataSource>
    <%-- SECCION:  ORIGENES DE DATOS SOLO DE CONSULTA (TABLAS CON LLAVES FORANEAS) --%>
</asp:Content>

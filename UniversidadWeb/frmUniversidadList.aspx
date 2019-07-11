<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/UniMasterOne.Master" CodeBehind="frmUniversidadList.aspx.vb" Inherits="UniversidadWeb.frmUniversidadList" %>

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
                    Universidades
                </h3>
            </div>
        </div>

        <div class="row">

            <div class="col-md-12">

                <%-- Se declara el nombre para el gridview, el origen de datos para A,B,C., nombre del campo llave primaria,
                                y los eventos que se manejan por codigo (updating, inserting, etc.)  --%>
                <dx:ASPxGridView CssClass="tabla-adaptable" ID="gvwUniversidades" runat="server" Width="100%"
                    AutoGenerateColumns="False" DataSourceID="dsUniversidades" KeyFieldName="ID">
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
                                <dx:GridViewCommandColumnCustomButton ID="gvwUniversidadesInsertar" Image-ToolTip="Nuevo">
                                    <Image Url="Images/Iconos/Nuevo.ico"></Image>
                                </dx:GridViewCommandColumnCustomButton>
                                <dx:GridViewCommandColumnCustomButton ID="gvwUniversidadesEditar" Image-ToolTip="Editar">
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
                        <dx:GridViewDataTextColumn FieldName="Domicilio1" Caption="Calle/Num." VisibleIndex="5" Width="200px">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Domicilio2" Caption="Colonia" VisibleIndex="7" Width="150px">
                        </dx:GridViewDataTextColumn>
                         <dx:GridViewDataTextColumn FieldName="Domicilio3" Caption="Cd/Edo/CP" VisibleIndex="9" Width="150px">                            
                        </dx:GridViewDataTextColumn>
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
    <asp:SqlDataSource ID="dsUniversidades" runat="server" ConnectionString="<%$ ConnectionStrings:UniversidadConnectionString %>" OldValuesParameterFormatString="original_{0}"
        SelectCommand="SELECT [ID], [Nombre], [Domicilio1], [Domicilio2], [Domicilio3] FROM [Universidades] ORDER BY [Nombre] DESC"
        DeleteCommand="DELETE FROM [Universidades] WHERE [ID] = @original_ID AND [Nombre] = @original_Nombre AND (([Domicilio1] = @original_Domicilio1) OR ([Domicilio1] IS NULL AND @original_Domicilio1 IS NULL)) AND (([Domicilio2] = @original_Domicilio2) OR ([Domicilio2] IS NULL AND @original_Domicilio2 IS NULL)) AND (([Domicilio3] = @original_Domicilio3) OR ([Domicilio3] IS NULL AND @original_Domicilio3 IS NULL))" ConflictDetection="CompareAllValues" InsertCommand="INSERT INTO [Universidades] ([Nombre], [Domicilio1], [Domicilio2], [Domicilio3]) VALUES (@Nombre, @Domicilio1, @Domicilio2, @Domicilio3)" UpdateCommand="UPDATE [Universidades] SET [Nombre] = @Nombre, [Domicilio1] = @Domicilio1, [Domicilio2] = @Domicilio2, [Domicilio3] = @Domicilio3 WHERE [ID] = @original_ID AND [Nombre] = @original_Nombre AND (([Domicilio1] = @original_Domicilio1) OR ([Domicilio1] IS NULL AND @original_Domicilio1 IS NULL)) AND (([Domicilio2] = @original_Domicilio2) OR ([Domicilio2] IS NULL AND @original_Domicilio2 IS NULL)) AND (([Domicilio3] = @original_Domicilio3) OR ([Domicilio3] IS NULL AND @original_Domicilio3 IS NULL))">
        <DeleteParameters>
            <asp:Parameter Name="original_ID" Type="Int32" />
            <asp:Parameter Name="original_Nombre" Type="String" />
            <asp:Parameter Name="original_Domicilio1" Type="String" />
            <asp:Parameter Name="original_Domicilio2" Type="String" />
            <asp:Parameter Name="original_Domicilio3" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Nombre" Type="String" />
            <asp:Parameter Name="Domicilio1" Type="String" />
            <asp:Parameter Name="Domicilio2" Type="String" />
            <asp:Parameter Name="Domicilio3" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Nombre" Type="String" />
            <asp:Parameter Name="Domicilio1" Type="String" />
            <asp:Parameter Name="Domicilio2" Type="String" />
            <asp:Parameter Name="Domicilio3" Type="String" />
            <asp:Parameter Name="original_ID" Type="Int32" />
            <asp:Parameter Name="original_Nombre" Type="String" />
            <asp:Parameter Name="original_Domicilio1" Type="String" />
            <asp:Parameter Name="original_Domicilio2" Type="String" />
            <asp:Parameter Name="original_Domicilio3" Type="String" />
        </UpdateParameters>

    </asp:SqlDataSource>

    <%-- SECCION:  ORIGENES DE DATOS SOLO DE CONSULTA (TABLAS CON LLAVES FORANEAS) --%>

</asp:Content>


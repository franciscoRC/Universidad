<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/UniMasterOne.Master" CodeBehind="frmCalificacionList.aspx.vb" Inherits="UniversidadWeb.frmCalificacionList" %>
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
                    Calificaciones
                </h3>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <%-- Se declara el nombre para el gridview, el origen de datos para A,B,C., nombre del campo llave primaria,
                                y los eventos que se manejan por codigo (updating, inserting, etc.)  --%>
                <dx:ASPxGridView CssClass="tabla-adaptable" ID="gvwCalificacion" runat="server" Width="100%"
                    AutoGenerateColumns="False" DataSourceID="dsCalificaciones" KeyFieldName="ID">
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
                                <dx:GridViewCommandColumnCustomButton ID="gvwCalificacionInsertar" Image-ToolTip="Nuevo">
                                    <Image Url="Images/Iconos/Nuevo.ico"></Image>
                                </dx:GridViewCommandColumnCustomButton>
                                <dx:GridViewCommandColumnCustomButton ID="gvwCalificacionEditar" Image-ToolTip="Editar">
                                    <Image Url="Images/Iconos/Editar.ico"></Image>
                                </dx:GridViewCommandColumnCustomButton>
                            </CustomButtons>
                        </dx:GridViewCommandColumn>
                        <%-- Columna para llave principal: Siempre va al principio, readonly y es NO visible --%>
                        <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="1" Visible="false">
                        </dx:GridViewDataTextColumn>
                        <%-- Inician todas las demás columnas de la tabla --%>
                        
                        <dx:GridViewDataTextColumn FieldName="Cal1" Caption="Calificación 1:" VisibleIndex="3" Width="75px">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Cal2" Caption="Calificación 2:" VisibleIndex="5" Width="75px">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Cal3" Caption="Calificación 3:" VisibleIndex="7" Width="75px">
                        </dx:GridViewDataTextColumn>
                         <dx:GridViewDataTextColumn FieldName="Promedio"  VisibleIndex="9" Width="80px">                            
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataComboBoxColumn FieldName="GrupoAlumnoID" Caption="GrupoAlumno" VisibleIndex="11">
                        <PropertiesComboBox DataSourceID="dsGruposAlumnos" TextField="Estatus" ValueField="ID">
                        </PropertiesComboBox>
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataComboBoxColumn FieldName="MateriaID" Caption="Materia" VisibleIndex="13">
                        <PropertiesComboBox DataSourceID="dsMaterias" TextField="Nombre" ValueField="ID">
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

                                <div class="col-md-4 col-md-offset-4">
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
    <asp:SqlDataSource ID="dsCalificaciones" runat="server" ConnectionString="<%$ ConnectionStrings:UniversidadConnectionString %>" OldValuesParameterFormatString="original_{0}"
        SelectCommand="SELECT [ID], [Cal1], [Cal2], [Cal3], [Promedio], [GrupoAlumnoID], [MateriaID] FROM [Calificaciones] ORDER BY [ID]" ConflictDetection="CompareAllValues" DeleteCommand="DELETE FROM [Calificaciones] WHERE [ID] = @original_ID AND [Cal1] = @original_Cal1 AND [Cal2] = @original_Cal2 AND [Cal3] = @original_Cal3 AND [Promedio] = @original_Promedio AND [GrupoAlumnoID] = @original_GrupoAlumnoID AND [MateriaID] = @original_MateriaID" InsertCommand="INSERT INTO [Calificaciones] ([Cal1], [Cal2], [Cal3], [Promedio], [GrupoAlumnoID], [MateriaID]) VALUES (@Cal1, @Cal2, @Cal3, @Promedio, @GrupoAlumnoID, @MateriaID)" UpdateCommand="UPDATE [Calificaciones] SET [Cal1] = @Cal1, [Cal2] = @Cal2, [Cal3] = @Cal3, [Promedio] = @Promedio, [GrupoAlumnoID] = @GrupoAlumnoID, [MateriaID] = @MateriaID WHERE [ID] = @original_ID AND [Cal1] = @original_Cal1 AND [Cal2] = @original_Cal2 AND [Cal3] = @original_Cal3 AND [Promedio] = @original_Promedio AND [GrupoAlumnoID] = @original_GrupoAlumnoID AND [MateriaID] = @original_MateriaID">
        <DeleteParameters>
            <asp:Parameter Name="original_ID" Type="Int32" />
            <asp:Parameter Name="original_Cal1" Type="Double" />
            <asp:Parameter Name="original_Cal2" Type="Double" />
            <asp:Parameter Name="original_Cal3" Type="Double" />
            <asp:Parameter Name="original_Promedio" Type="Double" />
            <asp:Parameter Name="original_GrupoAlumnoID" Type="Int32" />
            <asp:Parameter Name="original_MateriaID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Cal1" Type="Double" />
            <asp:Parameter Name="Cal2" Type="Double" />
            <asp:Parameter Name="Cal3" Type="Double" />
            <asp:Parameter Name="Promedio" Type="Double" />
            <asp:Parameter Name="GrupoAlumnoID" Type="Int32" />
            <asp:Parameter Name="MateriaID" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Cal1" Type="Double" />
            <asp:Parameter Name="Cal2" Type="Double" />
            <asp:Parameter Name="Cal3" Type="Double" />
            <asp:Parameter Name="Promedio" Type="Double" />
            <asp:Parameter Name="GrupoAlumnoID" Type="Int32" />
            <asp:Parameter Name="MateriaID" Type="Int32" />
            <asp:Parameter Name="original_ID" Type="Int32" />
            <asp:Parameter Name="original_Cal1" Type="Double" />
            <asp:Parameter Name="original_Cal2" Type="Double" />
            <asp:Parameter Name="original_Cal3" Type="Double" />
            <asp:Parameter Name="original_Promedio" Type="Double" />
            <asp:Parameter Name="original_GrupoAlumnoID" Type="Int32" />
            <asp:Parameter Name="original_MateriaID" Type="Int32" />
        </UpdateParameters>

    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsGruposAlumnos" runat="server" ConnectionString="<%$ ConnectionStrings:UniversidadConnectionString %>" OldValuesParameterFormatString="original_{0}"
        SelectCommand="SELECT [ID], [Estatus] FROM [GruposAlumnos] ORDER BY [ID]">

    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsMaterias" runat="server" ConnectionString="<%$ ConnectionStrings:UniversidadConnectionString %>" OldValuesParameterFormatString="original_{0}"
        SelectCommand="SELECT [ID], [Nombre] FROM [Materias] ORDER BY [Nombre]">

    </asp:SqlDataSource>

    <%-- SECCION:  ORIGENES DE DATOS SOLO DE CONSULTA (TABLAS CON LLAVES FORANEAS) --%>

</asp:Content>

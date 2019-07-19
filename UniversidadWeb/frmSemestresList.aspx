<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/UniMasterOne.Master" CodeBehind="frmSemestresList.aspx.vb" Inherits="UniversidadWeb.frmSemestresList" %>

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
				    Semestres
			    </h3>
		    </div>

                <%-- GridView principal --%>
                <div class="tabla-adaptable">
            
                    <%-- Se declara el nombre para el gridview, el origen de datos para A,B,C., nombre del campo llave primaria,
                            y los eventos que se manejan por codigo (updating, inserting, etc.)  --%>
                    <dx:ASPxGridView CssClass="tabla-adaptable" ID="gvwSemestres" runat="server"  
                        AutoGenerateColumns="False" DataSourceID="dsSemestres" KeyFieldName="ID"
                        OnRowUpdating="gvwSemestres_RowUpdating" OnRowInserting="gvwSemestres_RowInserting">
                        <%-- los botones de accion se configuran como imagenes, se indica la ruta donde se encuentran --%>
                        <SettingsCommandButton>
                                <NewButton Image-Url="Images/Iconos/Nuevo.ico">
                                </NewButton>
                                <EditButton Image-Url="Images/Iconos/Editar.ico">
                                </EditButton>
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
                            <dx:GridViewCommandColumn ButtonType="Image" ShowNewButtonInHeader="False" ShowNewButton="true"  
                                ShowEditButton="True" ShowDeleteButton="True" ShowClearFilterButton="true" Width="80" VisibleIndex="0">
                            </dx:GridViewCommandColumn>
                            <%-- Columna para llave principal: Siempre va al principio, readonly y es NO visible --%>
                            <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="1" Visible="false">
                            </dx:GridViewDataTextColumn>
                            <%-- Inician todas las demás columnas de la tabla --%>
                            <dx:GridViewDataTextColumn FieldName="NombreSem" VisibleIndex="3">
                            </dx:GridViewDataTextColumn>
                             <dx:GridViewDataTextColumn FieldName="Clave" VisibleIndex="5">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataComboBoxColumn FieldName="CarreraID" Caption="Carrera" VisibleIndex="7">
                                <PropertiesComboBox DataSourceID="dsCarreras" TextField="Nombre" ValueField="ID">
                                </PropertiesComboBox>
                            </dx:GridViewDataComboBoxColumn>
                            <%-- Campo que se usa para filtrar solo los registro de la licencia  --%>
                            <%--<dx:GridViewDataTextColumn FieldName="CarreraID" Caption="Carrera" VisibleIndex="7" Visible="False">
                            </dx:GridViewDataTextColumn>--%>
                        </Columns>                    
                        <Styles>
                            <%-- Estilos para elgridview alternancia de colores por fila --%>
                            <AlternatingRow Enabled="true" />
                        </Styles>
                        <%-- Permitimos que el usuario cambie elancho de las columnas--%>
                        <SettingsResizing ColumnResizeMode="NextColumn"/>
                        <%-- Configuracion de la paginacion --%>
                        <SettingsPager Position="Bottom" PageSizeItemSettings-Visible="true">
                            <PageSizeItemSettings Items="10,25,50,100"/>
                        </SettingsPager>
                        <%-- Cuando el usuario desee eliminar un registro, se le pedirá que confirme --%>
                        <%--Si el texto no cabe en la columna, se despliegan elipsis (puntos)--%>
                        <SettingsBehavior ConfirmDelete="true" AllowEllipsisInText="true"/>
                        <%-- ShowGroupPanel: Mostrar barra de agrupacion de campos? --%>
                        <%-- ShowFilterRow: Mostrar barra para filtrar los registros? --%>
                        <%-- ShowFooter: Mostrar barra de Pie inferior? --%>
                        <%-- AutoFilterCondition: Como buscar las coincidencias de texto en el filtrado? --%>
                        <Settings ShowGroupPanel="true" ShowFilterRow="True" ShowFooter="true" AutoFilterCondition="Contains"/>
                        <TotalSummary>
                            <%-- Total/Resumen que se muestra al Pie. Tipo:suma, conteo. Sobre que campo se aplica y el formato de despliegue  --%>
                            <dx:ASPxSummaryItem FieldName="Nombre" SummaryType="Count" DisplayFormat="{0:n0} elemento(s)"/>
                        </TotalSummary>
                        <Templates>
                            <%-- Area Templates. Donde se programa el formulario de captura y donde anidan otros gridview (master-detail)  --%>

                            <EditForm>
                                <%-- Configuracion del formulario de Edicion que aparece dentro del GridView  --%>
                                <div style="padding: 4px 4px 3px 4px">

                                    <%--Siempre usamos un control Tab. Para clasificar en pesatañas cuando sean muchos campos --%>
                                    <dx:ASPxPageControl runat="server" ID="pageControl" Width="100%">
                                        <TabPages>
                                            <dx:TabPage Text="Generales" Visible="true">
                                                <%-- inicia pesataña  --%>
                                                <ContentCollection>
                                                    <dx:ContentControl ID="ContentControl1" runat="server">
                                                            
                                                        <%-- Controles de la pestaña  --%>
                                                        <%-- Text='<%# Eval("Nombre")%>' se usa para vincular un campo con un control  --%>

                                                        <div class="row">
                                                            <div class="form-group col-md-4">
                                                                * Nombre:
                                                                <dx:ASPxTextBox ID="txtNombre" runat="server" Width="100%" MaxLength="50" Text='<%# Eval("NombreSem")%>'>
                                                                </dx:ASPxTextBox>
                                                                <br />
                                                            </div>
                                                             <div class="form-group col-md-4">
                                                                * Clave Num:
                                                                <dx:ASPxTextBox ID="txtClave" runat="server" Width="100%" MaxLength="50" Text='<%# Eval("Clave")%>'>
                                                                </dx:ASPxTextBox>
                                                                <br />
                                                            </div>
                                                            <div class="form-group col-md-4" style="position:inherit;">
                                                                <dx:ASPxLabel ID="lblCarrera" for="cmbCarrera" runat="server" Text="Carrera:"></dx:ASPxLabel>
                                                                <%--El campo que se muestra se controla a traves de textField, El valor que se almacena en la BD se gestiona desde ValueField
                                                                El valor que se carga cuando se edita un registro se controla en la propiedad Value y se bindea a la variable del Gridview--%>
                                                                <dx:ASPxComboBox ID="cmbCarrera" runat="server" DataSourceID="dsCarreras" TextField="Nombre"
                                                                    ValueField="ID" ValueType="System.Int32" Width="100%" Value='<%# Bind("CarreraID")%>' ClientInstanceName="cmbCarrera">
                                                                </dx:ASPxComboBox>
                                                            </div>
                                                        </div>                                                        
                                                    </dx:ContentControl>
                                                </ContentCollection>
                                            </dx:TabPage>
                                        </TabPages>
                                    </dx:ASPxPageControl>
                                    <br />
                                    <div class="row">
                                        <%--Botones de accion: Grabar y Cancelar--%>
                                        <div class="col-md-4 offset-md-8 col-5 offset-7">
                                            <%--Se definen eventos para el control. Ejecutan codigo VB --%>
                                            <dx:ASPxButton ID="btnGrabar" runat="server" Text="Grabar" OnInit="btnGrabar_Init" OnClick="btnGrabar_Click"  Width="60px" Height="20px" >
                                            </dx:ASPxButton>
                                            <%--Se definen eventos para el control. Ejecutan codigo VB --%>
                                            <dx:ASPxButton ID="btnCancel" runat="server" Text="Cancelar" OnClick="btnCancel_Click" Width="60px" Height="20px" >
                                            </dx:ASPxButton>
                                        </div>
                                    </div>
                                </div>
                            </EditForm>

                        </Templates>
                    </dx:ASPxGridView>
                </div>
               
       
        </div>

    </div>
    <%-- FIN Contenedor principal --%>

    <asp:SqlDataSource ID="dsSemestres" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:UniversidadConnectionString %>" DeleteCommand="DELETE FROM [Semestres] WHERE [ID] = @original_ID AND [Clave] = @original_Clave AND [CarreraID] = @original_CarreraID AND [NombreSem] = @original_NombreSem" InsertCommand="INSERT INTO [Semestres] ([Clave], [CarreraID], [NombreSem]) VALUES (@Clave, @CarreraID, @NombreSem)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [ID], [Clave], [CarreraID], [NombreSem] FROM [Semestres] ORDER BY [NombreSem]" UpdateCommand="UPDATE [Semestres] SET [Clave] = @Clave, [CarreraID] = @CarreraID, [NombreSem] = @NombreSem WHERE [ID] = @original_ID AND [Clave] = @original_Clave AND [CarreraID] = @original_CarreraID AND [NombreSem] = @original_NombreSem">
        <DeleteParameters>
            <asp:Parameter Name="original_ID" Type="Int32" />
            <asp:Parameter Name="original_Clave" Type="Int32" />
            <asp:Parameter Name="original_CarreraID" Type="Int32" />
            <asp:Parameter Name="original_NombreSem" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Clave" Type="Int32" />
            <asp:Parameter Name="CarreraID" Type="Int32" />
            <asp:Parameter Name="NombreSem" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Clave" Type="Int32" />
            <asp:Parameter Name="CarreraID" Type="Int32" />
            <asp:Parameter Name="NombreSem" Type="String" />
            <asp:Parameter Name="original_ID" Type="Int32" />
            <asp:Parameter Name="original_Clave" Type="Int32" />
            <asp:Parameter Name="original_CarreraID" Type="Int32" />
            <asp:Parameter Name="original_NombreSem" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="dsCarreras" runat="server" ConnectionString="<%$ ConnectionStrings:UniversidadConnectionString %>" 
        OldValuesParameterFormatString="original_{0}"
        SelectCommand="SELECT [ID], [Nombre] FROM [Carreras] ORDER BY [Nombre]">
    </asp:SqlDataSource>
</asp:Content>

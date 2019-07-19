<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/UniMasterOne.Master" CodeBehind="frmGrupoAlumnoList.aspx.vb" Inherits="UniversidadWeb.frmGrupoAlumnoList" %>
<%@ Register Assembly="DevExpress.Web.v18.1, Version=18.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <%-- Contenedor principal --%>
    <div class="container-fluid">
          <%-- Titulo/encabezado de la opcion --%>
	    <div class="row margin-bottom">
		    <div class="col-md-12">
			    <h3 class="text-center text-primary">
				    GrupoAlumno
			    </h3>
		    </div>

                <%--Inician los campos de Captura--%>

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
                                            <div class="form-group col-md-6">
                                                <label class="text-info" for="cmbCarrera">* Carreas:</label>
                                                <%--Combobox multicolumna, conectado a un origen de datos--%>
                                                <dx:ASPxComboBox CssClass="form-control" ID="cmbCarrera" runat="server" Width="100%" DropDownWidth="400px"
                                                    DropDownStyle="DropDownList" DataSourceID="dsCarreras" ValueField="ID" ValueType="System.Int32" TextFormatString="{0}"
                                                    ClientInstanceName="cmbCarrera">
                                                    <Columns>
                                                        <dx:ListBoxColumn FieldName="Nombre" />
                                                    </Columns>
                                                    <ClientSideEvents ValueChanged="function(s, e) {
												            cmbCiclo.PerformCallback(cmbCarrera.GetValue());
                                                            cmbAlumno.PerformCallback(cmbCarrera.GetValue());
												            }" />
                                                </dx:ASPxComboBox>
                                            </div>

                                            <div class="form-group col-md-6">
                                                <label class="text-info" for="cmbCiclo">* Ciclo:</label>
                                                <%--Combobox multicolumna, conectado a un origen de datos--%>
                                                <dx:ASPxComboBox CssClass="form-control" ID="cmbCiclo" runat="server" Width="100%" DropDownWidth="400px"
                                                    TextField="Nombre" ValueField="ID" ValueType="System.Int32" ClientInstanceName="cmbCiclo" OnCallback="cmbCiclo_Callback">
                                                    <ClientSideEvents ValueChanged="function(s, e) {
												            cmbGrupo.PerformCallback(cmbCiclo.GetValue());
												            }" />
                                                </dx:ASPxComboBox>
                                            </div>

                                        </div>
                                        <div class="row">
                                    
                                            <div class="form-group col-md-6" style="position: inherit">
                                                <label class="text-info" for="cmbGrupo">* Grupo:</label>
                                                <%--Combobox multicolumna, conectado a un origen de datos--%>
                                                <%--<dx:ASPxComboBox CssClass="form-control" ID="cmbGrupo" runat="server" Width="100%" DropDownWidth="400px"
                                                    TextField="Nombre" ValueField="ID" ValueType="System.Int32" ClientInstanceName="cmbGrupo" OnCallback="cmbGrupo_Callback">
                                                    <ClientSideEvents ValueChanged="function(s, e) {
												            cmbAlumno.PerformCallback(cmbGrupo.GetValue());
												            }" />
                                                </dx:ASPxComboBox>--%>
                                                <dx:ASPxComboBox CssClass="form-control" ID="cmbGrupo" runat="server" Width="100%" DropDownWidth="400px"
                                                    TextField="Nombre" ValueField="ID" ValueType="System.Int32" ClientInstanceName="cmbGrupo" OnCallback="cmbGrupo_Callback"
                                                    TextFormatString="{0}" DropDownStyle="DropDownList">
                                                    <Columns>
                                                        <dx:ListBoxColumn FieldName="Nombre" />
                                                        <dx:ListBoxColumn FieldName="NombreSem" Caption="Semestre" />
                                                    </Columns>
                                                    <%--<ClientSideEvents ValueChanged="function(s, e) {
												            cmbAlumno.PerformCallback(cmbGrupo.GetValue());
												            }" />--%>
                                                </dx:ASPxComboBox>
                                            </div>
                                    
                                            <div class="form-group col-md-6" style="position: inherit">
                                                <label class="text-info" for="cmbAlumno">* Alumno:</label>
                                                <%--Combobox multicolumna, conectado a un origen de datos--%>
                                                <%--<dx:ASPxComboBox CssClass="form-control" ID="cmbAlumno" runat="server" Width="100%" DropDownWidth="400px"
                                                    TextField="Nombre" ValueField="ID" ValueType="System.Int32" ClientInstanceName="cmbAlumno" OnCallback="cmbAlumno_Callback">                                            
                                                </dx:ASPxComboBox>--%>



                                                <dx:ASPxComboBox CssClass="form-control" ID="cmbAlumno" runat="server" Width="100%" DropDownWidth="400px"
                                                    DropDownStyle="DropDownList" ValueField="ID" ValueType="System.Int32" TextFormatString="{0}"
                                                    ClientInstanceName="cmbAlumno" OnCallback="cmbAlumno_Callback">
                                                    <Columns>
                                                        <dx:ListBoxColumn FieldName="Nombre" />
                                                        <dx:ListBoxColumn FieldName="ApellidoPaterno" />
                                                    </Columns>
                                                </dx:ASPxComboBox>


                                            </div>
                                        </div>

                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>
                        </TabPages>

                    </dx:ASPxPageControl>
                    
            
            </div>

             <%-- LINEA DIVISION PARA BOTONS DE ACCION --%>
            <hr />

            <%-- ERRORES DE VALIDACION --%>

            <div class="col-md-12">
                <h5>
                    <asp:Label CssClass="text-danger" ID="lblErroresValidacion" runat="server" Text="Errores..."></asp:Label>
                </h5>
            </div>



            <%-- BOTONES DE ACCION: GRABAR/CANCELAR --%>
            <div class="col-md-12">
                <div class="col-md-4 col-md-offset-8 text-center mb-4">
                    <asp:Button CssClass="btn btn-primary" ID="btnGrabar2" runat="server" Text="Grabar" />
                    <asp:Button CssClass="btn btn-warning" ID="btnCancelar" runat="server" Text="Cancelar" />
                </div>
            </div>
        </div>

        <div class="row">
             <%------------------------------%>
            <%-- GridView principal --%>
            <div class="tabla-adaptable">
            
                <%-- Se declara el nombre para el gridview, el origen de datos para A,B,C., nombre del campo llave primaria,
                        y los eventos que se manejan por codigo (updating, inserting, etc.)  --%>
                <dx:ASPxGridView CssClass="tabla-adaptable" ID="gvwGruposAlumnos" runat="server"  
                    AutoGenerateColumns="False" DataSourceID="dsGruposAlumnos" KeyFieldName="ID"
                    OnRowUpdating="gvwGruposAlumnos_RowUpdating" OnRowInserting="gvwGruposAlumnos_RowInserting">
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
                        <dx:GridViewCommandColumn ButtonType="Image" ShowNewButtonInHeader="False" ShowNewButton="false"  
                            ShowEditButton="True" ShowDeleteButton="True" ShowClearFilterButton="true" Width="80" VisibleIndex="0">
                        </dx:GridViewCommandColumn>
                        <%-- Columna para llave principal: Siempre va al principio, readonly y es NO visible --%>
                        <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="1" Visible="false">
                        </dx:GridViewDataTextColumn>
                        <%-- Inician todas las demás columnas de la tabla --%>                    
                        <dx:GridViewDataComboBoxColumn FieldName="Estatus" VisibleIndex="3" Width="70px">
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataComboBoxColumn FieldName="GrupoID" Caption="Grupo" VisibleIndex="5">
                            <PropertiesComboBox DataSourceID="dsGrupos" TextField="Nombre" ValueField="ID">
                            </PropertiesComboBox>
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataComboBoxColumn FieldName="AlumnoID" Caption="Alumno" VisibleIndex="7">
                            <PropertiesComboBox DataSourceID="dsAlumnos" TextField="Nombre" ValueField="ID">
                            </PropertiesComboBox>
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataComboBoxColumn FieldName="AlumnoID" Caption="Apellido" VisibleIndex="9">
                            <PropertiesComboBox DataSourceID="dsAlumnos" TextField="ApellidoPaterno" ValueField="ID">
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
                                                        <div class="form-group col-md-4" style="position: inherit">
                                                            <label class="text-info" id="lblEstatus" runat="server" for="cmbEstatus">* Estatus:</label>                                                                     
                                                            <dx:ASPxComboBox ID="cmbEstatus" CssClass="form-control" runat="server" ValueType="System.Byte"
                                                                Width="100%" OnInit="cmbEstatus_Init">
                                                            </dx:ASPxComboBox>
                                                            <br />
                                                        </div>
                                                        <div class="form-group col-md-4" style="position:inherit;">
                                                            <dx:ASPxLabel CssClass="text-info" ID="lblGrupo" for="cmbGrupo" runat="server" Text="* Grupo:"></dx:ASPxLabel>
                                                            <%--El campo que se muestra se controla a traves de textField, El valor que se almacena en la BD se gestiona desde ValueField
                                                            El valor que se carga cuando se edita un registro se controla en la propiedad Value y se bindea a la variable del Gridview--%>
                                                            <dx:ASPxComboBox ID="cmbGrupo" runat="server" DataSourceID="dsGrupos" TextField="Nombre" CssClass="form-control"
                                                                ValueField="ID" ValueType="System.Int32" Width="100%" Value='<%# Bind("GrupoID")%>' ClientInstanceName="cmbAlumno">
                                                            </dx:ASPxComboBox>
                                                        </div>
                                                        <div class="form-group col-md-4" style="position:inherit;">
                                                            <dx:ASPxLabel CssClass="text-info" ID="lblAlumno" for="cmbAlumno" runat="server" Text="* Alumno:" ></dx:ASPxLabel>
                                                            <%--El campo que se muestra se controla a traves de textField, El valor que se almacena en la BD se gestiona desde ValueField
                                                            El valor que se carga cuando se edita un registro se controla en la propiedad Value y se bindea a la variable del Gridview--%>
                                                            <dx:ASPxComboBox ID="cmbAlumno" runat="server" DataSourceID="dsAlumnos" TextField="Nombre" CssClass="form-control"
                                                                ValueField="ID" ValueType="System.Int32" Width="100%" Value='<%# Bind("AlumnoID")%>' ClientInstanceName="cmbAlumno">
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
                                    <%--<div class="col-md-4 offset-md-8 col-5 offset-7">--%>
                                    <div class="col-md-4 col-md-offset-8">
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

    <asp:SqlDataSource ID="dsGruposAlumnos" runat="server" ConnectionString="<%$ ConnectionStrings:UniversidadConnectionString %>" OldValuesParameterFormatString="original_{0}" 
        SelectCommand="SELECT [ID], [Estatus], [GrupoID], [AlumnoID] FROM [GruposAlumnos] ORDER BY [GrupoID]" ConflictDetection="CompareAllValues" 
        DeleteCommand="DELETE FROM [GruposAlumnos] WHERE [ID] = @original_ID AND [Estatus] = @original_Estatus AND [GrupoID] = @original_GrupoID AND [AlumnoID] = @original_AlumnoID" 
        InsertCommand="INSERT INTO [GruposAlumnos] ([Estatus], [GrupoID], [AlumnoID]) VALUES (@Estatus, @GrupoID, @AlumnoID)" 
        UpdateCommand="UPDATE [GruposAlumnos] SET [Estatus] = @Estatus, [GrupoID] = @GrupoID, [AlumnoID] = @AlumnoID WHERE [ID] = @original_ID AND [Estatus] = @original_Estatus AND [GrupoID] = @original_GrupoID AND [AlumnoID] = @original_AlumnoID">
        <DeleteParameters>
            <asp:Parameter Name="original_ID" Type="Int32" />
            <asp:Parameter Name="original_Estatus" Type="Byte" />
            <asp:Parameter Name="original_GrupoID" Type="Int32" />
            <asp:Parameter Name="original_AlumnoID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Estatus" Type="Byte" />
            <asp:Parameter Name="GrupoID" Type="Int32" />
            <asp:Parameter Name="AlumnoID" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Estatus" Type="Byte" />
            <asp:Parameter Name="GrupoID" Type="Int32" />
            <asp:Parameter Name="AlumnoID" Type="Int32" />
            <asp:Parameter Name="original_ID" Type="Int32" />
            <asp:Parameter Name="original_Estatus" Type="Byte" />
            <asp:Parameter Name="original_GrupoID" Type="Int32" />
            <asp:Parameter Name="original_AlumnoID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="dsCarreras" runat="server" ConnectionString="<%$ ConnectionStrings:UniversidadConnectionString %>"
        SelectCommand="SELECT [ID], [Nombre] FROM [Carreras] ORDER BY [Nombre]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsGrupos" runat="server" ConnectionString="<%$ ConnectionStrings:UniversidadConnectionString %>"
        SelectCommand="SELECT [ID], [Nombre] FROM [Grupos] ORDER BY [Nombre]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsAlumnos" runat="server" ConnectionString="<%$ ConnectionStrings:UniversidadConnectionString %>"
        SelectCommand="SELECT [ID], [Nombre], [ApellidoPaterno] FROM [Alumnos] ORDER BY [Nombre]"></asp:SqlDataSource>
   
</asp:Content>

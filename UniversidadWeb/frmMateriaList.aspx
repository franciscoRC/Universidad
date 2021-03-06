﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/UniMasterOne.Master" CodeBehind="frmMateriaList.aspx.vb" Inherits="UniversidadWeb.frmMateriaList" %>

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
				    Materias
			    </h3>
		    </div>

                <%-- GridView principal --%>
                <div class="tabla-adaptable">
            
                    <%-- Se declara el nombre para el gridview, el origen de datos para A,B,C., nombre del campo llave primaria,
                            y los eventos que se manejan por codigo (updating, inserting, etc.)  --%>
                    <dx:ASPxGridView CssClass="tabla-adaptable" ID="gvwMaterias" runat="server"  
                        AutoGenerateColumns="False" DataSourceID="dsMaterias" KeyFieldName="ID"
                        OnRowUpdating="gvwMaterias_RowUpdating" OnRowInserting="gvwMaterias_RowInserting">
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
                            <dx:GridViewDataTextColumn FieldName="Clave" VisibleIndex="3">
                            </dx:GridViewDataTextColumn>

                            <dx:GridViewDataTextColumn FieldName="Nombre" VisibleIndex="5">
                            </dx:GridViewDataTextColumn>
                             
                            <dx:GridViewDataCheckColumn FieldName="Activa" VisibleIndex="7" Width="75px">
                            </dx:GridViewDataCheckColumn>

                            <dx:GridViewDataComboBoxColumn FieldName="SemestreID" Caption="Semestre" VisibleIndex="9">
                                <PropertiesComboBox DataSourceID="dsSemestres" TextField="NombreSem" ValueField="ID">
                                </PropertiesComboBox>
                            </dx:GridViewDataComboBoxColumn>
                            <%-- Campo que se usa para filtrar solo los registro de la licencia  --%>
                            <%--<dx:GridViewDataTextColumn FieldName="SemestreID" Caption="Carrera" VisibleIndex="7" Visible="False">
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
                                                            <div class="form-group col-md-2">
                                                                * Clave:
                                                                <dx:ASPxTextBox ID="txtClave" runat="server" Width="100%" MaxLength="50" Text='<%# Eval("Clave")%>'>
                                                                </dx:ASPxTextBox>
                                                                <br />
                                                            </div>

                                                            <div class="form-group col-md-4">
                                                                * Nombre:
                                                                <dx:ASPxTextBox ID="txtNombre" runat="server" Width="100%" MaxLength="50" Text='<%# Eval("Nombre")%>'>
                                                                </dx:ASPxTextBox>

                                                                <br />
                                                            </div>
                                                            <div class="form-group col-md-2">
                                                                <dx:ASPxCheckBox ID="chkActiva" runat="server" Text="Activa" Width="100%"  Checked='<%# Eval("Activa")%>'>
                                                                </dx:ASPxCheckBox>
                                                            </div>
                                                             
                                                            <div class="form-group col-md-4" style="position:inherit;">
                                                                <dx:ASPxLabel ID="lblCarrera" for="cmbSemestre" runat="server" Text="Semestre:"></dx:ASPxLabel>
                                                                <%--El campo que se muestra se controla a traves de textField, El valor que se almacena en la BD se gestiona desde ValueField
                                                                El valor que se carga cuando se edita un registro se controla en la propiedad Value y se bindea a la variable del Gridview--%>
                                                                <dx:ASPxComboBox ID="cmbSemestre" runat="server" DataSourceID="dsSemestres" TextField="NombreSem"
                                                                    ValueField="ID" ValueType="System.Int32" Width="100%" Value='<%# Bind("SemestreID")%>' ClientInstanceName="cmbSemestre">
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

    <asp:SqlDataSource ID="dsMaterias" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:UniversidadConnectionString %>" DeleteCommand="DELETE FROM [Materias] WHERE [ID] = @original_ID AND [Clave] = @original_Clave AND [Nombre] = @original_Nombre AND [Activa] = @original_Activa AND [SemestreID] = @original_SemestreID" InsertCommand="INSERT INTO [Materias] ([Clave], [Nombre], [Activa], [SemestreID]) VALUES (@Clave, @Nombre, @Activa, @SemestreID)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [ID], [Clave], [Nombre], [Activa], [SemestreID] FROM [Materias] ORDER BY [Nombre]" UpdateCommand="UPDATE [Materias] SET [Clave] = @Clave, [Nombre] = @Nombre, [Activa] = @Activa, [SemestreID] = @SemestreID WHERE [ID] = @original_ID AND [Clave] = @original_Clave AND [Nombre] = @original_Nombre AND [Activa] = @original_Activa AND [SemestreID] = @original_SemestreID">
        <DeleteParameters>
            <asp:Parameter Name="original_ID" Type="Int32" />
            <asp:Parameter Name="original_Clave" Type="String" />
            <asp:Parameter Name="original_Nombre" Type="String" />
            <asp:Parameter Name="original_Activa" Type="Boolean" />
            <asp:Parameter Name="original_SemestreID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Clave" Type="String" />
            <asp:Parameter Name="Nombre" Type="String" />
            <asp:Parameter Name="Activa" Type="Boolean" />
            <asp:Parameter Name="SemestreID" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Clave" Type="String" />
            <asp:Parameter Name="Nombre" Type="String" />
            <asp:Parameter Name="Activa" Type="Boolean" />
            <asp:Parameter Name="SemestreID" Type="Int32" />
            <asp:Parameter Name="original_ID" Type="Int32" />
            <asp:Parameter Name="original_Clave" Type="String" />
            <asp:Parameter Name="original_Nombre" Type="String" />
            <asp:Parameter Name="original_Activa" Type="Boolean" />
            <asp:Parameter Name="original_SemestreID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="dsSemestres" runat="server" ConnectionString="<%$ ConnectionStrings:UniversidadConnectionString %>" 
        OldValuesParameterFormatString="original_{0}"
        SelectCommand="SELECT [ID], [NombreSem] FROM [Semestres] ORDER BY [NombreSem]">
    </asp:SqlDataSource>
</asp:Content>

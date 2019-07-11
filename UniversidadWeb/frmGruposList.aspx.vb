Imports DevExpress.Web
Imports DevExpress.Web.Data

'   Creacion: 09-JUL-2019       F.J.R.C
'
'    Historial de cambios:
'   09-JUL-2019     FJRC    Creacion, version inicial
Public Class frmGruposList
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ' Acciones de inicializacion que solo se deben ejecutar una vez al cargar la pagina
        If Not IsPostBack Then

            ' Validacion importante: Evitar que accesen las paginas sin haberse "logeado"
            If CType(Session("UsuarioID"), Int32) = 0 Then
                Response.Redirect("frmLogin.aspx")
            End If

            ' var de sesion corresp a esta opcion del sistema. Con el ID para el centro de ayuda. 
            'Session("NodoAyudaDefault") = "opcPCMonedas"

        End If

    End Sub


#Region " Control GridView principal (Grupos) "

    '
    '  Se ejecuta una vez que se creo el formulario (EditForm)
    ' Util para INICIALIZAR controles con valores DEFAULT
    '
    Protected Sub gvwGrupos_HtmlEditFormCreated(sender As Object, e As ASPxGridViewEditFormEventArgs) Handles gvwGrupos.HtmlEditFormCreated
        ' Los controles estan anidados dentro de un control AspxPAgeControl (pestañas)
        Dim pageControl As ASPxPageControl = TryCast(gvwGrupos.FindEditFormTemplateControl("pageControl"), ASPxPageControl)

        Dim cmbCiclo As ASPxComboBox = TryCast(pageControl.FindControl("cmbCiclo"), ASPxComboBox)

        Dim cmbSemestre As ASPxComboBox = TryCast(pageControl.FindControl("cmbSemestre"), ASPxComboBox)

        'lblSucursal.ReadOnly = gvwCajas.IsNewRowEditing
        cmbCiclo.ReadOnly = Not gvwGrupos.IsNewRowEditing
        cmbSemestre.ReadOnly = Not gvwGrupos.IsNewRowEditing
    End Sub



    ' Inicializacion del GridView. Principalmente se inicializan COMBOBOX
    Protected Sub gvwGrupos_Init(sender As Object, e As EventArgs) Handles gvwGrupos.Init

    End Sub

    ' Valores por DEFAULT a campos en un registro NUEVO dentro de EditForm template
    Protected Sub gvwGrupos_InitNewRow(sender As Object, e As ASPxDataInitNewRowEventArgs) Handles gvwGrupos.InitNewRow

    End Sub

    ' Al momento de actualizar el registro de la Base Datos
    Protected Sub gvwGrupos_RowUpdating(ByVal sender As Object, ByVal e As ASPxDataUpdatingEventArgs) Handles gvwGrupos.RowUpdating

        ' Obtiene (extrae) cada uno de los datos de los controles de edicion y los pasa a la B.D.
        ' Param: 1 = Texbox,  2=Combobox, 3=Memo, 4=Fecha, 5=Checkbox, 6=ASPxGridLookup, 7=ASPxTimeEdit, 8=SpinEdit
        e.NewValues("Nombre") = GetTextControlInGridView(gvwGrupos, "txtNombre", 1)
        'e.NewValues("CicloID") = GetTextControlInGridView(gvwGrupos, "cmbCiclo", 2)
        'e.NewValues("SemestreID") = GetTextControlInGridView(gvwGrupos, "cmbSemestre", 2)

    End Sub

    ' Al momento de insertar el registro de la Base Datos
    Protected Sub gvwGrupos_RowInserting(ByVal sender As Object, ByVal e As ASPxDataInsertingEventArgs) Handles gvwGrupos.RowInserting

        ' Obtiene (extrae) cada uno de los datos de los controles de edicion y los pasa a la B.D.
        ' Param: 1 = Texbox,  2=Combobox, 3=Memo, 4=Fecha, 5=Checkbox, 6=ASPxGridLookup, 7=ASPxTimeEdit, 8=SpinEdit
        e.NewValues("Nombre") = GetTextControlInGridView(gvwGrupos, "txtNombre", 1)
        'e.NewValues("Clave") = GetTextControlInGridView(gvwGrupos, "txtClave", 1)

        ' llave foramea que se toma de una variable de session 
        'e.NewValues("EmpresaID") = Session("EmpresaID")
        e.NewValues("CicloID") = GetTextControlInGridView(gvwGrupos, "cmbCiclo", 2)
        e.NewValues("SemestreID") = GetTextControlInGridView(gvwGrupos, "cmbSemestre", 2)

    End Sub

    ' Validacion de cada uno de los campos obligatorios
    Protected Sub gvwGrupos_RowValidating(sender As Object, e As ASPxDataValidationEventArgs) Handles gvwGrupos.RowValidating

        ' bandera
        Dim mHuboErrores As Boolean = False

        ' lista de controles corresp a los campos que son obligatorios
        If Not ValidaCtrlReqInGridView(gvwGrupos, "txtNombre", 1) Or
                Not ValidaCtrlReqInGridView(gvwGrupos, "cmbCiclo", 2) Or
                Not ValidaCtrlReqInGridView(gvwGrupos, "cmbSemestre", 2) Then

            mHuboErrores = True

        End If

        ' Mensaje en linea inferior del formulario
        If mHuboErrores Then
            e.RowError = "Capture toda la información requerida!"
        End If

    End Sub

#End Region

#Region "PERMISOS de usuario. Habilitacion de Altas, Bajas, Cambios"

    ' Oculta o despliega los botones de accion (A,B,C) del gridview, de acuerdo a los permisos del usuario
    Protected Sub gvwGrupos_CommandButtonInitialize(sender As Object, e As ASPxGridViewCommandButtonEventArgs) Handles gvwGrupos.CommandButtonInitialize

        If e.VisibleIndex = -1 Then Exit Sub

        ' obtenemos la cadena de permisos de la var de sesion corresp a esta opcion del sistema
        'Dim mCadenaPermisos As String = Session("opcPVMonedas")

        Select Case e.ButtonType
            Case ColumnCommandButtonType.New

                e.Visible = (Session("Usuario_Admin") = "1")

            Case ColumnCommandButtonType.Edit

                e.Visible = (Session("Usuario_Admin") = "1")

            Case ColumnCommandButtonType.Delete

                e.Visible = (Session("Usuario_Admin") = "1")

        End Select

    End Sub

#End Region

#Region "Botones de EDICION dentro del Gridview, GRABAR - CANCELAR"

    ' Oculta o despliega los botones dentrol del formulario de edicion del gridview. Grabar o Cancelar
    Protected Sub btnGrabar_Init(sender As Object, e As EventArgs)

        Dim mBtn As ASPxButton = CType(sender, ASPxButton)

        ' obtenemos la cadena de permisos de la var de sesion corresp a esta opcion del sistema
        'Dim mCadenaPermisos As String = Session("opcPVMonedas")


        'Registro nuevo?  Oculta algunos controles
        If gvwGrupos.IsNewRowEditing Then

            mBtn.Visible = (Session("Usuario_Admin") = "1")
        Else

            mBtn.Visible = (Session("Usuario_Admin") = "1")
        End If

    End Sub

    Protected Sub btnGrabar_Click(sender As Object, e As EventArgs)
        ' llama el metodo propio del gridview
        gvwGrupos.UpdateEdit()

    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As EventArgs)
        ' llama el metodo propio del gridview
        gvwGrupos.CancelEdit()

    End Sub

#End Region

#Region " Controles: TextBox, ComboBox, RadioBottom, etc "


#End Region

End Class
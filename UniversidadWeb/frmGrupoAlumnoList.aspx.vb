Imports DevExpress.Web
Imports DevExpress.Web.Data

'   Creacion: 12-JUL-2019       F.J.R.C
'
'    Historial de cambios:
'   12-JUL-2019     FJRC    Creacion, version inicial
Public Class frmGrupoAlumnoList
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

            ' Combobox que se usan en la captura y no conectados a un origen de datos, 
            ' Su lista se llena manualmente con Enumeraciones definidas en la clase

            lblErroresValidacion.Visible = False
            'cmbEstatus_Init(New Object, New EventArgs)
        End If


    End Sub


#Region " Control GridView principal (GrupoAlumno) "

    '
    '  Se ejecuta una vez que se creo el formulario (EditForm)
    ' Util para INICIALIZAR controles con valores DEFAULT
    '
    Protected Sub gvwGruposAlumnos_HtmlEditFormCreated(sender As Object, e As ASPxGridViewEditFormEventArgs) Handles gvwGruposAlumnos.HtmlEditFormCreated
        ' Los controles estan anidados dentro de un control AspxPAgeControl (pestañas)
        'Dim pageControl As ASPxPageControl = TryCast(gvwGruposAlumnos.FindEditFormTemplateControl("pageControl"), ASPxPageControl)

        'Dim cmbGrupo As ASPxComboBox = TryCast(pageControl.FindControl("cmbGrupo"), ASPxComboBox)
        'Dim cmbAlumno As ASPxComboBox = TryCast(pageControl.FindControl("cmbAlumno"), ASPxComboBox)
        'Dim cmbEstatus As ASPxComboBox = TryCast(pageControl.FindControl("cmbEstatus"), ASPxComboBox)

        ''lblSucursal.ReadOnly = gvwCajas.IsNewRowEditing
        'cmbGrupo.ReadOnly = Not gvwGruposAlumnos.IsNewRowEditing
        'cmbAlumno.ReadOnly = Not gvwGruposAlumnos.IsNewRowEditing
        'cmbEstatus.ReadOnly = Not gvwGruposAlumnos.IsNewRowEditing
    End Sub

    ' Inicializacion del GridView. Principalmente se inicializan COMBOBOX
    Protected Sub gvwGruposAlumnos_Init(sender As Object, e As EventArgs) Handles gvwGruposAlumnos.Init
        ' ComboBox no conectado a una fuente de datos
        '
        ' Se cargan manualmente. Se usan en columnas de EntradaSalida ComboBox dentro del GRidview
        '
        Dim mGrid As ASPxGridView = CType(sender, ASPxGridView)
        '
        ' Estatus
        '
        Dim mColEstatusCombo As GridViewDataComboBoxColumn = CType(mGrid.Columns("Estatus"), GridViewDataComboBoxColumn)

        ' regresa diccionario con los elementos del ComboBox
        Dim mItemsEstatus As Dictionary(Of Int32, String) = cmbEstatusElementos()

        ' Carga los elementos al ComboBox
        For Each mItem In mItemsEstatus
            mColEstatusCombo.PropertiesComboBox.Items.Add(mItem.Value, mItem.Key)
        Next
    End Sub

    ' Valores por DEFAULT a campos en un registro NUEVO dentro de EditForm template
    Protected Sub gvwGruposAlumnos_InitNewRow(sender As Object, e As ASPxDataInitNewRowEventArgs) Handles gvwGruposAlumnos.InitNewRow

    End Sub

    ' Al momento de actualizar el registro de la Base Datos
    Protected Sub gvwGruposAlumnos_RowUpdating(ByVal sender As Object, ByVal e As ASPxDataUpdatingEventArgs) Handles gvwGruposAlumnos.RowUpdating

        ' Obtiene (extrae) cada uno de los datos de los controles de edicion y los pasa a la B.D.
        ' Param: 1 = Texbox,  2=Combobox, 3=Memo, 4=Fecha, 5=Checkbox, 6=ASPxGridLookup, 7=ASPxTimeEdit, 8=SpinEdit
        e.NewValues("GrupoID") = GetTextControlInGridView(gvwGruposAlumnos, "cmbGrupo", 2)
        e.NewValues("AlumnoID") = GetTextControlInGridView(gvwGruposAlumnos, "cmbAlumno", 2)
        'e.NewValues("Estatus") = GetTextControlInGridView(gvwGruposAlumnos, "cmbEstatus", 2)

    End Sub

    ' Al momento de insertar el registro de la Base Datos
    Protected Sub gvwGruposAlumnos_RowInserting(ByVal sender As Object, ByVal e As ASPxDataInsertingEventArgs) Handles gvwGruposAlumnos.RowInserting

        ' Obtiene (extrae) cada uno de los datos de los controles de edicion y los pasa a la B.D.
        ' Param: 1 = Texbox,  2=Combobox, 3=Memo, 4=Fecha, 5=Checkbox, 6=ASPxGridLookup, 7=ASPxTimeEdit, 8=SpinEdit
        'e.NewValues("Nombre") = GetTextControlInGridView(gvwGruposAlumnos, "txtNombre", 1)
        e.NewValues("GrupoID") = GetTextControlInGridView(gvwGruposAlumnos, "cmbGrupo", 2)
        e.NewValues("AlumnoID") = GetTextControlInGridView(gvwGruposAlumnos, "cmbAlumno", 2)
        'e.NewValues("Estatus") = GetTextControlInGridView(gvwGruposAlumnos, "cmbEstatus", 2)

        ' llave foramea que se toma de una variable de session 
        'e.NewValues("EmpresaID") = Session("EmpresaID")
        'e.NewValues("CarreraID") = GetTextControlInGridView(gvwGruposAlumnos, "cmbCarrera", 2)

    End Sub

    ' Validacion de cada uno de los campos obligatorios
    Protected Sub gvwGruposAlumnos_RowValidating(sender As Object, e As ASPxDataValidationEventArgs) Handles gvwGruposAlumnos.RowValidating

        ' bandera
        Dim mHuboErrores As Boolean = False

        ' lista de controles corresp a los campos que son obligatorios
        If Not ValidaCtrlReqInGridView(gvwGruposAlumnos, "cmbGrupo", 2) Or
                Not ValidaCtrlReqInGridView(gvwGruposAlumnos, "cmbAlumno", 2) Then 'Or
            'Not ValidaCtrlReqInGridView(gvwGruposAlumnos, "cmbEstatus", 2) 
            'Then

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
    Protected Sub gvwGruposAlumnos_CommandButtonInitialize(sender As Object, e As ASPxGridViewCommandButtonEventArgs) Handles gvwGruposAlumnos.CommandButtonInitialize

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
        If gvwGruposAlumnos.IsNewRowEditing Then

            mBtn.Visible = (Session("Usuario_Admin") = "1")
        Else

            mBtn.Visible = (Session("Usuario_Admin") = "1")
        End If

    End Sub

    Protected Sub btnGrabar_Click(sender As Object, e As EventArgs)
        ' llama el metodo propio del gridview
        gvwGruposAlumnos.UpdateEdit()

    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As EventArgs)
        ' llama el metodo propio del gridview
        gvwGruposAlumnos.CancelEdit()

    End Sub

#End Region


#Region "Botones de acción, GRABAR - CANCELAR"

    Protected Sub btnGrabar2_Click(sender As Object, e As EventArgs) Handles btnGrabar2.Click

        If Not ValidarCamposOblogatorios() Then
            Exit Sub
        End If

        If GrabarDatos() Then

            lblErroresValidacion.Visible = False

            ' regresa a pagina con el grid principal
            '
            Response.Redirect("frmGrupoAlumnoList.aspx")

        Else

            lblErroresValidacion.Visible = True

        End If


    End Sub

    ' Para validar los campos obligatorio
    Private Function ValidarCamposOblogatorios() As Boolean

        'Validaciones
        'If cmbCarrera.SelectedItem Is Nothing Then
        '    lblErroresValidacion.Text = "ERROR!... El campo Carrera es obligatorio !"
        '    lblErroresValidacion.Visible = True
        '    Return False
        'End If
        If cmbGrupo.SelectedItem Is Nothing Then
            lblErroresValidacion.Text = "ERROR!... El campo Grupo es obligatorio !"
            lblErroresValidacion.Visible = True
            Return False
        End If
        If cmbAlumno.SelectedItem Is Nothing Then
            lblErroresValidacion.Text = "ERROR!... El campo Alumno es obligatorio !"
            lblErroresValidacion.Visible = True
            Return False
        End If



        lblErroresValidacion.Visible = False

        Return True

    End Function

    Protected Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click

        ' regresa a pagina con el grid principal

        Response.Redirect("frmGrupoAlumnoList.aspx")

    End Sub

    Private Function GrabarDatos() As Boolean

        ' asigna el ID del registro que se esta editando
        'Dim mID As Int32 = CType(Session("AlumnoID"), Int32)

        '' alta o edicion ?
        'Dim mIsNew As Boolean = (mID = 0)


        ' resultado de la funcion
        Dim mOk As Boolean = False

        ' pasamos como parametro una cadena de conexion, que se encuentra en el archivo app.config.
        ' nota: con el parametro "name" lo interpreta como cadena de conexion. 
        '       Sin ese parametros lo interpreta como nombre de la BD y la agregará en el servidor SQL local
        Using mDbContext As New UniversidadContext.UniversidContext("name=UniversidadConnectionString")

            ' instanciamos un objeto
            Dim moCatalogo As GrupoAlumno

            'If mIsNew Then
            '    ' registro nuevo
            '    moCatalogo = New Alumno
            'Else
            '    ' registro existente. Lo buscamos en la BD
            '    moCatalogo = mDbContext.Alumnos.Find(mID)
            'End If
            moCatalogo = New GrupoAlumno

            With moCatalogo

                '.Estatus = CType(cmbEstatus.Value, GrupoAlumno.Estatus_GrupoAlumno)
                .Estatus = GrupoAlumno.Estatus_GrupoAlumno.Activo
                .GrupoID = CType(cmbGrupo.SelectedItem.Value, Int32)
                .AlumnoID = CType(cmbAlumno.SelectedItem.Value, Int32)




            End With


            ' registro nuevo?
            'If mID = 0 Then
            '    ' Como el objeto está "desconectado" tenemos que agregarlo al contexto nuevamente
            '    mDbContext.Alumnos.Add(moCatalogo)
            'End If
            mDbContext.GruposAlumnos.Add(moCatalogo)

            '
            ' Checar Reglas de validacion definidas en la Clase
            '

            ' instanciamos una objeto "DbEntityEntry", que tiene funciones y propiedades para 
            ' interactuar con las clases del contexto
            Dim moEntityEntry As Entity.Infrastructure.DbEntityEntry
            moEntityEntry = mDbContext.Entry(moCatalogo)

            Try

                mDbContext.SaveChanges()
                mOk = True

            Catch ex As Exception

                lblErroresValidacion.Text = ex.Message
                lblErroresValidacion.Visible = True

            End Try


        End Using

        Return mOk

    End Function


#End Region

#Region " Controles: TextBox, ComboBox, RadioBottom, etc "


#End Region


#Region " Procedimientos CALL-BACK, se ejecutan de lado del Servidor de forma asyncrona "

    ' combo box en cascada. Sus datos dependen del elemento seleccionado en otro combobox
    Protected Sub cmbCiclo_Callback(ByVal source As Object, ByVal e As DevExpress.Web.CallbackEventArgsBase)

        ' recibe los parametros de llamado
        Dim mCarreraID As Int32 = CType(e.Parameter, Int32)

        cmbCarreraCargaElemFiltradosDeCiclos(mCarreraID)

    End Sub

    ' El combo de unidades se debe filtrar. Y deben aparecer solo las corresp al articulo
    Protected Sub cmbCarreraCargaElemFiltradosDeCiclos(ByVal CarreraID As Int32)

        Using mDbContext As New UniversidadContext.UniversidContext("name=UniversidadConnectionString")
            ' buscamos en la BD, si existe un usuario con ese login y contraseña
            '
            'Cargar las ciclos que corresponden a la carrera seleccionada
            Dim moCarreras = (From d In mDbContext.Ciclos
                              Where d.CarreraID = CarreraID
                              Select d.ID, d.Nombre).ToList

            cmbCiclo.DataSource = moCarreras
            cmbCiclo.DataBind()

        End Using


    End Sub


    ' combo box en cascada. Sus datos dependen del elemento seleccionado en otro combobox
    Protected Sub cmbGrupo_Callback(ByVal source As Object, ByVal e As DevExpress.Web.CallbackEventArgsBase)

        ' recibe los parametros de llamado
        Dim mCicloID As Int32 = CType(e.Parameter, Int32)

        cmbCicloCargaElemFiltradosDeGrupos(mCicloID)

    End Sub

    ' El combo de unidades se debe filtrar. Y deben aparecer solo las corresp al articulo
    Protected Sub cmbCicloCargaElemFiltradosDeGrupos(ByVal CicloID As Int32)

        Using mDbContext As New UniversidadContext.UniversidContext("name=UniversidadConnectionString")

            '
            ' buscamos en la BD, si existe un usuario con ese login y contraseña
            '
            'Cargar las cajas que corresponden a la Sucursal seleccionada
            Dim moGrupos = (From d In mDbContext.Grupos
                            Where d.CicloID = CicloID
                            Select d.ID, d.Nombre).ToList

            cmbGrupo.DataSource = moGrupos
            cmbGrupo.DataBind()

        End Using


    End Sub


    ' combo box en cascada. Sus datos dependen del elemento seleccionado en otro combobox
    Protected Sub cmbAlumno_Callback(ByVal source As Object, ByVal e As DevExpress.Web.CallbackEventArgsBase)

        ' recibe los parametros de llamado
        Dim mSemestreID As Int32 = CType(e.Parameter, Int32)

        cmbGrupoCargaElemFiltradosDeAlumnos(mSemestreID)

    End Sub

    ' El combo de unidades se debe filtrar. Y deben aparecer solo las corresp al articulo
    Protected Sub cmbGrupoCargaElemFiltradosDeAlumnos(ByVal SemesID As Int32)

        Using mDbContext As New UniversidadContext.UniversidContext("name=UniversidadConnectionString")

            '
            ' buscamos en la BD, si existe un usuario con ese login y contraseña
            '
            'Cargar las cajas que corresponden a la Sucursal seleccionada
            Dim moSemesID = (From d In mDbContext.Grupos
                             Where d.ID = SemesID
                             Select d.SemestreID).FirstOrDefault

            Dim moSemestre = (From A In mDbContext.Alumnos
                              Join d In mDbContext.Semestres
                              On d.CarreraID Equals A.CarreraID
                              Where d.ID = moSemesID
                              Select A.Nombre, A.ID).ToList



            cmbAlumno.DataSource = moSemestre
            cmbAlumno.DataBind()

        End Using


    End Sub

#End Region

#Region " Controles: TextBox, ComboBox, RadioBottom, etc "

    ' Inicializacion del control ComboBox no conectado a un DataSource. 
    ' Se cargaran los elementos manualmente
    Protected Sub cmbEstatus_Init(sender As Object, e As EventArgs)


        Dim mComboBox1 As ASPxComboBox = TryCast(sender, ASPxComboBox)

        ' regresa diccionario con los elementos del ComboBox
        Dim mItemss As Dictionary(Of Int32, String) = cmbEstatusElementos()

        ' Carga los elementos al ComboBox
        For Each mItem In mItemss
            mComboBox1.Items.Add(mItem.Value, mItem.Key)
        Next


        Dim index As Int32
        Dim mEstatus As GrupoAlumno.Estatus_GrupoAlumno
        ' Registro nuevo?  Oculta algunos controles
        '
        If Not gvwGruposAlumnos.IsNewRowEditing Then

            Index = gvwGruposAlumnos.EditingRowVisibleIndex
            mEstatus = CType(gvwGruposAlumnos.GetRowValues(Index, "Estatus"), GrupoAlumno.Estatus_GrupoAlumno)

        Else
            mEstatus = 0
        End If

        mComboBox1.SelectedIndex = mEstatus

    End Sub


    ' Regresa diccionario con los elementos del ComboBox
    Private Function cmbEstatusElementos() As Dictionary(Of Int32, String)

        Dim mItems As New Dictionary(Of Int32, String)

        Items.Add(0, "Activo")
        Items.Add(1, "Suspendido")
        Items.Add(2, "Baja")

        Return mItems

    End Function

#End Region
End Class
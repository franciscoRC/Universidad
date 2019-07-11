Imports DevExpress.Web
Imports DevExpress.Web.Data

'   Creacion: 07-JUL-2019       F.J.R.C
'
'    Historial de cambios:
'   07-JUL-2019     FJRC    Creacion, version inicial
Public Class frmCarrerasList
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ' Acciones de inicializacion que solo se deben ejecutar una vez al cargar la pagina
        'If Not IsPostBack Then

        '    '' Validacion importante: Evitar que accesen las paginas sin haberse "logeado"
        '    'If CType(Session("UniversidadID"), Int32) = 0 Then
        '    '    Response.Redirect("frmLogin.aspx")
        '    'End If
        'End If

    End Sub

#Region " BOTONES ACCESO RAPIDO: REPORTES "

    'Protected Sub btnRpListaPrecios_Click(sender As Object, e As EventArgs) Handles btnRpListaPrecios.Click

    '    Response.Redirect("frmRpArticListaPrec.aspx")

    'End Sub

#End Region

#Region "PERMISOS de usuario. Habilitacion de Altas, Bajas, Cambios"

    Protected Sub gvwCarreras_CustomButtonInitialize(sender As Object, e As ASPxGridViewCustomButtonEventArgs) Handles gvwCarreras.CustomButtonInitialize

        'If e.VisibleIndex = -1 Then Exit Sub

        ' obtenemos la cadena de permisos de la var de sesion corresp a esta opcion del sistema
        'Dim mCadenaPermisos As String = Session("opcPVGastosCaja")

        'Dim mOk As Boolean
        'Select Case e.ButtonID
        '    Case "gvwCarrerasInsertar"
        '        mOk = Session("Empleado_CuentaAdmin") = "1" OrElse TieneElPermiso(Permisos.Alta, mCadenaPermisos)

        '    Case "gvwCarrerasEditar"
        '        mOk = Session("Empleado_CuentaAdmin") = "1" OrElse TieneElPermiso(Permisos.Edicion, mCadenaPermisos) OrElse
        '                    TieneElPermiso(Permisos.Consulta, mCadenaPermisos)

        'End Select

        'If mOk Then
        '    e.Visible = DevExpress.Utils.DefaultBoolean.True
        'Else
        '    e.Visible = DevExpress.Utils.DefaultBoolean.False
        'End If

    End Sub

    Protected Sub gvwCarreras_CommandButtonInitialize(sender As Object, e As ASPxGridViewCommandButtonEventArgs) Handles gvwCarreras.CommandButtonInitialize

        'If e.VisibleIndex = -1 Then Exit Sub

        '' obtenemos la cadena de permisos de la var de sesion corresp a esta opcion del sistema
        'Dim mCadenaPermisos As String = Session("opcPVGastosCaja")

        'Select Case e.ButtonType
        '    Case ColumnCommandButtonType.Delete

        '        e.Visible = Session("Empleado_CuentaAdmin") = "1" OrElse TieneElPermiso(Permisos.Baja, mCadenaPermisos)

        'End Select

    End Sub

#End Region

#Region " Botones de accion: ALTAS, BAJAS, CAMBIOS "

    Protected Sub gvwCarreras_CustomButtonCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridViewCustomButtonCallbackEventArgs) Handles gvwCarreras.CustomButtonCallback

        If e.ButtonID = "gvwCarrerasInsertar" Then

            ' Automaticamente se manda llamar la pantalla de alta, con ID cero.
            Session("CarreraID") = 0

            ASPxWebControl.RedirectOnCallback("frmCarrerasEdit.aspx")

        End If

        If e.ButtonID = "gvwCarrerasEditar" Then

            ' obtiene ID de Gasto
            Dim mID As String = gvwCarreras.GetRowValues(e.VisibleIndex, "ID").ToString()

            ' Automaticamente se manda llamar la pantalla de alta, con ID cero.
            Session("CarreraID") = mID

            ASPxWebControl.RedirectOnCallback("frmCarrerasEdit.aspx")

        End If

    End Sub

    ' gridview VACIO / SIN REGISTROS: Boton que aparece para agregar registros
    Protected Sub btnInsertar_Click(sender As Object, e As EventArgs)

        ' Automaticamente se manda llamar la pantalla de alta, con ID cero.
        Session("CarreraID") = 0

        Response.Redirect("frmCarrerasEdit.aspx")

    End Sub

    Protected Sub btnInsertar_Init(sender As Object, e As EventArgs)

        '' obtenemos la cadena de permisos de la var de sesion corresp a esta opcion del sistema
        'Dim mCadenaPermisos As String = Session("opcPVGastosCaja")

        'sender.Visible = Session("Empleado_CuentaAdmin") = "1" OrElse TieneElPermiso(Permisos.Alta, mCadenaPermisos)

    End Sub

#End Region

#Region "Eventos seleccion gridview HIJOS"

    Protected Sub gvwPartidas_BeforePerformDataSelect(sender As Object, e As EventArgs)

        ' Toma y asigna el ID del Padre
        Session("CarreraID") = CType(sender, DevExpress.Web.ASPxGridView).GetMasterRowKeyValue

    End Sub

#End Region


#Region "Control MENU - ToolBar"


#End Region

End Class
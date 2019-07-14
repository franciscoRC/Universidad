Imports DevExpress.Web
Imports DevExpress.Web.Data

'   Creacion: 07-JUL-2019       F.J.R.C
'
'    Historial de cambios:
'   07-JUL-2019     FJRC    Creacion, version inicial
Public Class frmCalificacionList
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ' Acciones de inicializacion que solo se deben ejecutar una vez al cargar la pagina
        If Not IsPostBack Then

            '' Validacion importante: Evitar que accesen las paginas sin haberse "logeado"
            If CType(Session("UsuarioID"), Int32) = 0 Then
                Response.Redirect("frmLogin.aspx")
            End If

        End If

    End Sub

#Region " BOTONES ACCESO RAPIDO: REPORTES "

    'Protected Sub btnRpListaPrecios_Click(sender As Object, e As EventArgs) Handles btnRpListaPrecios.Click

    '    Response.Redirect("frmRpArticListaPrec.aspx")

    'End Sub

#End Region

#Region "PERMISOS de usuario. Habilitacion de Altas, Bajas, Cambios"

    Protected Sub gvwCalificacion_CustomButtonInitialize(sender As Object, e As ASPxGridViewCustomButtonEventArgs) Handles gvwCalificacion.CustomButtonInitialize

        If e.VisibleIndex = -1 Then Exit Sub

        'obtenemos la cadena de permisos de la var de sesion corresp a esta opcion del sistema
        'Dim mCadenaPermisos As String = Session("opcPVGastosCaja")

        Dim mOk As Boolean
        Select Case e.ButtonID
            Case "gvwCalificacionInsertar"
                'mOk = Session("Empleado_CuentaAdmin") = "1" OrElse TieneElPermiso(Permisos.Alta, mCadenaPermisos)

                mOk = (Session("Usuario_Admin") = "1")

            Case "gvwCalificacionEditar"
                mOk = True

        End Select

        If mOk Then
            e.Visible = DevExpress.Utils.DefaultBoolean.True
        Else
            e.Visible = DevExpress.Utils.DefaultBoolean.False
        End If

    End Sub

    Protected Sub gvwCalificacion_CommandButtonInitialize(sender As Object, e As ASPxGridViewCommandButtonEventArgs) Handles gvwCalificacion.CommandButtonInitialize

        If e.VisibleIndex = -1 Then Exit Sub

        ' obtenemos la cadena de permisos de la var de sesion corresp a esta opcion del sistema
        'Dim mCadenaPermisos As String = Session("opcPVGastosCaja")

        Select Case e.ButtonType
            Case ColumnCommandButtonType.Delete

                e.Visible = (Session("Usuario_Admin") = "1")

        End Select

    End Sub

#End Region

#Region " Botones de accion: ALTAS, BAJAS, CAMBIOS "

    Protected Sub gvwCalificacion_CustomButtonCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridViewCustomButtonCallbackEventArgs) Handles gvwCalificacion.CustomButtonCallback

        If e.ButtonID = "gvwCalificacionInsertar" Then

            ' Automaticamente se manda llamar la pantalla de alta, con ID cero.
            Session("CalificacionID") = 0

            ASPxWebControl.RedirectOnCallback("frmCalificacionEdit.aspx")

        End If

        If e.ButtonID = "gvwCalificacionEditar" Then

            ' obtiene ID de Gasto
            Dim mID As String = gvwCalificacion.GetRowValues(e.VisibleIndex, "ID").ToString()

            ' Automaticamente se manda llamar la pantalla de alta, con ID cero.
            Session("CalificacionID") = mID

            ASPxWebControl.RedirectOnCallback("frmCalificacionEdit.aspx")

        End If

    End Sub

    ' gridview VACIO / SIN REGISTROS: Boton que aparece para agregar registros
    Protected Sub btnInsertar_Click(sender As Object, e As EventArgs)

        ' Automaticamente se manda llamar la pantalla de alta, con ID cero.
        Session("CalificacionID") = 0

        Response.Redirect("frmCalificacionEdit.aspx")

    End Sub

    Protected Sub btnInsertar_Init(sender As Object, e As EventArgs)

        '' obtenemos la cadena de permisos de la var de sesion corresp a esta opcion del sistema
        'Dim mCadenaPermisos As String = Session("opcPVGastosCaja")

        sender.Visible = (Session("Usuario_Admin") = "1")

    End Sub

#End Region

#Region "Eventos seleccion gridview HIJOS"

    'Protected Sub gvwPartidas_BeforePerformDataSelect(sender As Object, e As EventArgs)

    '    ' Toma y asigna el ID del Padre
    '    Session("CalificacionID") = CType(sender, DevExpress.Web.ASPxGridView).GetMasterRowKeyValue

    'End Sub

#End Region


#Region "Control MENU - ToolBar"


#End Region

End Class
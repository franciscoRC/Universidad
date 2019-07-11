Public Class frmLogin
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lblError.Visible = False
    End Sub


#Region " Controles: TextBox, ComboBox, RadioBottom, etc "

    Protected Sub btnEntrar_Click(sender As Object, e As EventArgs) Handles btnEntrar.Click

        ' pasamos como parametro una cadena de conexion, que se encuentra en el archivo app.config.
        ' nota: con el parametro "name" lo interpreta como cadena de conexion. 
        '       Sin ese parametros lo interpreta como nombre de la BD y la agregará en el servidor SQL local
        Using mdbContext As New UniversidadContext.UniversidContext("name=UniversidadConnectionString")

            '    'Using mDbContext As New UniversidadContext.UniversidadContext("name=UniversidadConnectionString")

            ' buscamos en la BD, si existe un usuario con ese login y contraseña
            '
            Dim moUsuario = (From d In mdbContext.Usuarios
                             Where d.Login = txtLogin.Text And d.Contrasena = txtContrasena.Text
                             Select d).FirstOrDefault


            If moUsuario Is Nothing OrElse moUsuario.ID = 0 Then
                ' no existe
                lblError.Visible = True

            Else

                Session("UsuarioID") = moUsuario.ID
                Session("Usuario_Admin") = IIf(moUsuario.Administrador, 1, 0)

                ' Llamamos a la pantalla del menu de MODULOS del sistema
                Response.Redirect("frmInicio.aspx")

            End If

        End Using



    End Sub

#End Region

End Class
﻿Imports DevExpress.Web
Imports DevExpress.Web.Data

'   Creacion: 07-JUL-2019       F.J.R.C
'
'    Historial de cambios:
'   07-JUL-2019     FJRC    Creacion, version inicial
Public Class frmCicloEdit
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ' Acciones de inicializacion que solo se deben ejecutar una vez al cargar la pagina
        If Not IsPostBack Then

            '' Validacion importante: Evitar que accesen las paginas sin haberse "logeado"
            If CType(Session("UsuarioID"), Int32) = 0 Then
                Response.Redirect("frmLogin.aspx")
            End If

            ' var de sesion corresp a esta opcion del sistema. Con el ID para el centro de ayuda. 
            'Session("NodoAyudaDefault") = "opcPVGastosCaja"

            ' Variable de sesiion que se usa como parametro. 
            ' Contiene el ID del elemento a editar, si es cero se trata de una Alta
            Dim mID As Int32 = CType(Session("CicloID"), Int32)

            ' var que nos indica si se trata de una Alta o Edicion
            Dim mIsNew As Boolean = (mID = 0)

            ' registro existente
            If Not mIsNew Then

                lblABC.InnerText = "[ Edición ]"

            Else

                lblABC.InnerText = "[ Alta ]"

            End If

            DesplegarDatos(mID)

            ' Habilitar boton GRABAR, de acuerdo a los permisos del usuario
            '
            ' obtenemos la cadena de permisos de la var de sesion corresp a esta opcion del sistema
            'Dim mCadenaPermisos As String = Session("opcPVGastosCaja")
            'btnGrabar.Visible = Session("Empleado_CuentaAdmin") = "1" OrElse TieneElPermiso(Permisos.Alta, mCadenaPermisos) OrElse TieneElPermiso(Permisos.Edicion, mCadenaPermisos)


            lblErroresValidacion.Visible = False


        End If

    End Sub

#Region " asignar y DESPLEGAR DATOS en los controles"

    ' Despliega los datos de un registro ya existente en la BD
    Private Sub DesplegarDatos(ByVal mID As Int32)

        'Dim mEmpresaID As Int32 = CType(Session("EmpresaID"), Int32)

        ' registro nuevo ?
        Dim mIsNew As Boolean = (mID = 0)


        Dim moCatalogo As Ciclo
        If mIsNew Then
            'instanciamos un objeto nuevo (vacio)
            moCatalogo = New Ciclo
        Else
            ' se busca el elemento en la BD ?
            moCatalogo = BuscaElementoEnBD(mID)
        End If

        ' Asignamos campos de la BD alos controles de edicion
        With moCatalogo

            ' asigna campos de la BD a controles
            txtNombre.Text = .Nombre
            dtpFechaIni.Value = .FechaIni
            dtpFechaFin.Value = .FechaFin
            txtColegiatura.Text = .Colegiatura
            'cmbCarrera.Value = .CarreraID

            Dim CarreraID As Int32 = .CarreraID
            ' aspxCombobox conectado a una tabla de la base de datos
            If Not mIsNew Then
                With cmbCarrera
                    .DataBind()
                    .SelectedItem = .Items.FindByValue(CarreraID)
                End With

            End If
        End With

    End Sub

    ' para desplegar sus datos
    Private Function BuscaElementoEnBD(ByVal mID As Int32) As Ciclo

        Dim moCatalogo As Ciclo

        ' pasamos como parametro una cadena de conexion, que se encuentra en el archivo app.config.
        ' nota: con el parametro "name" lo interpreta como cadena de conexion. 
        '       Sin ese parametros lo interpreta como nombre de la BD y la agregará en el servidor SQL local
        Using mDbContext As New UniversidadContext.UniversidContext("name=UniversidadConnectionString")

            ' buscamos el registro en la BD
            moCatalogo = (From d In mDbContext.Ciclos
                          Where d.ID = mID Select d).FirstOrDefault


        End Using

        Return moCatalogo

    End Function

#End Region

#Region "Botones de acción, GRABAR - CANCELAR"

    Protected Sub btnGrabar_Click(sender As Object, e As EventArgs) Handles btnGrabar.Click

        If Not ValidarCamposOblogatorios() Then
            Exit Sub
        End If

        If GrabarDatos() Then

            lblErroresValidacion.Visible = False

            ' regresa a pagina con el grid principal
            '
            Response.Redirect("frmCicloList.aspx")

        Else

            lblErroresValidacion.Visible = True

        End If


    End Sub

    ' Para validar los campos obligatorio
    Private Function ValidarCamposOblogatorios() As Boolean

        'Validaciones
        If txtNombre.Text = "" Then
            lblErroresValidacion.Text = "ERROR!... El campo Nombre es obligatorio !"
            lblErroresValidacion.Visible = True
            Return False
        End If



        lblErroresValidacion.Visible = False

        Return True

    End Function

    Protected Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click

        ' regresa a pagina con el grid principal

        Response.Redirect("frmCicloList.aspx")

    End Sub

    Private Function GrabarDatos() As Boolean

        ' asigna el ID del registro que se esta editando
        Dim mID As Int32 = CType(Session("CicloID"), Int32)

        ' alta o edicion ?
        Dim mIsNew As Boolean = (mID = 0)


        ' resultado de la funcion
        Dim mOk As Boolean = False

        ' pasamos como parametro una cadena de conexion, que se encuentra en el archivo app.config.
        ' nota: con el parametro "name" lo interpreta como cadena de conexion. 
        '       Sin ese parametros lo interpreta como nombre de la BD y la agregará en el servidor SQL local
        Using mDbContext As New UniversidadContext.UniversidContext("name=UniversidadConnectionString")

            ' instanciamos un objeto
            Dim moCatalogo As Ciclo

            If mIsNew Then
                ' registro nuevo
                moCatalogo = New Ciclo
            Else
                ' registro existente. Lo buscamos en la BD
                moCatalogo = mDbContext.Ciclos.Find(mID)
            End If


            With moCatalogo


                .Nombre = txtNombre.Text
                .FechaIni = dtpFechaIni.Value
                .FechaFin = dtpFechaFin.Value
                .Colegiatura = txtColegiatura.Text
                .CarreraID = CType(cmbCarrera.SelectedItem.Value, Int32)

            End With


            ' registro nuevo?
            If mID = 0 Then
                ' Como el objeto está "desconectado" tenemos que agregarlo al contexto nuevamente
                mDbContext.Ciclos.Add(moCatalogo)
            End If


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

#Region " Procedimientos CALL-BACK, se ejecutan de lado del Servidor de forma asyncrona "



#End Region

#Region " inicializa controles COMBOBOX "


#End Region



End Class
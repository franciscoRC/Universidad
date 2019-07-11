Imports DevExpress.Web
Imports DevExpress.Web.ASPxTreeList
Imports System.IO
Imports System.Data.Entity
Imports System.Net.Mail

' Definicion de enumeracion para el manejo de los permisos a las opciones del menu
' [101010101] [Altas,Bajas,Edicion,Consulta,RepPantalla,RepImpr,RepEMail,Export,Proceso]
Public Enum Permisos As Byte
    Alta
    Baja
    Edicion
    Consulta
    RepPantalla
    RepImpresora
    RepEMail
    Exportar
    EnvEmail
    Proceso
    Subir
    Importacion
End Enum

Module Utilerias

#Region " Funciones y procedimientos de apoyo para GRIDVIEW's "

    ' Obtiene el dato(valor) capturado en un control dentro de un EditForm en el gridview
    ' Param: 1 = Texbox,  2=Combobox, 3=Memo, 4=Fecha, 5=Checkbox, 6=ASPxGridLookup
    Public Function GetTextControlInGridView(ByRef objNombreGridView As ASPxGridView, ByVal NombreControl As String, ByVal TipoControl As Byte) As String

        ' Los controles estan anidados dentro de un control AspxPAgeControl (pestañas)
        Dim pageControl As ASPxPageControl = TryCast(objNombreGridView.FindEditFormTemplateControl("pageControl"), ASPxPageControl)

        Dim mResult As String = ""
        Select Case TipoControl
            Case 1  ' Control tipo TextBox
                Dim mTxtBox As ASPxTextBox = TryCast(pageControl.FindControl(NombreControl), ASPxTextBox)
                mResult = mTxtBox.Text

            Case 2  ' Control tipo ComboBox
                Dim mCombo As ASPxComboBox = TryCast(pageControl.FindControl(NombreControl), ASPxComboBox)
                If mCombo.SelectedItem Is Nothing Then
                    mResult = ""
                Else
                    mResult = mCombo.SelectedItem.Value.ToString
                End If

            Case 3  ' Control tipo Memo
                Dim mMemo As ASPxMemo = TryCast(pageControl.FindControl(NombreControl), ASPxMemo)
                mResult = mMemo.Text

            Case 4  ' Control tipo Fecha
                Dim mFecha As ASPxDateEdit = TryCast(pageControl.FindControl(NombreControl), ASPxDateEdit)
                mResult = mFecha.Text

            Case 5  ' Control checkBox
                Dim mCheckBox As ASPxCheckBox = TryCast(pageControl.FindControl(NombreControl), ASPxCheckBox)
                mResult = mCheckBox.Checked.ToString

            Case 6  ' Control tipo ASPxGridLookup
                Dim mCombo As ASPxGridLookup = TryCast(pageControl.FindControl(NombreControl), ASPxGridLookup)
                If mCombo.Value Is Nothing Then
                    mResult = ""
                Else
                    mResult = mCombo.Value.ToString
                End If

            Case 7  ' Control tipo timeEdit
                Dim mFecha As ASPxTimeEdit = TryCast(pageControl.FindControl(NombreControl), ASPxTimeEdit)
                mResult = Now.Date & " " & mFecha.Text

            Case 8  ' Control tipo SpinEdit
                Dim mSpin As ASPxSpinEdit = TryCast(pageControl.FindControl(NombreControl), ASPxSpinEdit)
                mResult = mSpin.Number

            Case 9  ' Control tipo aspxGridLookUp
                Dim mCombo As ASPxGridLookup = TryCast(pageControl.FindControl(NombreControl), ASPxGridLookup)
                If Val(mCombo.Value) = 0 Then
                    mResult = ""
                Else
                    mResult = mCombo.GridView.GetRowValues(mCombo.GridView.FocusedRowIndex, "ID")
                End If

        End Select

        Return mResult

    End Function

    ' Realiza la Validacion para un control Requerido
    ' Param: 1 = Texbox,  2=Combobox, 3=Memo, 4=Fecha, 5=Checkbox, 6=ASPxGridLookup
    Public Function ValidaCtrlReqInGridView(ByRef objNombreGridView As ASPxGridView, ByVal NombreControl As String, ByVal TipoControl As Byte) As Boolean

        ' bandera
        Dim mOk As Boolean = True

        ' Campo Obligatorio
        If GetTextControlInGridView(objNombreGridView, NombreControl, TipoControl) = "" Then

            ' Los controles estan anidados dentro de un control AspxPAgeControl (pestañas)
            Dim pageControl As ASPxPageControl = TryCast(objNombreGridView.FindEditFormTemplateControl("pageControl"), ASPxPageControl)

            ' tipo de control ?
            Select Case TipoControl
                Case 1  '  TextBox

                    ' Buscamos el control
                    Dim mTxtBox As ASPxTextBox = TryCast(pageControl.FindControl(NombreControl), ASPxTextBox)

                    ' Cambiamos su estatus a NO Valido
                    mTxtBox.IsValid = False
                    mTxtBox.ErrorText = "Requerido"

                Case 2  '   ComboBox
                    Dim mCombo As ASPxComboBox = TryCast(pageControl.FindControl(NombreControl), ASPxComboBox)

                    ' Cambiamos su estatus a NO Valido
                    mCombo.IsValid = False
                    mCombo.ErrorText = "Requerido"

                Case 3  '  Memo

                    ' Buscamos el control
                    Dim mMemo As ASPxMemo = TryCast(pageControl.FindControl(NombreControl), ASPxMemo)

                    ' Cambiamos su estatus a NO Valido
                    mMemo.IsValid = False
                    mMemo.ErrorText = "Requerido"

                Case 4  '  fecha

                    ' Buscamos el control
                    Dim mFecha As ASPxDateEdit = TryCast(pageControl.FindControl(NombreControl), ASPxDateEdit)

                    ' Cambiamos su estatus a NO Valido
                    mFecha.IsValid = False
                    mFecha.ErrorText = "Requerido"

                Case 5  '  checkbox

                    ' Buscamos el control
                    Dim mCheckBox As ASPxCheckBox = TryCast(pageControl.FindControl(NombreControl), ASPxCheckBox)

                    ' Cambiamos su estatus a NO Valido
                    mCheckBox.IsValid = False
                    mCheckBox.ErrorText = "Requerido"

                Case 6  '  ASPxGridLookup
                    Dim mCombo As ASPxGridLookup = TryCast(pageControl.FindControl(NombreControl), ASPxGridLookup)

                    ' Cambiamos su estatus a NO Valido
                    mCombo.IsValid = False
                    mCombo.ErrorText = "Requerido"

                Case 8  '  SpinEdit

                    ' Buscamos el control
                    Dim mTxtBox As ASPxSpinEdit = TryCast(pageControl.FindControl(NombreControl), ASPxSpinEdit)

                    ' Cambiamos su estatus a NO Valido
                    mTxtBox.IsValid = False
                    mTxtBox.ErrorText = "Requerido"

            End Select

            ' bandera
            mOk = False
        End If

        Return mOk

    End Function

    ' regresa el ID corresp al registro que se esta editando.
    Public Function ObtenerIDRegistroEditado(ByRef objNombreGridView As ASPxGridView) As Int32

        ' indice corresp al registro editado
        Dim rowIndex = objNombreGridView.EditingRowVisibleIndex
        Dim mID As Int32 = CType(objNombreGridView.GetRowValues(rowIndex, objNombreGridView.KeyFieldName), Int32)

        Return mID

    End Function

#End Region

#Region " Funciones y procedimientos de apoyo para TREELIST's "

    ' Obtiene el dato(valor) capturado en un control dentro de un EditForm en el treelist
    ' Param: 1 = Texbox,  2=Combobox, 3=Memo, 4=Fecha, 5=Checkbox
    Public Function GetTextControlInTreeList(ByRef objNombreTreeList As ASPxTreeList, ByVal NombreControl As String, ByVal TipoControl As Byte) As String

        ' Los controles estan anidados dentro de un control AspxPAgeControl (pestañas)
        Dim pageControl As ASPxPageControl = TryCast(objNombreTreeList.FindEditFormTemplateControl("pageControl"), ASPxPageControl)

        Dim mResult As String = ""

        'If pageControl Is Nothing Then Exit Function

        Select Case TipoControl
            Case 1  ' Control tipo TextBox
                Dim mTxtBox As ASPxTextBox = TryCast(pageControl.FindControl(NombreControl), ASPxTextBox)
                mResult = mTxtBox.Text

            Case 2  ' Control tipo ComboBox
                Dim mCombo As ASPxComboBox = TryCast(pageControl.FindControl(NombreControl), ASPxComboBox)
                If mCombo.SelectedItem Is Nothing Then
                    mResult = ""
                Else
                    mResult = mCombo.SelectedItem.Value.ToString
                End If

            Case 3  ' Control tipo Memo
                Dim mMemo As ASPxMemo = TryCast(pageControl.FindControl(NombreControl), ASPxMemo)
                mResult = mMemo.Text

            Case 4  ' Control tipo Fecha
                Dim mFecha As ASPxDateEdit = TryCast(pageControl.FindControl(NombreControl), ASPxDateEdit)
                mResult = mFecha.Text

            Case 5  ' Control checkBox
                Dim mCheckBox As ASPxCheckBox = TryCast(pageControl.FindControl(NombreControl), ASPxCheckBox)
                mResult = mCheckBox.Checked.ToString

            Case 6  ' Control tipo ASPxGridLookup
                Dim mCombo As ASPxGridLookup = TryCast(pageControl.FindControl(NombreControl), ASPxGridLookup)
                If mCombo.Value Is Nothing Then
                    mResult = ""
                Else
                    mResult = mCombo.Value.ToString
                End If

            Case 7  ' Control tipo Fecha
                Dim mTime As ASPxTimeEdit = TryCast(pageControl.FindControl(NombreControl), ASPxTimeEdit)
                mResult = mTime.DateTime.ToString

        End Select

        Return mResult

    End Function

    ' Realiza la Validacion para un control Requerido
    ' Param: 1 = Texbox,  2=Combobox, 3=Memo, 4=Fecha, 5=Checkbox
    Public Function ValidaCtrlReqInTreeList(ByRef objNombreTreeList As ASPxTreeList, ByVal NombreControl As String, ByVal TipoControl As Byte) As Boolean

        ' bandera
        Dim mOk As Boolean = True

        ' Campo Obligatorio
        If GetTextControlInTreeList(objNombreTreeList, NombreControl, TipoControl) = "" Then

            ' Los controles estan anidados dentro de un control AspxPAgeControl (pestañas)
            Dim pageControl As ASPxPageControl = TryCast(objNombreTreeList.FindEditFormTemplateControl("pageControl"), ASPxPageControl)

            'If pageControl Is Nothing Then Exit Function

            ' tipo de control ?
            Select Case TipoControl
                Case 1  '  TextBox

                    ' Buscamos el control
                    Dim mTxtBox As ASPxTextBox = TryCast(pageControl.FindControl(NombreControl), ASPxTextBox)

                    ' Cambiamos su estatus a NO Valido
                    mTxtBox.IsValid = False
                    mTxtBox.ErrorText = "Requerido"

                Case 2  '   ComboBox
                    Dim mCombo As ASPxComboBox = TryCast(pageControl.FindControl(NombreControl), ASPxComboBox)

                    ' Cambiamos su estatus a NO Valido
                    mCombo.IsValid = False
                    mCombo.ErrorText = "Requerido"

                Case 3  '  Memo

                    ' Buscamos el control
                    Dim mMemo As ASPxMemo = TryCast(pageControl.FindControl(NombreControl), ASPxMemo)

                    ' Cambiamos su estatus a NO Valido
                    mMemo.IsValid = False
                    mMemo.ErrorText = "Requerido"

                Case 4  '  fecha

                    ' Buscamos el control
                    Dim mFecha As ASPxDateEdit = TryCast(pageControl.FindControl(NombreControl), ASPxDateEdit)

                    ' Cambiamos su estatus a NO Valido
                    mFecha.IsValid = False
                    mFecha.ErrorText = "Requerido"

                Case 5  '  checkbox

                    ' Buscamos el control
                    Dim mCheckBox As ASPxCheckBox = TryCast(pageControl.FindControl(NombreControl), ASPxCheckBox)

                    ' Cambiamos su estatus a NO Valido
                    mCheckBox.IsValid = False
                    mCheckBox.ErrorText = "Requerido"

                Case 6  '  ASPxGridLookup
                    Dim mCombo As ASPxGridLookup = TryCast(pageControl.FindControl(NombreControl), ASPxGridLookup)

                    ' Cambiamos su estatus a NO Valido
                    mCombo.IsValid = False
                    mCombo.ErrorText = "Requerido"

                Case 7  '  timeedit
                    Dim mTime As ASPxTimeEdit = TryCast(pageControl.FindControl(NombreControl), ASPxTimeEdit)

                    ' Cambiamos su estatus a NO Valido
                    mTime.IsValid = False
                    mTime.ErrorText = "Requerido"

            End Select

            ' bandera
            mOk = False
        End If

        Return mOk

    End Function

#End Region




#Region " Funciones y procedimientos de Generales "

    Public Function ValTBox(ByVal TxtBoxTexto As String) As Double

        Return Val(TxtBoxTexto.Replace("$", "").Replace(",", ""))

    End Function

    Public Function HoraLocalExacta() As Date

        ' obtenemos el ID corresp a la zona horaria de la cd de mexico
        Dim cstZone As TimeZoneInfo = TimeZoneInfo.FindSystemTimeZoneById("Central Standard Time (Mexico)")
        ' convertimos la hora del servidor del hosting, a la hora universal standard
        Dim mFechaLocal As Date = TimeZoneInfo.ConvertTimeToUtc(Now)
        ' finalmente, convertimos la hora universal standard a la hora de la cd de mexico. Usando el ID corresp a la zona
        Return TimeZoneInfo.ConvertTimeFromUtc(mFechaLocal, cstZone)

    End Function

    ' De la cadena de permisos de una opcion de menu, extrae un permiso en particular.
    ' Regresa verdadero si se cuenta con el permiso
    Public Function TieneElPermiso(ByVal TipoPermiso As Permisos, ByVal CadenaPermisos As String) As Boolean

        Dim mRes As Boolean = (Mid(CadenaPermisos, TipoPermiso + 1, 1) = "1")

        Return mRes

    End Function

#End Region


#Region " Funciones y procedimiento para: Validacion y/o Creacion de Carpetas de archivos de imagenes, documentos y videos "

    ' regresa el nombre de la carpeta raiz para todos los arch de medios de los clientes: fotos, docum, pdf, videos
    Public Function NombreCarpetaRaizArchCtes(ByVal IncluirRuta As Boolean) As String

        If IncluirRuta Then
            Return "~/ArchCtes"
        Else
            Return "ArchCtes"
        End If


    End Function

    ' regresa el nombre de la carpeta corresp a una empresa (cte usuario de symio) 
    Public Function NombreCarpetaEmpresa(ByVal EmpresaID As Int32, ByVal IncluirRuta As Boolean) As String

        If IncluirRuta Then
            Return NombreCarpetaRaizArchCtes(True) & "/Emp" & Format(EmpresaID, "000000")
        Else
            Return "Emp" & Format(EmpresaID, "000000")
        End If

    End Function

    ' regresa el nombre de la carpeta corresp a un articulo
    Public Function NombreCarpetaArticulo(ByVal ArticuloID As Int32, ByVal EmpresaID As Int32, ByVal IncluirRuta As Boolean) As String

        If IncluirRuta Then
            Return NombreCarpetaEmpresa(EmpresaID, True) & "/Art" & Format(ArticuloID, "000000")
        Else
            Return "/Art" & Format(ArticuloID, "000000")
        End If

    End Function


    ' crea una carpeta. Primero valida si ya existe
    Public Sub CrearCarpeta(ByVal mRuta As String)

        ' Verificamos si existe la carpeta
        ' Nota: La ruta ya debe venir en forma fisica. El parametro se debe pasar por la funcion: Server.MapPath  
        Dim di As DirectoryInfo = New DirectoryInfo(mRuta)

        If Not di.Exists Then

            di.Create()

        End If


    End Sub

#End Region

#Region " Funciones y procedimiento para: Validacion y/o Creacion de Carpetas de archivos de Ayuda "

    ' regresa el nombre de la carpeta raiz para todos los arch de Ayuda SYMIO
    Public Function NombreCarpetaRaizArchAyuda(ByVal IncluirRuta As Boolean) As String

        If IncluirRuta Then
            Return "~/Ayuda"
        Else
            Return "Ayuda"
        End If

    End Function

    ' regresa el nombre de la carpeta raiz para todos los arch PDF de Ayuda SYMIO
    Public Function NombreCarpetaArchAyudaPDF(ByVal IncluirRuta As Boolean) As String

        If IncluirRuta Then
            Return "~/Ayuda/PDF"
        Else
            Return "Ayuda/PDF"
        End If

    End Function

    ' regresa el nombre de la carpeta raiz para todos los arch PDF de Ayuda SYMIO
    Public Function NombreCarpetaArchAyudaVideos(ByVal IncluirRuta As Boolean) As String

        If IncluirRuta Then
            Return "~/Ayuda/Videos"
        Else
            Return "Ayuda/Videos"
        End If

    End Function

#End Region


#Region " Funciones para convertir importes en LETRA "


    ' 
    ' Esta función recibe un número y devuelve una cadena de caracteres conteniendo el texto correspondiente al número recibido.
    ' Los decimales (centavos) se colocan literalmente al final de la cadena con el formato xx/100 (xx son los dígitos del valor decimal).
    ' La función "habla" sobre todo en número de más de miles de millones.
    Public Function ConvertirImporteEnLetras(ByVal nCifra As Decimal, ByVal nMonedaPlural As String, ByVal nMonedaSiglas As String) As String
        ' Defino variables
        Dim cifra, bloque, decimales, cadena As String
        'Dim longituid, posision, unidadmil As Byte
        Dim posision, unidadmil As Byte

        ' En caso de que unidadmil sea:
        ' 0 = cientos
        ' 1 = miles
        ' 2 = millones
        ' 3 = miles de millones
        ' 4 = billones
        ' 5 = miles de billones

        ' Reemplazo el símbolo decimal por un punto (.) y luego guardo la parte entera y la decimal por separado
        ' Es necesario poner el cero a la izquierda del punto así si el valor es de sólo decimales, se lo fuerza
        ' a colocar el cero para que no genere error
        cifra = Format(CType(nCifra, Decimal), "###############0.#0")
        decimales = Mid(cifra, Len(cifra) - 1, 2)
        cifra = Left(cifra, Len(cifra) - 3)

        ' Verifico que el valor no sea cero
        If cifra = "0" Then
            Return IIf(decimales = "00", "cero", "cero " & nMonedaPlural & " " & decimales & "/100 " & nMonedaSiglas).ToString
        End If

        ' Evaluo su longitud (como mínimo una cadena debe tener 3 dígitos)
        If Len(cifra) < 3 Then
            cifra = Rellenar(cifra, 3)
        End If

        ' Invierto la cadena
        cifra = Invertir(cifra)

        ' Inicializo variables
        posision = 1
        unidadmil = 0
        cadena = ""

        ' Selecciono bloques de a tres cifras empezando desde el final (de la cadena invertida)
        Do While posision <= Len(cifra)
            ' Selecciono una porción del numero
            bloque = Mid(cifra, posision, 3)

            ' Transformo el número a cadena
            cadena = Convertir(bloque, unidadmil) & " " & cadena.Trim

            ' Incremento la cantidad desde donde seleccionar la subcadena
            posision = posision + CType(3, Byte)

            ' Incremento la posisión de la unidad de mil
            unidadmil = unidadmil + CType(1, Byte)
        Loop

        ' Cargo la función
        'Return IIf(decimales = "00", cadena.Trim.ToLower, cadena.Trim.ToLower & " pesos " & decimales & "/100").ToString

        Return (cadena.Trim & " " & nMonedaPlural & " " & decimales & "/100 " & nMonedaSiglas).ToLower

    End Function

    ' Esta función es complemento de la función de conversión.
    ' En los arrays se agrega una posisión inicial vacía ya que VB.NET empieza de la posisión cero
    Private Function Convertir(ByVal cadena As String, ByVal unidadmil As Byte) As String
        ' Defino variables
        Dim centena, decena, unidad As Byte

        ' Invierto la subcadena (la original habia sido invertida en el procedimiento NumeroATexto)
        cadena = Invertir(cadena)

        ' Determino la longitud de la cadena
        If Len(cadena) < 3 Then
            cadena = Rellenar(cadena, 3)
        End If

        ' Verifico que la cadena no esté vacía (000)
        If cadena = "000" Then
            Return ""
        End If

        ' Desarmo el numero (empiezo del dígito cero por el manejo de cadenas de VB.NET)
        centena = CType(cadena.Substring(0, 1), Byte)
        decena = CType(cadena.Substring(1, 1), Byte)
        unidad = CType(cadena.Substring(2, 1), Byte)
        cadena = ""

        ' Calculo las centenas
        If centena <> 0 Then
            Dim centenas() As String = {"", IIf(decena = 0 And unidad = 0, "cien", "ciento").ToString, "doscientos", "trescientos", "cuatrocientos", "quinientos", "seiscientos", "setecientos", "ochocientos", "novecientos"}
            cadena = centenas(centena)
        End If

        ' Calculo las decenas
        If decena <> 0 Then
            Dim decenas() As String = {"", IIf(unidad = 0, "diez", IIf(unidad >= 6, "dieci", IIf(unidad = 1, "once", IIf(unidad = 2, "doce", IIf(unidad = 3, "trece", IIf(unidad = 4, "catorce", "quince")))))).ToString, IIf(unidad = 0, "veinte", "venti").ToString, "treinta", "cuarenta", "cincuenta", "sesenta", "setenta", "ochenta", "noventa"}
            cadena = cadena & " " & decenas(decena)
        End If

        ' Calculo las unidades (no pregunten por que este IF es necesario ... simplemente funciona)
        If decena = 1 And unidad < 6 Then
        Else
            Dim unidades() As String = {"", IIf(decena <> 1, IIf(unidadmil = 1, "un", "uno"), "").ToString, "dos", "tres", "cuatro", "cinco", "seis", "siete", "ocho", "nueve"}
            If decena >= 3 And unidad <> 0 Then
                cadena = cadena.Trim & " y "
            End If

            If decena = 0 Then
                cadena = cadena.Trim & " "
            End If
            cadena = cadena & unidades(unidad)
        End If

        ' Evaluo la posision de miles, millones, etc
        If unidadmil <> 0 Then
            Dim agregado() As String = {"", "mil", IIf((centena = 0) And (decena = 0) And (unidad = 1), "millón", "millones").ToString, "mil millones", "billones", "mil billones"}
            If (centena = 0) And (decena = 0) And (unidad = 1) And unidadmil = 2 Then
                cadena = "un"
            End If
            cadena = cadena & " " & agregado(unidadmil)
        End If

        ' Cargo la función
        Return cadena.Trim
    End Function

    ' Esta función recibe una cadena de caracteres y la devuelve "invertida".
    Public Function Invertir(ByVal cadena As String) As String
        ' Defino variables
        Dim retornar As String = ""

        ' Inviero la cadena
        For posision As Int32 = Len(cadena) To 1 Step -1
            retornar = retornar & cadena.Substring(posision - 1, 1).ToString
        Next

        ' Retorno la cadena invertida
        Return retornar
    End Function

    ' Esta función rellena con ceros a la izquierda un número pasado como parámetro. Con el parámetro "cifras" se especifica la cantidad de dígitos a la izquierda.
    Public Function Rellenar(ByVal valor As Object, ByVal cifras As Byte) As String
        ' Defino variables
        Dim cadena As String

        ' Verifico el valor pasado
        If Not IsNumeric(valor) Then
            valor = 0
        Else
            valor = CType(valor, Integer)
        End If

        ' Cargo la cadena
        cadena = valor.ToString.Trim

        ' Relleno con los ceros que sean necesarios para llenar los dígitos pedidos
        For puntero As Int32 = (Len(cadena) + 1) To cifras
            cadena = "0" & cadena
        Next puntero

        ' Cargo la función
        Return cadena
    End Function

#End Region

#Region " Funciones - VALIDACION DE ACCESO A USUARIOS - POR DIA Y HORA "

    Public Function LoginTienePermisoAccesoDia(ByVal pDiaSemana As Int32, ByVal pCadenaPermisos As String) As Boolean

        '  1111001

        Dim mPermiso As String = Mid(pCadenaPermisos, pDiaSemana, 1)

        Return (mPermiso = "1")

    End Function

    Public Function LoginHoraInicioDia(ByVal pDiaSemana As Int32, ByVal pCadenaHorarios As String) As String

        '  09001800 09301630 10301600

        Dim mHoraIni As String = Mid(pCadenaHorarios, (pDiaSemana - 1) * 8 + 1, 4)


        Return Mid(mHoraIni, 1, 2) & ":" & Mid(mHoraIni, 3, 2)


    End Function

    Public Function LoginHoraFinalDia(ByVal pDiaSemana As Int32, ByVal pCadenaHorarios As String) As String

        '  09001800 09301630 10301600 09301630 09001800 09001800 10301600

        Dim mHoraIni As String = Mid(pCadenaHorarios, (pDiaSemana - 1) * 8 + 5, 4)

        Return Mid(mHoraIni, 1, 2) & ":" & Mid(mHoraIni, 3, 2)

    End Function

#End Region

End Module

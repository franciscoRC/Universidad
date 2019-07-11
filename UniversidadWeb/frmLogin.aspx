<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="frmLogin.aspx.vb" Inherits="UniversidadWeb.frmLogin" %>

<%@ Register assembly="DevExpress.Web.v18.1, Version=18.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<%--<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
    </form>
</body>
</html>--%>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Login</title>

    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="AdminLTE/bower_components/bootstrap/dist/css/bootstrap.min.css"/>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="AdminLTE/bower_components/font-awesome/css/font-awesome.min.css"/>
    <!-- Ionicons -->
    <link rel="stylesheet" href="AdminLTE/bower_components/Ionicons/css/ionicons.min.css"/>
    <!-- Theme style -->
    <link rel="stylesheet" href="AdminLTE/dist/css/AdminLTE.min.css"/>
    <!-- iCheck -->
    <link rel="stylesheet" href="AdminLTE/plugins/iCheck/square/blue.css"/>
</head>
<body class="hold-transition login-page">
<div class="login-box">
  <div class="login-logo">
    <a href="index2.html"><b>Universidades</b>LTE</a>
  </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
    <p class="login-box-msg">Bienvenido</p>

      <form id="formPrincipal" runat="server">
      <div class="form-group has-feedback">

       <%-- <input type="email" class="form-control" placeholder="Correo"/>
        <span class="glyphicon glyphicon-envelope form-control-feedback"></span>--%>
          <dx:ASPxTextBox ID="txtLogin" runat="server" Width="100%"></dx:ASPxTextBox>
        <%-- <label for="txtUsuario" class="h4" >Usuario o email:</label>--%>
        <%-- <dx:ASPxTextBox ID="txtUsuario" runat="server" CssClass ="form-control" Width="100%"  Font-Size="Small" AutoCompleteType="Disabled">
        </dx:ASPxTextBox>--%>
      </div>
      <div class="form-group has-feedback">
           <dx:ASPxTextBox ID="txtContrasena" runat="server" Width="100%"></dx:ASPxTextBox>
        <%--<input type="password" class="form-control" placeholder="Contraseña"/>--%>
       <%-- <span class="glyphicon glyphicon-lock form-control-feedback"></span>--%>
      </div>
      <div class="row">
        <div class="col-xs-8">
          <div class="checkbox icheck">
            <label>
              <input type="checkbox"/> Recuerdame
            </label>
          </div>
        </div>
        <!-- /.col -->
        <div class="col-xs-4">
          <%--<button type="submit" class="btn btn-primary btn-block btn-flat">Entrar</button>--%>
          <asp:Button ID="btnEntrar" runat="server" Text="Entrar" CssClass="btn btn-login btn-block" />
           
        </div>
      </div>
          <div class="row">
               <dx:ASPxLabel CssClass="text-danger" Font-Size="Medium" Font-Bold="true" ID="lblError" runat="server" Text="Revise sus datos no son correctos"></dx:ASPxLabel>
          </div>
      </form>

    <%--<div class="social-auth-links text-center">
      <p>- OR -</p>
      <a href="#" class="btn btn-block btn-social btn-facebook btn-flat"><i class="fa fa-facebook"></i> Sign in using
        Facebook</a>
      <a href="#" class="btn btn-block btn-social btn-google btn-flat"><i class="fa fa-google-plus"></i> Sign in using
        Google+</a>
    </div>--%>
    <!-- /.social-auth-links -->

    <%--<a href="#">I forgot my password</a><br>
    <a href="register.html" class="text-center">Register a new membership</a>--%>

  </div>
  <!-- /.login-box-body -->
</div>
<!-- /.login-box -->

<!-- jQuery 3 -->
<script src="AdminLTE/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="AdminLTE/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- iCheck -->
<script src="AdminLTE/plugins/iCheck/icheck.min.js"></script>
<script>
  $(function () {
    $('input').iCheck({
      checkboxClass: 'icheckbox_square-blue',
      radioClass: 'iradio_square-blue',
      increaseArea: '20%' /* optional */
    });
  });
</script>
    
</body>
</html>

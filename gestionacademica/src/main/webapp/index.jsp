<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String msgError = (String) session.getAttribute("msgError"); %>

<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="css/index.css">
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <script src="js/showError.js"></script>

  <title>Inicio de Sesión</title>
</head>
<body <% if (msgError != null) {%>
        onload="showError('<%=msgError%>')"
        <% }
          session.removeAttribute("msgError");
        %>>

<section>
  <div class="form-box">
    <div class="form-value">
      <form method="post" action="<%=request.getContextPath()%>/login?action=login">

        <h2>Login</h2>

        <div class="inputbox">
          <ion-icon name="mail-outline"></ion-icon>
          <input type="email" name="correo" required>
          <label for="">Usuario</label>
        </div>

        <div class="inputbox">
          <ion-icon name="lock-closed-outline"></ion-icon>
          <input type="password" name="password" id="contrasena" required>
          <label for="">Contraseña</label>
        </div>

        <div class="form-check">
          <input class="form-check-input" type="checkbox" id="mostrarContrasena" >
          <label style="color:#ffffff" class="form-check-label" for="flexCheckDefault">Mostrar contraseña</label>
        </div>

        <br>

        <button type="submit">Ingresar</button>

      </form>
    </div>
  </div>
</section>


<script>
  document.getElementById("mostrarContrasena").addEventListener("change", function() {
    var contrasenaInput = document.getElementById("contrasena");
    if (this.checked) {
      contrasenaInput.type = "text";
    } else {
      contrasenaInput.type = "password";
    }
  });
</script>
<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>

</body>
</html>
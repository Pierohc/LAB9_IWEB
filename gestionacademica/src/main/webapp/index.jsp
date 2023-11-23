<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="css/index.css">

  <title>JSP - Hello World</title>
</head>
<body>

<section>
  <div class="form-box">
    <div class="form-value">
      <form method="post" action="/login">

        <h2>Login</h2>

        <div class="inputbox">
          <ion-icon name="mail-outline"></ion-icon>
          <input type="email" name="correo" required>
          <label for="">Usuario</label>
        </div>

        <div class="inputbox">
          <ion-icon name="lock-closed-outline"></ion-icon>
          <input type="password" name="password" required>
          <label for="">Contraseña</label>
        </div>

        <button type="submit">Ingresar</button>

      </form>
    </div>
  </div>
</section>



<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>

</body>
</html>
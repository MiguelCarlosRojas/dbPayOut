<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Bienvenido a la Aplicación de Usuarios</title>
  <style>
    body {
      padding: 20px;
      text-align: center;
      font-size: 18px;
    }

    .welcome {
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 10px;
    }
  </style>
</head>
  <jsp:include page="menu.jsp" />
<body>
  <div class="welcome">Bienvenido a la Aplicación de Usuarios</div>
  <p>¡Hola, Usuario! Aquí encontrarás información sobre los usuarios registrados en la plataforma.</p>
</body>
</html>
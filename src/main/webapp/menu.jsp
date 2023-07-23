<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Menú de Barra Lateral</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    /* Estilos personalizados */
    body {
      background-color: #f8f9fa; /* Color de fondo predeterminado */
    }

    .wrapper {
      display: flex;
    }

    .sidebar {
      position: fixed;
      top: 0;
      left: 0;
      width: 250px;
      height: 100vh;
      background-color: #000; /* Color de fondo de la barra lateral (negro) */
      padding: 20px;
      transition: transform 0.3s;
      transform: translateX(-100%);
      z-index: 999;
    }

    .sidebar.show {
      transform: translateX(0);
    }

    .sidebar .close-btn {
      position: absolute;
      top: 10px;
      right: 10px;
      cursor: pointer;
      color: #fff; /* Color de la X (blanco) */
    }

    .sidebar .menu {
      margin-top: 30px;
    }

    .sidebar .menu a {
      display: flex;
      align-items: center;
      color: #fff; /* Color de texto de los enlaces en la barra lateral (blanco) */
      text-decoration: none;
      padding: 10px 0;
      padding-left: 20px; /* Aumentar el espacio izquierdo */
      transition: background-color 0.3s;
    }

    .sidebar .menu a:hover {
      background-color: #e9ecef;
      color: #000; /* Color de texto al pasar el ratón sobre los enlaces en la barra lateral (negro) */
      padding-left: 30px; /* Aumentar el espacio izquierdo al pasar el ratón */
    }

    .sidebar .menu i {
      margin-right: 10px;
    }

    .sidebar .submenu {
      padding-left: 15px;
      display: none;
    }

    .sidebar .submenu a {
      padding: 5px 0;
      padding-left: 30px; /* Aumentar el espacio izquierdo para los enlaces del submenú */
    }

    .sidebar .submenu.show {
      display: block;
    }

    .toggle-btn {
      background-color: transparent;
      border: none;
      cursor: pointer;
      outline: none;
      z-index: 999;
    }
  </style>
</head>
<body>
  <div class="wrapper">
    <div class="sidebar">
      <i class="fas fa-times close-btn"></i>
      <div class="menu">
        <a href="contenido.jsp"><i class="fas fa-home"></i> Inicio</a>
        <a href="#"><i class="fas fa-user"></i> Perfil</a>
        <a href="#" class="has-submenu"><i class="fas fa-tools"></i> Administrador</a>
        <div class="submenu">
          <a href="edit.jsp"><i class="fas fa-users"></i> Usuarios</a>
          <a href="#"><i class="fas fa-money-check-alt"></i> Pagos</a> <!-- Cambiar el icono de Pago -->
        </div>
        <a href="#" class="has-submenu"><i class="fas fa-history"></i> Transferencias</a> <!-- Cambiar el nombre y el icono de Préstamos -->
        <div class="submenu">
          <a href="gestionPlazos.jsp"><i class="fas fa-clock"></i> Plazo</a> <!-- Cambiar el icono de Reserva -->
          <a href="#"><i class="fas fa-exclamation-circle"></i> Venció</a> <!-- Cambiar el icono de Devolución -->
        </div>
        <a href="#"><i class="fas fa-cog"></i> Configuración</a>
        <a href="index.jsp"><i class="fas fa-sign-out-alt"></i> Salir</a>
      </div>
    </div>
  </div>

  <button class="toggle-btn"><i class="fas fa-bars"></i></button>

  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <script>
    $(document).ready(function() {
      // Mostrar menú al hacer clic en el ícono de apertura
      $('.toggle-btn').click(function() {
        $('.sidebar').toggleClass('show');
      });

      // Ocultar menú al hacer clic en el ícono de cierre
      $('.close-btn').click(function() {
        $('.sidebar').removeClass('show');
      });

      // Mostrar/ocultar submenús
      $('.has-submenu').click(function() {
        $(this).toggleClass('active');
        $(this).next('.submenu').toggleClass('show');
      });
    });
  </script>
</body>
</html>
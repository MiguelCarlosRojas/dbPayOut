<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Inactivar Persona</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            padding: 0;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .content {
            max-width: 400px;
            text-align: center;
        }

        .loading {
            margin-bottom: 20px;
        }

        .loading::after {
            content: "";
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 2px solid #999999;
            border-top-color: #333333;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        .success-message {
            color: green;
            margin-bottom: 20px;
        }

        .redirect-message {
            font-style: italic;
        }

        .redirect-message::before {
            content: "Serás redirigido automáticamente en ";
        }

        .redirect-countdown {
            display: inline-block;
            font-weight: bold;
            animation: countdown 1s steps(10, end) infinite;
        }

        @keyframes spin {
            to {
                transform: rotate(360deg);
            }
        }

        @keyframes countdown {
            0% {
                content: "3";
            }
            33% {
                content: "2";
            }
            66% {
                content: "1";
            }
            100% {
                content: "0";
            }
        }
    </style>
    <script>
        setTimeout(function() {
            window.location.href = "<%= request.getHeader("referer") %>";
        }, 3000); // Redirigir después de 3 segundos (3000 milisegundos)
    </script>
</head>
<body>
    <div class="content">
        <%
            Connection con = null;
            PreparedStatement ps = null;
            boolean isSuccessful = true; // Variable para indicar si la actualización fue exitosa

            try {
                // Establecer la conexión con SQL Server
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                String url = "jdbc:sqlserver://localhost:1433;databaseName=dbPayOut;encrypt=true;TrustServerCertificate=True;user=sa;password=miguelangel";
                con = DriverManager.getConnection(url);

                // Obtener el ID de la persona a inactivar desde los parámetros de la URL
                int id = Integer.parseInt(request.getParameter("id"));

                // Mostrar animación de carga
                out.println("<div class=\"loading\"></div>");

                // Actualizar el estado de la persona a inactivo
                String query = "UPDATE person SET active = 'I' WHERE id = ?";
                ps = con.prepareStatement(query);
                ps.setInt(1, id);
                ps.executeUpdate();
            } catch (Exception e) {
                isSuccessful = false;
            } finally {
                // Cerrar la conexión y la consulta preparada
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            }
        %>

        <% if (isSuccessful) { %>
            <div class="success-message">&#10004; Persona inactivada exitosamente</div>
        <% } else { %>
            <div class="error-message">Error al inactivar la persona</div>
        <% } %>

        <div class="redirect-message"> <span class="redirect-countdown">3</span> segundos...</div>
    </div>

    <script>
        // Actualizar el contador de redirección cada segundo
        var countdownElement = document.querySelector(".redirect-countdown");
        var countdown = 3; // Iniciar el contador en 3 segundos

        setInterval(function() {
            countdown--;
            countdownElement.textContent = countdown;

            if (countdown === 0) {
                clearInterval();
            }
        }, 1000);
    </script>
</body>
</html>

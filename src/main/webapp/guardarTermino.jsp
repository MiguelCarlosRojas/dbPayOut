<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Guardar el Plazo</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            padding: 180px;
        }

        h1 {
            text-align: center;
        }

        .success-message {
            text-align: center;
            font-weight: bold;
            margin-top: 20px;
        }

        .error-message {
            text-align: center;
            font-weight: bold;
            color: red;
            margin-top: 20px;
        }

        .button-container {
            text-align: center;
            margin-top: 20px;
        }

        .button-container a {
            background-color: #2196f3;
            color: #ffffff;
            border: none;
            border-radius: 3px;
            padding: 5px 10px;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <h1>Guardar el Plazo</h1>

    <% 
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            // Establecer la conexión con SQL Server
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            String url = "jdbc:sqlserver://localhost:1433;databaseName=dbPayOut;encrypt=true;TrustServerCertificate=True;user=sa;password=miguelangel";
            con = DriverManager.getConnection(url);

            // Obtener los parámetros enviados por el formulario POST
            int personId = Integer.parseInt(request.getParameter("personId"));
            String dateTerm = request.getParameter("dateTerm");
            String status = request.getParameter("status");

            // Insertar el término en la tabla "term"
            String query = "INSERT INTO term (person_id, date_term, status) VALUES (?, ?, ?)";
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, personId);
            pstmt.setString(2, dateTerm);
            pstmt.setString(3, status);
            pstmt.executeUpdate();

            // Mostrar mensaje de éxito
            out.println("<div class=\"success-message\">El Plazo se ha guardado correctamente.</div>");
        } catch (Exception e) {
            // Mostrar mensaje de error
            out.println("<div class=\"error-message\">Error al guardar el Plazo: " + e.getMessage() + "</div>");
        } finally {
            // Cerrar la conexión y la declaración
            if (pstmt != null) {
                pstmt.close();
            }
            if (con != null) {
                con.close();
            }
        }
    %>

    <div class="button-container">
        <a href="gestionPlazos.jsp">Volver al Listado</a>
    </div>
</body>
</html>

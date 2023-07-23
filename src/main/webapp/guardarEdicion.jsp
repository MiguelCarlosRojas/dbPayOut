<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Guardar Edición</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
        }

        .success-message {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background-color: #4caf50;
            color: #ffffff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            animation: fade-in 0.5s ease-in-out;
        }

        .success-icon {
            width: 50px;
            height: 50px;
            background-color: #ffffff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 10px;
        }

        .success-icon::before {
            content: '\2713';
            font-size: 30px;
            color: #4caf50;
        }

        .success-message p {
            margin: 0;
            font-size: 18px;
            text-align: center;
        }

        @keyframes fade-in {
            0% { opacity: 0; transform: translateY(-20px); }
            100% { opacity: 1; transform: translateY(0); }
        }
    </style>
    <script>
        setTimeout(function() {
            window.location.href = "edit.jsp";
        }, 5000);
    </script>
</head>
<body>
    <div class="success-message">
        <div class="success-icon"></div>
        <p>Los cambios se han guardado exitosamente.</p>
        <p>Redirigiendo al listado de personas...</p>
    </div>

    <%-- Tu código Java para guardar los cambios aquí --%>
        <%
        Connection con = null;
        PreparedStatement ps = null;

        try {
            // Establecer la conexión con SQL Server
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            String url = "jdbc:sqlserver://localhost:1433;databaseName=dbPayOut;encrypt=true;TrustServerCertificate=True;user=sa;password=miguelangel";
            con = DriverManager.getConnection(url);

            // Obtener los datos enviados por el formulario
            int id = Integer.parseInt(request.getParameter("id"));
            String names = request.getParameter("names");
            String lastName = request.getParameter("lastName");
            String typeDocument = request.getParameter("typeDocument");
            String numberDocument = request.getParameter("numberDocument");
            String email = request.getParameter("email");
            String cellPhone = request.getParameter("cellPhone");
            String career = request.getParameter("career");
            String semester = request.getParameter("semester");

            // Actualizar los datos de la persona en la base de datos
            String query = "UPDATE person SET names = ?, last_name = ?, type_document = ?, number_document = ?, email = ?, cell_phone = ?, career = ?, semester = ? WHERE id = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, names);
            ps.setString(2, lastName);
            ps.setString(3, typeDocument);
            ps.setString(4, numberDocument);
            ps.setString(5, email);
            ps.setString(6, cellPhone);
            ps.setString(7, career);
            ps.setString(8, semester);
            ps.setInt(9, id);
            ps.executeUpdate();
        } catch (Exception e) {
            // Mostrar mensaje de error en caso de fallo
            out.println("<p>Error al guardar los cambios: " + e.getMessage() + "</p>");
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
</body>
</html>

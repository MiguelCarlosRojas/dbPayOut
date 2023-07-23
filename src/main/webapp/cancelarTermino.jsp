<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cancelación de Plazos</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            padding: 180px;
        }

        h1 {
            text-align: center;
        }

        .message {
            text-align: center;
            margin-bottom: 20px;
        }

        .btn-container {
            text-align: center;
        }

        .home-btn {
            background-color: #2196f3;
            color: #ffffff;
            border: none;
            border-radius: 3px;
            padding: 5px 10px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h1>Cancelación del Plazo</h1>

    <% 
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            // Establecer la conexión con SQL Server
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            String url = "jdbc:sqlserver://localhost:1433;databaseName=dbPayOut;encrypt=true;TrustServerCertificate=True;user=sa;password=miguelangel";
            con = DriverManager.getConnection(url);

            // Obtener el ID del término a cancelar de la URL
            int termId = Integer.parseInt(request.getParameter("id"));

            // Actualizar el campo "status" del término a "CA" (Cancelado)
            String updateQuery = "UPDATE term SET status = 'CA' WHERE id = ?";
            pstmt = con.prepareStatement(updateQuery);
            pstmt.setInt(1, termId);
            int rowsAffected = pstmt.executeUpdate();

            // Verificar si se actualizó correctamente el término
            if (rowsAffected > 0) {
                out.println("<div class=\"message\">El Plazo ha sido cancelado exitosamente.</div>");
            } else {
                out.println("<div class=\"message\">No se pudo cancelar el Plazo. Por favor, inténtalo nuevamente.</div>");
            }
        } catch (Exception e) {
            out.println("<div class=\"message\">Error al cancelar el Plazo: " + e.getMessage() + "</div>");
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

    <div class="btn-container">
        <button class="home-btn" onclick="window.location.href = 'gestionPlazos.jsp'">Volver al Listado</button>
    </div>
</body>
</html>
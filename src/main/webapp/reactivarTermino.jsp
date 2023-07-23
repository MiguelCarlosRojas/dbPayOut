<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reactivar Plazos</title>
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

        .back-btn-container {
            display: flex;
            justify-content: center;
        }

        .back-btn {
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
    <h1>Reactivar Plazos</h1>

    <div class="message">
        <% 
            Connection con = null;
            PreparedStatement pstmt = null;

            try {
                // Establecer la conexión con SQL Server
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                String url = "jdbc:sqlserver://localhost:1433;databaseName=dbPayOut;encrypt=true;TrustServerCertificate=True;user=sa;password=miguelangel";
                con = DriverManager.getConnection(url);

                // Obtener el ID del término y el estado a reactivar desde la URL
                int termId = Integer.parseInt(request.getParameter("id"));
                String estado = request.getParameter("estado");

                // Actualizar el estado del término a "Pendiente" (PE)
                String updateQuery = "UPDATE term SET status = 'PE' WHERE id = ?";
                pstmt = con.prepareStatement(updateQuery);
                pstmt.setInt(1, termId);
                int rowsUpdated = pstmt.executeUpdate();

                if (rowsUpdated > 0) {
                    out.println("<p>El Plazo ha sido reactivado exitosamente.</p>");
                } else {
                    out.println("<p>No se pudo reactivar el Plazo.</p>");
                }
            } catch (Exception e) {
                out.println("<p>Error al reactivar el Plazo: " + e.getMessage() + "</p>");
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
    </div>

    <div class="back-btn-container">
        <div class="back-btn" onclick="window.location.href = 'gestionPlazos.jsp'">Volver al Listado</div>
    </div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestión de Plazos</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            padding: 20px;
        }

        h1 {
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 10px;
            border: 1px solid #ccc;
        }

        th {
            background-color: #f0f0f0;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .button-container {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 10px;
        }

        .create-btn,
        .cancel-btn,
        .reactivate-btn {
            background-color: #2196f3;
            color: #ffffff;
            border: none;
            border-radius: 3px;
            padding: 5px 10px;
            cursor: pointer;
            margin-left: 10px;
        }

        .cancel-btn {
            background-color: #f44336; /* Color rojo */
        }

        .hidden {
            display: none;
        }
    </style>
    <script>
        function cancelTerm(id) {
            if (confirm("¿Estás seguro de cancelar este Plazo?")) {
                // Redireccionar a la página de cancelación con el ID del término y el estado "CA" (Cancelado)
                window.location.href = "cancelarTermino.jsp?id=" + id + "&estado=CA";
            }
        }

        function reactivateTerm(id) {
            if (confirm("¿Estás seguro de reactivar este Plazo?")) {
                // Redireccionar a la página de reactivación con el ID del término y el estado "PE" (Pendiente)
                window.location.href = "reactivarTermino.jsp?id=" + id + "&estado=PE";
            }
        }
    </script>
</head>
<jsp:include page="menu.jsp" />
<body>
    <h1>Gestión de Plazos</h1>

    <div class="button-container">
        <button class="create-btn" onclick="window.location.href = 'crearTermino.jsp'">Crear Plazo</button>
    </div>

    <table>
        <tr>
            <th>ID</th>
            <th>Nombres</th>
            <th>Apellido</th>
            <th>Fecha de Plazo</th>
            <th>Estado</th>
            <th>Acciones</th>
        </tr>

        <% 
            Connection con = null;
            Statement stmt = null;

            try {
                // Establecer la conexión con SQL Server
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                String url = "jdbc:sqlserver://localhost:1433;databaseName=dbPayOut;encrypt=true;TrustServerCertificate=True;user=sa;password=miguelangel";
                con = DriverManager.getConnection(url);

                // Ejecutar la consulta para obtener los datos de la tabla "term" y "person"
                String query = "SELECT t.id, p.names, p.last_name, t.date_term, t.status " +
                               "FROM term t " +
                               "INNER JOIN person p ON t.person_id = p.id " +
                               "WHERE t.active = 'A'";
                stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(query);

                // Iterar sobre los resultados y mostrarlos en la tabla
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String names = rs.getString("names");
                    String lastName = rs.getString("last_name");
                    Date dateTerm = rs.getDate("date_term");
                    String status = rs.getString("status");

                    String statusText = "";
                    if (status.equals("PE")) {
                        statusText = "Pendiente";
                    } else if (status.equals("CA")) {
                        statusText = "Cancelado";
                    }

                    out.println("<tr>");
                    out.println("<td>" + id + "</td>");
                    out.println("<td>" + names + "</td>");
                    out.println("<td>" + lastName + "</td>");
                    out.println("<td>" + dateTerm + "</td>");
                    out.println("<td>" + statusText + "</td>");
                    out.println("<td>");
                    // Si el plazo está "Pendiente", muestra el botón de cancelar
                    if (status.equals("PE")) {
                        out.println("<button class=\"cancel-btn\" onclick=\"cancelTerm(" + id + ")\">Cancelado</button>");
                    } else if (status.equals("CA")) {
                        // Si el plazo está "Cancelado", muestra el botón de reactivar
                        out.println("<button class=\"reactivate-btn\" onclick=\"reactivateTerm(" + id + ")\">Pendiente</button>");
                    }
                    out.println("</td>");
                    out.println("</tr>");
                }
            } catch (Exception e) {
                out.println("<p>Error al obtener los datos de la tabla: " + e.getMessage() + "</p>");
            } finally {
                // Cerrar la conexión y la declaración
                if (stmt != null) {
                    stmt.close();
                }
                if (con != null) {
                    con.close();
                }
            }
        %>
    </table>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestión de Detail Term</title>
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

        .btn-container {
            text-align: center;
            margin-top: 20px;
        }

        .home-btn {
            background-color: #2196f3;
            color: #ffffff;
            border: none;
            border-radius: 3px;
            padding: 5px 10px;
            cursor: pointer;
        }

        .create-btn {
            background-color: #4caf50;
            color: #ffffff;
            border: none;
            border-radius: 3px;
            padding: 5px 10px;
            cursor: pointer;
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <h1>Gestión de Detail Term</h1>

    <table>
        <tr>
            <th>ID</th>
            <th>Término ID</th>
            <th>Payout ID</th>
            <th>Monto</th>
        </tr>

        <% 
            Connection con = null;
            Statement stmt = null;

            try {
                // Establecer la conexión con SQL Server
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                String url = "jdbc:sqlserver://localhost:1433;databaseName=dbPayOut;encrypt=true;TrustServerCertificate=True;user=sa;password=miguelangel";
                con = DriverManager.getConnection(url);

                // Ejecutar la consulta para obtener los datos de la tabla "detail_term"
                String query = "SELECT * FROM detail_term";
                stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(query);

                // Iterar sobre los resultados y mostrarlos en la tabla
                while (rs.next()) {
                    int id = rs.getInt("id");
                    int termId = rs.getInt("term_id");
                    int payoutId = rs.getInt("payout_id");
                    double amount = rs.getDouble("amount");

                    out.println("<tr>");
                    out.println("<td>" + id + "</td>");
                    out.println("<td>" + termId + "</td>");
                    out.println("<td>" + payoutId + "</td>");
                    out.println("<td>" + amount + "</td>");
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

    <div class="btn-container">
        <button class="create-btn" onclick="window.location.href = 'crearDetailTerm.jsp'">Crear Registro</button>
        <button class="home-btn" onclick="window.location.href = 'edit.jsp'">Volver al Listado</button>
    </div>
</body>
</html>

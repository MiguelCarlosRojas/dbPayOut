<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Crear Plazo</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            padding: 20px;
        }

        h1 {
            text-align: center;
        }

        form {
            max-width: 400px;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        .form-group .date-state {
            display: flex;
        }
        
        .form-group .date-state .date {
            flex: 1;
            margin-right: 5px;
        }
        
        .form-group .date-state .state {
            flex: 1;
            margin-left: 5px;
        }

        .form-group button {
            background-color: #2196f3;
            color: #ffffff;
            border: none;
            border-radius: 3px;
            padding: 5px 10px;
            cursor: pointer;
        }
        
        .form-group .back-btn {
            background-color: #f44336;
            color: #ffffff;
        }
    </style>
    <script>
        /* Script JavaScript para actualizar la fecha y volver a la página anterior */
        function updateDate() {
            var currentDate = new Date().toISOString().split("T")[0];
            document.getElementById("dateTerm").value = currentDate;
        }

        function goBack() {
            window.history.back();
        }
    </script>
</head>
  <jsp:include page="menu.jsp" />
<body onload="updateDate()">
    <h1>Crear Plazo</h1>

    <form action="guardarTermino.jsp" method="POST">
        <div class="form-group">
            <label for="personId">Usuarios:</label>
            <select id="personId" name="personId" required>
                <option value="" selected disabled>Elegir o seleccionar...</option>
                <% 
                    Connection con = null;
                    Statement stmt = null;

                    try {
                        // Establecer la conexión con SQL Server
                        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                        String url = "jdbc:sqlserver://localhost:1433;databaseName=dbPayOut;encrypt=true;TrustServerCertificate=True;user=sa;password=miguelangel";
                        con = DriverManager.getConnection(url);

                        // Ejecutar la consulta para obtener las personas
                        String query = "SELECT id, last_name, names FROM person";
                        stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery(query);

                        // Iterar sobre los resultados y mostrar las opciones en el select
                        while (rs.next()) {
                            int personId = rs.getInt("id");
                            String lastName = rs.getString("last_name");
                            String names = rs.getString("names");
                            out.println("<option value=\"" + personId + "\">" + lastName + ", " + names + "</option>");
                        }
                    } catch (Exception e) {
                        out.println("<option value=\"\">Error al obtener las personas</option>");
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
            </select>
        </div>
        <div class="form-group">
            <div class="date-state">
                <div class="date">
                    <label for="dateTerm">Fecha de Plazo:</label>
                    <input type="date" id="dateTerm" name="dateTerm" required readonly>
                </div>
                <div class="state">
                    <label for="status">Estado:</label>
                    <select id="status" name="status" required>
                        <option value="" selected disabled>Elegir el estado...</option>
                        <option value="PE">Pendiente</option>
                        <option value="CA">Cancelado</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="form-group">
            <button type="submit">Guardar</button>
            <button type="button" class="back-btn" onclick="goBack()">Volver</button>
        </div>
    </form>
</body>
</html>

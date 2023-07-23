<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Listado de Usuarios</title>
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
        .view-inactive-btn {
            background-color: #2196f3;
            color: #ffffff;
            border: none;
            border-radius: 3px;
            padding: 5px 10px;
            cursor: pointer;
            margin-left: 10px;
        }

        .search-form {
            margin-bottom: 10px;
        }

        .search-input {
            padding: 5px;
            width: 200px;
            margin-right: 10px;
        }

        .search-btn {
            background-color: #2196f3;
            color: #ffffff;
            border: none;
            border-radius: 3px;
            padding: 5px 10px;
            cursor: pointer;
        }
    </style>
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
        .view-inactive-btn {
            background-color: #2196f3;
            color: #ffffff;
            border: none;
            border-radius: 3px;
            padding: 5px 10px;
            cursor: pointer;
            margin-left: 10px;
        }
    </style>
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
        
        .hidden {
            display: none;
        }
        
        .edit-btn,
        .delete-btn {
            padding: 5px 10px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        
        .edit-btn {
            background-color: #4caf50;
            color: #ffffff;
        }
        
        .delete-btn {
            background-color: #f44336;
            color: #ffffff;
        }
        
        .create-btn,
        .view-inactive-btn {
            margin-bottom: 10px;
            background-color: #2196f3;
            color: #ffffff;
            border: none;
            border-radius: 3px;
            padding: 5px 10px;
            cursor: pointer;
        }
        
        .view-inactive-btn {
            margin-left: 10px;
        }
    </style>
    <style>
        /* Resto de estilos previos */

        .search-form {
            /* Alineación de la caja de búsqueda a la izquierda */
            display: flex;
            align-items: center;
            justify-content: flex-start;
            flex-wrap: wrap;
        }

        .search-form .search-input {
            /* Alineación de los campos de búsqueda */
            width: 200px;
            margin-right: 10px;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        .search-form .search-btn {
            /* Estilos del botón de búsqueda */
            background-color: #2196f3;
            color: #ffffff;
            border: none;
            border-radius: 3px;
            padding: 5px 10px;
            cursor: pointer;
        }

        .export-buttons {
            /* Alineación de los botones de exportación a la derecha */
            display: flex;
            align-items: center;
            justify-content: flex-end;
            flex-wrap: wrap;
        }

        .export-buttons .export-btn {
            /* Estilos generales para los botones de exportación */
            margin-left: 10px;
            background-color: #4caf50; /* Color verde para CSV */
            color: #ffffff;
            border: none;
            border-radius: 3px;
            padding: 5px 10px;
            cursor: pointer;
            text-decoration: none;
        }

        .export-buttons .export-btn:nth-child(2) {
            /* Color rojo para PDF */
            background-color: #f44336;
        }

        .export-buttons .export-btn:nth-child(3) {
            /* Color azul para XLSX */
            background-color: #2196f3;
        }

        /* Estilos para el espacio en blanco */
        .space {
            width: 238px;
        }
    </style>
    <style>
	    /* Resto de estilos previos */
	
	    .export-buttonss {
	        display: flex;
	        justify-content: center; /* Centrar horizontalmente los botones */
	        align-items: center;
	        margin-top: 20px; /* Agregar espacio en la parte superior */
	    }
	
	    .export-buttonss .export-btn {
	        margin: 5px; /* Agregar espacio entre los botones */
	        background-color: #4caf50;
	        color: #ffffff;
	        border: none;
	        border-radius: 3px;
	        padding: 5px 10px;
	        cursor: pointer;
	        text-decoration: none;
	    }
	
	    .export-buttonss .export-btn:nth-child(2) {
	        background-color: #f44336;
	    }
	
	    .export-buttonss .export-btn:nth-child(3) {
	        background-color: #2196f3;
	    }
	</style>    
    <script>
        function deletePerson(id) {
            if (confirm("¿Estás seguro de eliminar este registro?")) {
                // Redireccionar a la página de eliminación con el ID del registro
                window.location.href = "eliminarPersona.jsp?id=" + id;
            }
        }

        function viewInactive() {
            // Redireccionar a la página que muestra los registros inactivos
            window.location.href = "registrosInactivos.jsp";
        }
    </script>
</head>
  <jsp:include page="menu.jsp" />
<body>
    <h1>Listado de Usuarios</h1>

    <div class="button-container">
        <button class="create-btn" onclick="window.location.href = 'crearPersona.jsp'">Crear Usuario</button>
        <button class="view-inactive-btn" onclick="viewInactive()">Ver Inactivos</button>
    </div>

	<!-- Resto del código HTML -->
	<form class="search-form" action="edit.jsp" method="GET">
	    <input class="search-input" type="text" name="searchNames" placeholder="Buscar por nombres">
	    <input class="search-input" type="text" name="searchLastName" placeholder="Buscar por apellidos">
	    <input class="search-input" type="text" name="searchDocumentNumber" placeholder="Buscar por número de documento">
	    <select class="search-input" name="searchCareer">
	        <option value="">Ver Todos</option>
	        <option value="PA">Producción Agraria</option>
	        <option value="AS">Análisis de Sistemas</option>
	    </select>
        <button class="search-btn" type="submit">Buscar</button>
        <!-- Espacio en blanco -->
        <div class="space"></div>
	    <!-- Agregar los botones CSV, PDF y XLSX aquí -->
	    <div class="export-buttons">
	        <a href="export-csv-a.jsp?format=csv" class="export-btn">CSV</a>
	        <a href="export-pdf-a.jsp?format=pdf" class="export-btn">PDF</a>
	        <a href="export-xlsx-a.jsp?format=xlsx" class="export-btn">XLSX</a>
	    </div>
    </form>	
    <table>
        <tr>
            <th>ID</th>
            <th>Nombres</th>
            <th>Apellido</th>
            <th>Tip. Documento</th>
            <th>Núm. Documento</th>
            <th>Email</th>
            <th>Teléfono</th>
            <th>Carrera</th>
            <th>Semestre</th>
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

                // Obtener los parámetros de búsqueda del formulario GET
                String searchNames = request.getParameter("searchNames");
                String searchLastName = request.getParameter("searchLastName");
                String searchDocumentNumber = request.getParameter("searchDocumentNumber");
                String searchCareer = request.getParameter("searchCareer");

                // Construir la consulta SQL dinámica en función de los parámetros de búsqueda
                String query = "SELECT * FROM person WHERE active = 'A'";
                if (searchNames != null && !searchNames.isEmpty()) {
                    query += " AND LOWER(names) LIKE '%" + searchNames.toLowerCase() + "%'";
                }
                if (searchLastName != null && !searchLastName.isEmpty()) {
                    query += " AND LOWER(last_name) LIKE '%" + searchLastName.toLowerCase() + "%'";
                }
                if (searchDocumentNumber != null && !searchDocumentNumber.isEmpty()) {
                    query += " AND number_document LIKE '%" + searchDocumentNumber + "%'";
                }
                if (searchCareer != null && !searchCareer.isEmpty()) {
                    if (searchCareer.equals("PA")) {
                        query += " AND career = 'PA'";
                    } else if (searchCareer.equals("AS")) {
                        query += " AND career = 'AS'";
                    }
                }

                stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(query);

                // Iterar sobre los resultados y mostrarlos en la tabla
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String names = rs.getString("names");
                    String lastName = rs.getString("last_name");
                    String typeDocument = rs.getString("type_document");
                    String numberDocument = rs.getString("number_document");
                    String email = rs.getString("email");
                    String cellPhone = rs.getString("cell_phone");
                    String career = rs.getString("career");
                    String semester = rs.getString("semester");

                    // Traducir los valores de carrera y tipo de documento a su representación completa
                    if (career.equals("AS")) {
                        career = "Análisis de Sistemas";
                    } else if (career.equals("PA")) {
                        career = "Producción Agraria";
                    }

                    if (typeDocument.equals("DNI")) {
                        typeDocument = "DNI";
                    } else if (typeDocument.equals("CNT")) {
                        typeDocument = "Carnet";
                    } else if (typeDocument.equals("PPE")) {
                        typeDocument = "Pasaporte";
                    }

                    out.println("<tr>");
                    out.println("<td>" + id + "</td>");
                    out.println("<td>" + names + "</td>");
                    out.println("<td>" + lastName + "</td>");
                    out.println("<td>" + typeDocument + "</td>");
                    out.println("<td>" + numberDocument + "</td>");
                    out.println("<td>" + email + "</td>");
                    out.println("<td>" + cellPhone + "</td>");
                    out.println("<td>" + career + "</td>");
                    out.println("<td>" + semester + "</td>");
                    out.println("<td>");
                    out.println("<button class=\"edit-btn\" onclick=\"editPerson(" + id + ")\">Editar</button>");
                    out.println("<button class=\"delete-btn\" onclick=\"deletePerson(" + id + ")\">Eliminar</button>");
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
    
	<!-- Resto del código HTML -->
	<form class="search-form" action="edit.jsp" method="GET">
	    <!-- Agregar los botones CSV, PDF y XLSX aquí -->
	    <div class="export-buttonss">
	        <a href="export-csv.jsp?format=csv" class="export-btn">CSV</a>
	        <a href="export-pdf.jsp?format=pdf" class="export-btn">PDF</a>
	        <a href="export-xlsx.jsp?format=xlsx" class="export-btn">XLSX</a>
	    </div>
    </form>	
    
    <script>
        function editPerson(id) {
            // Redireccionar a la página de edición con el ID del registro
            window.location.href = "editarPersona.jsp?id=" + id;
        }
        
        function deletePerson(id) {
            if (confirm("¿Estás seguro de eliminar este registro?")) {
                // Redireccionar a la página de eliminación con el ID del registro
                window.location.href = "eliminarPersona.jsp?id=" + id;
            }
        }
        
        function viewInactive() {
            // Redireccionar a la página que muestra los registros inactivos
            window.location.href = "registrosInactivos.jsp";
        }
    </script>
</body>
</html>
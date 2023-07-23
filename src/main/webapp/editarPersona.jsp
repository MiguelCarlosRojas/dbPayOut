<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Persona</title>
    <style>
        body {
        	font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .form-container {
            max-width: 400px;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .form-container h3,
        .form-container h4 {
            text-align: center;
        }

        .form-container label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
        }

        .form-container input[type="text"],
        .form-container input[type="email"],
        .form-container input[type="tel"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .form-container select {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .form-container .form-group {
            display: flex;
            justify-content: space-between;
        }

        .form-container .form-group .form-field {
            width: calc(50% - 5px);
        }

        .form-container button[type="submit"],
        .form-container button[type="button"] {
            width: 48%; /* Ajusta el ancho de los botones */
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .form-container button[type="submit"] {
            background-color: #2196f3; /* Cambia el color a #2196f3 */
            color: #ffffff;
        }

        .form-container button[type="button"] {
            background-color: #ff0000; /* Cambia el color a rojo */
            color: #ffffff;
        }
        
        .form-container .buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 10px; /* Agrega margen superior */
        }
    </style>
<script>
    window.addEventListener("load", function() {
        toggleNumberDocumentFields();
    });

    function toggleNumberDocumentFields() {
        var typeDocumentSelect = document.getElementById("typeDocument");
        var numberDocumentInput = document.getElementById("numberDocument");
        var pattern = "";

        if (typeDocumentSelect.value === "DNI") {
            numberDocumentInput.disabled = false;
            numberDocumentInput.setAttribute("pattern", "\\d{8}");
            pattern = "Ingrese un número de documento válido (8 dígitos)";
        } else if (typeDocumentSelect.value === "CNT") {
            numberDocumentInput.disabled = false;
            numberDocumentInput.setAttribute("pattern", "\\d{10}");
            pattern = "Ingrese un número de documento válido (10 dígitos)";
        } else if (typeDocumentSelect.value === "PPE") {
            numberDocumentInput.disabled = false;
            numberDocumentInput.setAttribute("pattern", "\\d{15}");
            pattern = "Ingrese un número de documento válido (15 dígitos)";
        } else {
            numberDocumentInput.disabled = true;
            numberDocumentInput.removeAttribute("pattern");
        }

        // Eliminar espacios en blanco
        numberDocumentInput.value = numberDocumentInput.value.trim();

        numberDocumentInput.title = pattern;
    }
</script>
</head>
<body>
    <div class="form-container">
        <h3>Modificar Persona</h3>
        <h4>Ingresa los nuevos datos:</h4>

        <%
            Connection con = null;
            PreparedStatement ps = null;

            try {
                // Establecer la conexión con SQL Server
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                String url = "jdbc:sqlserver://localhost:1433;databaseName=dbPayOut;encrypt=true;TrustServerCertificate=True;user=sa;password=miguelangel";
                con = DriverManager.getConnection(url);

                // Obtener el ID de la persona a editar desde los parámetros de la URL
                int id = Integer.parseInt(request.getParameter("id"));

                // Consultar los datos de la persona a editar
                String query = "SELECT * FROM person WHERE id = ?";
                ps = con.prepareStatement(query);
                ps.setInt(1, id);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    // Obtener los datos de la persona
                    String names = rs.getString("names");
                    String lastName = rs.getString("last_name");
                    String typeDocument = rs.getString("type_document");
                    String numberDocument = rs.getString("number_document");
                    String email = rs.getString("email");
                    String cellPhone = rs.getString("cell_phone");
                    String career = rs.getString("career");
                    String semester = rs.getString("semester");

                    // Mostrar el formulario de edición
                    %>
                    <form action="guardarEdicion.jsp" method="POST">
                        <input type="hidden" name="id" value="<%= id %>">

                        <div class="form-group">
                            <div class="form-field">
                                <label for="names">Nombres:</label>
                                <input type="text" id="names" name="names" value="<%= names %>" style="width: 100%;" pattern="[A-Za-zñÑáéíóúÁÉÍÓÚ\s]+" required title="Ingrese un nombre válido (solo letras y espacios)">
                            </div>
                            <div class="form-field">
                                <label for="lastName">Apellido:</label>
                                <input type="text" id="lastName" name="lastName" value="<%= lastName %>" style="width: 100%;" pattern="[A-Za-zñÑáéíóúÁÉÍÓÚ\s]+" required title="Ingrese apellidos válidos (solo letras y espacios)">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="form-field">
                                <label for="typeDocument">Tipo de Documento:</label>
			                    <select id="typeDocument" name="typeDocument" required onchange="toggleNumberDocumentFields()">
                                    <option value="DNI" <%= typeDocument.equals("DNI") ? "selected" : "" %>>DNI</option>
                                    <option value="CNT" <%= typeDocument.equals("CNT") ? "selected" : "" %>>Carnet</option>
                                    <option value="PPE" <%= typeDocument.equals("PPE") ? "selected" : "" %>>Pasaporte</option>
                                </select>
                            </div>
                            <div class="form-field">
                                <label for="numberDocument">Número de Documento:</label>
                                <input type="text" id="numberDocument" name="numberDocument" value="<%= numberDocument %>" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="form-field">
                                <label for="email">Email:</label>
                                <input type="email" id="email" name="email" value="<%= email %>" pattern="[a-zA-Z0-9]+([._]?[a-zA-Z0-9]+)*@[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)+" required>
                            </div>
                            <div class="form-field">
                                <label for="cellPhone">Celular:</label>
                                <input type="tel" id="cellPhone" name="cellPhone" value="<%= cellPhone %>" style="width: 100%;" pattern="\d{9}" required title="Ingrese un número de teléfono celular válido (mínimo 9 dígitos)">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="form-field">
                                <label for="career">Carrera:</label>
                                <select id="career" name="career" required>
                                    <option value="AS" <%= career.equals("AS") ? "selected" : "" %>>Análisis de Sistemas</option>
                                    <option value="PA" <%= career.equals("PA") ? "selected" : "" %>>Producción Agraria</option>
                                </select>
                            </div>
                            <div class="form-field">
                                <label for="semester">Semestre:</label>
                                <select id="semester" name="semester" required>
                                    <option value="1" <%= semester.equals("1") ? "selected" : "" %>>1er semestre</option>
                                    <option value="2" <%= semester.equals("2") ? "selected" : "" %>>2do semestre</option>
                                    <option value="3" <%= semester.equals("3") ? "selected" : "" %>>3er semestre</option>
                                    <option value="4" <%= semester.equals("4") ? "selected" : "" %>>4to semestre</option>
                                    <option value="5" <%= semester.equals("5") ? "selected" : "" %>>5to semestre</option>
                                    <option value="6" <%= semester.equals("6") ? "selected" : "" %>>6to semestre</option>
                                </select>
                            </div>
                        </div>

			            <div class="buttons">
			                <button type="submit">Actualizar</button>
			                <button type="button" onclick="window.history.back()">Cancelar</button>
			            </div>                        
                    </form>
                    <%
                } else {
                    // Mostrar mensaje de error si no se encuentra la persona
                    out.println("<p>No se encontró la persona con el ID especificado.</p>");
                }
            } catch (Exception e) {
                // Mostrar mensaje de error en caso de fallo
                out.println("<p>Error al obtener los datos de la persona: " + e.getMessage() + "</p>");
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
    </div>
</body>
</html>

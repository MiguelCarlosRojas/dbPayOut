<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Crear Persona</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            padding: 49px;
        }

        h1 {
            text-align: center;
        }

        .form-container {
            max-width: 400px;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .form-container label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
        }

        .form-container input[type="text"],
        .form-container input[type="email"],
        .form-container input[type="tel"],
        .form-container select,
        .form-container input[type="number"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .form-container .row {
            display: flex;
            justify-content: space-between;
        }

        .form-container .row .column {
            flex: 1;
            margin-right: 10px;
        }

        .form-container .row .column:last-child {
            margin-right: 0;
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
        
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        h4 {
            text-align: center;
            color: #888888;
        }
        
        /* Estilos para el mensaje de éxito */
        .success-message {
            display: none; /* Inicialmente oculto */
            position: fixed;
            top: 20px; /* Ajustar la posición verticalmente */
            right: 20px;
            transform: translateY(0); /* Eliminar la transformación en Y */
            background-color: #4caf50;
            color: #ffffff;
            padding: 10px;
            border-radius: 4px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            animation: fade-in 0.5s ease-in-out; /* Animación de aparición */
        }
        
        /* Icono de marca de verificación */
        .success-icon {
            display: inline-block;
            width: 20px;
            height: 20px;
            background-color: #4caf50;
            border-radius: 50%;
            margin-right: 5px;
            position: relative;
            top: 3px;
        }
        
        /* Animación de aparición */
        @keyframes fade-in {
            0% { opacity: 0; transform: translateY(-20px); }
            100% { opacity: 1; transform: translateY(0); }
        }
    </style>
        <script>
        function showSuccessMessage() {
            var successMessage = document.getElementById("successMessage");
            successMessage.style.display = "block";
            setTimeout(function() {
                successMessage.style.animation = "none";
            }, 5000);
            setTimeout(function() {
                successMessage.style.display = "none";
            }, 5500);
        }
    </script>
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
        <h2>Crear una cuenta</h2>
        <h4>Ir a Web Educativo</h4>
        <% 
            Connection con = null;
            PreparedStatement ps = null;

            try {
                if (request.getMethod().equalsIgnoreCase("post")) {
                    // Obtener los parámetros enviados por el formulario
                    String names = request.getParameter("names");
                    String lastName = request.getParameter("lastName");
                    String typeDocument = request.getParameter("typeDocument");
                    String numberDocument = request.getParameter("numberDocument");
                    String email = request.getParameter("email");
                    String cellPhone = request.getParameter("cellPhone");
                    String career = request.getParameter("career");
                    String semester = request.getParameter("semester");

                    // Establecer la conexión con SQL Server
                    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                    String url = "jdbc:sqlserver://localhost:1433;databaseName=dbPayOut;encrypt=true;TrustServerCertificate=True;user=sa;password=miguelangel";
                    con = DriverManager.getConnection(url);

                    // Preparar la consulta de inserción
                    String insertQuery = "INSERT INTO person (names, last_name, type_document, number_document, email, cell_phone, career, semester) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                    ps = con.prepareStatement(insertQuery);
                    ps.setString(1, names);
                    ps.setString(2, lastName);
                    ps.setString(3, typeDocument);
                    ps.setString(4, numberDocument);
                    ps.setString(5, email);
                    ps.setString(6, cellPhone);
                    ps.setString(7, career);
                    ps.setString(8, semester);

                    // Ejecutar la consulta de inserción
                    ps.executeUpdate();

                    // Mostrar mensaje de éxito y redirigir a edit.jsp
                    out.println("<div id=\"successMessage\" class=\"success-message\">");
                    out.println("<span class=\"success-icon\"></span>");
                    out.println("Registro creado exitosamente.");
                    out.println("</div>");
                    out.println("<script>showSuccessMessage(); setTimeout(function() { window.location.href = 'index.jsp'; }, 5000);</script>");
                }
            } catch (Exception e) {
                out.println("<p>Error al crear la persona: " + e.getMessage() + "</p>");
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

        <form action="create.jsp" method="POST">
            <div class="row">
                <div class="column">
                    <label for="names">Nombres:</label>
                    <input type="text" id="names" name="names" style="width: 100%;" pattern="[A-Za-zñÑáéíóúÁÉÍÓÚ\s]+" required title="Ingrese un nombre válido (solo letras y espacios)">
                </div>
                <div class="column">
                    <label for="lastName">Apellido:</label>
                    <input type="text" id="lastName" name="lastName" style="width: 100%;" pattern="[A-Za-zñÑáéíóúÁÉÍÓÚ\s]+" required title="Ingrese apellidos válidos (solo letras y espacios)">
                </div>
            </div>

            <div class="row">
                <div class="column">
                    <label for="typeDocument">Tipo de Documento:</label>
			        <select id="typeDocument" name="typeDocument" required onchange="toggleNumberDocumentFields()">
                        <option value="" selected disabled>Elegir el tipo de ...</option>
                        <option value="DNI">DNI</option>
                        <option value="PPE">Pasaporte</option>
                        <option value="CNT">Carnet</option>
                    </select>
                </div>
                <div class="column">
                    <label for="numberDocument">Número de Documento:</label>
                    <input type="text" id="numberDocument" name="numberDocument" required>
                </div>
            </div>

            <div class="row">
                <div class="column">
                    <label for="email">Email:</label>
			<input type="email" id="email" name="email" pattern="[a-zA-Z0-9]+([._]?[a-zA-Z0-9]+)*@[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)+" required>
                </div>
                <div class="column">
                    <label for="cellPhone">Teléfono Celular:</label>
                    <input type="tel" id="cellPhone" name="cellPhone" style="width: 100%;" pattern="\d{9}" required title="Ingrese un número de teléfono celular válido (mínimo 9 dígitos)">
                </div>
            </div>

            <div class="row">
                <div class="column">
                    <label for="career">Carrera:</label>
                    <select id="career" name="career" required>
			            <option value="" selected disabled>Elegir la carrera ...</option>
                        <option value="AS">Análisis de Sistemas</option>
                        <option value="PA">Producción Agraria</option>
                    </select>
                </div>
                <div class="column">
                    <label for="semester">Semestre:</label>
                    <select id="semester" name="semester" required>
			            <option value="" selected disabled>Elegir el semestre ...</option>
                        <option value="1">1er semestre</option>
                        <option value="2">2do semestre</option>
                        <option value="3">3er semestre</option>
                        <option value="4">4to semestre</option>
                        <option value="5">5to semestre</option>
                        <option value="6">6to semestre</option>
                    </select>
                </div>
            </div>

            <div class="buttons">
                <button type="submit">Registrar</button>
                <button type="button" onclick="window.history.back()">Volver</button>
            </div>
        </form>
    </div>
</body>
</html>
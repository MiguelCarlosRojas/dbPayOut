<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Activar Usuario</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            padding: 20px;
        }

        h1 {
            text-align: center;
        }

        .message-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .message-box {
            max-width: 400px;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .success-message {
            color: green;
        }

        .error-message {
            color: red;
        }

        .loading-spinner {
            display: none;
            position: relative;
            width: 50px;
            height: 50px;
            margin: 0 auto;
            border: 4px solid #f3f3f3;
            border-top: 4px solid #3498db;
            border-radius: 50%;
            animation: spin 2s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .fade-in {
            animation: fade-in 0.5s ease-in-out;
        }

        @keyframes fade-in {
            0% { opacity: 0; transform: translateY(-20px); }
            100% { opacity: 1; transform: translateY(0); }
        }
    </style>
    <script>
        function showMessage(message, isSuccess) {
            var loadingSpinner = document.getElementById("loading-spinner");
            var messageBox = document.getElementById("message-box");

            loadingSpinner.style.display = "none";
            messageBox.innerHTML = message;
            messageBox.className = isSuccess ? "message-box success-message" : "message-box error-message";

            // Add animation class
            messageBox.classList.add("fade-in");

            // Remove animation class after 3 seconds
            setTimeout(function() {
                messageBox.classList.remove("fade-in");
                redirectToEdit();
            }, 3000);
        }

        function redirectToEdit() {
            var id = '<%= request.getParameter("id") %>';
            var loadingSpinner = document.getElementById("loading-spinner");
            var messageBox = document.getElementById("message-box");

            loadingSpinner.style.display = "block";
            messageBox.innerHTML = "";

            setTimeout(function() {
                window.location.href = "edit.jsp?id=" + id;
            }, 1500);
        }
    </script>
</head>
<body>

    <div class="message-container">
        <div id="loading-spinner" class="loading-spinner"></div>
        <div id="message-box" class="message-box"></div>
    </div>

    <%
        Connection con = null;
        PreparedStatement ps = null;
        String idParam = request.getParameter("id");

        try {
            int id = Integer.parseInt(idParam);

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            String url = "jdbc:sqlserver://localhost:1433;databaseName=dbPayOut;encrypt=true;TrustServerCertificate=True;user=sa;password=miguelangel";
            con = DriverManager.getConnection(url);

            String updateQuery = "UPDATE person SET active = 'A' WHERE id = ?";
            ps = con.prepareStatement(updateQuery);
            ps.setInt(1, id);
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                out.println("<script>showMessage('Persona activada exitosamente.', true);</script>");
            } else {
                out.println("<script>showMessage('Error al activar la persona. No se encontró el registro.', false);</script>");
            }
        } catch (Exception e) {
            out.println("<script>showMessage('Error al activar la persona: " + e.getMessage() + "', false);</script>");
        } finally {
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

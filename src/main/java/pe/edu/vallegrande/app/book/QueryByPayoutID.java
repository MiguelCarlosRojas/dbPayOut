package pe.edu.vallegrande.app.book;

import pe.edu.vallegrande.app.db.AccesoDBLocal;
import pe.edu.vallegrande.app.db.AccesoDBCloud;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class QueryByPayoutID {
    public static void main(String[] args) {
        Connection connection = null;
        try {
            // Establecer la conexión
            connection = AccesoDBLocal.getConnection();
            System.out.println("Conexión exitosa a la base de datos.");

            // Definir la consulta SQL para obtener un registro por ID
            String sql = "SELECT * FROM payout WHERE id = ?";

            // Crear un PreparedStatement con la consulta SQL
            PreparedStatement statement = connection.prepareStatement(sql);

            // Establecer el valor del parámetro para la consulta por ID
            statement.setInt(1, 2); // Valor del ID del registro a consultar

            // Ejecutar la consulta
            ResultSet resultSet = statement.executeQuery();

            // Verificar si se encontró el registro
            if (resultSet.next()) {
                // Obtener los valores de las columnas del registro
                int id = resultSet.getInt("id");
                String description = resultSet.getString("description");
                String tuition = resultSet.getString("tuition");
                String monthly_payment = resultSet.getString("monthly_payment");
                String amount = resultSet.getString("amount");
                String status = resultSet.getString("status");

                // Mostrar los valores obtenidos
                System.out.println("ID: " + id);
                System.out.println("Descripción: " + description);
                System.out.println("Matrícula: " + tuition);
                System.out.println("Mensualidad: " + monthly_payment);
                System.out.println("Monto: " + amount);
                System.out.println("Estado: " + status);
            } else {
                System.out.println("No se encontró el registro. Verifica el ID.");
            }

            // Cerrar el ResultSet y el PreparedStatement
            resultSet.close();
            statement.close();

        } catch (SQLException e) {
            System.out.println("Error al conectar a la base de datos: " + e.getMessage());
        } finally {
            try {
                // Cerrar la conexión
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                System.out.println("Error al cerrar la conexión: " + e.getMessage());
            }
        }
    }
}
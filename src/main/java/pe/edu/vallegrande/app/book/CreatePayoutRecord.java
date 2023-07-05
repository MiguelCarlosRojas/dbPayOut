package pe.edu.vallegrande.app.book;

import pe.edu.vallegrande.app.db.AccesoDBLocal;
import pe.edu.vallegrande.app.db.AccesoDBCloud;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class CreatePayoutRecord {
    public static void main(String[] args) {
        Connection connection = null;
        try {
            // Establecer la conexión
            connection = AccesoDBLocal.getConnection();
            System.out.println("Conexión exitosa a la base de datos.");

            // Definir la consulta SQL para insertar un nuevo registro
            String sql = "INSERT INTO payout (description, tuition, monthly_payment, amount) VALUES (?, ?, ?, ?)";

            // Crear un PreparedStatement con la consulta SQL
            PreparedStatement statement = connection.prepareStatement(sql);

            // Establecer los valores de los parámetros para el nuevo registro
            statement.setString(1, "Mensualidad"); // Breve descripción
            statement.setString(2, "4"); // Matrícula de la persona (por ejemplo, 1 hasta 6)
            statement.setString(3, "6"); // Mensualidad de la persona (por ejemplo, 1 hasta 6)
            statement.setString(4, "200.00"); // Monto 200.00 / 400.00

            // Ejecutar la consulta para insertar el nuevo registro
            int rowsInserted = statement.executeUpdate();

            if (rowsInserted > 0) {
                System.out.println("Registro creado exitosamente.");
            } else {
                System.out.println("No se pudo crear el registro.");
            }

            // Cerrar el PreparedStatement
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
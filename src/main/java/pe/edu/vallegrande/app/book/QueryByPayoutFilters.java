package pe.edu.vallegrande.app.book;

import pe.edu.vallegrande.app.db.AccesoDBLocal;
import pe.edu.vallegrande.app.db.AccesoDBCloud;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class QueryByPayoutFilters {
    public static void main(String[] args) {
        Connection connection = null;
        try {
            // Establecer la conexión
            connection = AccesoDBLocal.getConnection();
            System.out.println("Conexión exitosa a la base de datos.");

            // Definir la consulta SQL con los filtros deseados
            String sql = "SELECT * FROM payout WHERE tuition = ?";

            // Crear un PreparedStatement con la consulta SQL
            PreparedStatement statement = connection.prepareStatement(sql);

            // Establecer los valores de los parámetros para la consulta
            statement.setString(1, "2"); // Valor del filtro de catálogos

            // Ejecutar la consulta
            ResultSet resultSet = statement.executeQuery();

            // Crear una tabla para mostrar los resultados
            System.out.println("+----+----------------------+--------------+-----------------+------------+--------+");
            System.out.println("| ID |      Descripción     |   Matrícula  |   Mensualidad   |    Monto   | Estado |");
            System.out.println("+----+----------------------+--------------+-----------------+------------+--------+");

            while (resultSet.next()) {
                // Obtener los valores de las columnas del registro
                int id = resultSet.getInt("id");
                String description = resultSet.getString("description");
                String tuition = resultSet.getString("tuition");
                String monthly_payment = resultSet.getString("monthly_payment");
                String amount = resultSet.getString("amount");
                String status = resultSet.getString("status");

                // Mostrar los valores del registro en la tabla
                System.out.printf("| %2d | %20s | %12s | %15s | %10s | %6s | %n", id, description, tuition, monthly_payment, amount, status);
            }

            System.out.println("+----+----------------------+--------------+-----------------+------------+--------+");

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
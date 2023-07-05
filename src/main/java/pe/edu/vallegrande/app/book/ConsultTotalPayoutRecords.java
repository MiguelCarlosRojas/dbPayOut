package pe.edu.vallegrande.app.book;

import pe.edu.vallegrande.app.db.AccesoDBLocal;
import pe.edu.vallegrande.app.db.AccesoDBCloud;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ConsultTotalPayoutRecords {
    public static void main(String[] args) {
        Connection connection = null;
        try {
            // Establecer la conexión
            connection = AccesoDBLocal.getConnection();
            System.out.println("Conexión exitosa a la base de datos.");

            // Consultar todos los registros en la tabla "payout"
            String selectAllQuery = "SELECT id, description, tuition, monthly_payment, amount, status FROM payout";

            // Crear un PreparedStatement con la consulta para seleccionar todos los registros
            PreparedStatement selectAllStatement = connection.prepareStatement(selectAllQuery);

            // Ejecutar la consulta para seleccionar todos los registros
            ResultSet selectAllResultSet = selectAllStatement.executeQuery();

            // Mostrar los resultados en una tabla
            System.out.println("=== Registros en la tabla book ===");
            System.out.println("|  ID |    Descripción	|  Matrícula  |   Mensualidad  |    Monto   |  Estado  |");
            while (selectAllResultSet.next()) {
                int id = selectAllResultSet.getInt("id");
                String description = selectAllResultSet.getString("description");
                String tuition = selectAllResultSet.getString("tuition");
                String monthly_payment = selectAllResultSet.getString("monthly_payment");
                String amount = selectAllResultSet.getString("amount");
                String status = selectAllResultSet.getString("status");

                System.out.printf("| %3d | %-15s | %-11s | %-14s | %-10s | %7s  |\n",
                        id, description, tuition, monthly_payment, amount, status);
            }
            System.out.println("--------------------------------------------------------------------------------");

            // Cerrar el ResultSet y el PreparedStatement
            selectAllResultSet.close();
            selectAllStatement.close();

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
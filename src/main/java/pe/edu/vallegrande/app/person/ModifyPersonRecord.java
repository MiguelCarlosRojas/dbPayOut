package pe.edu.vallegrande.app.person;

import pe.edu.vallegrande.app.db.AccesoDBLocal;
import pe.edu.vallegrande.app.db.AccesoDBCloud;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ModifyPersonRecord {
    public static void main(String[] args) {
        Connection connection = null;
        try {
            // Establecer la conexión
            connection = AccesoDBLocal.getConnection();
            System.out.println("Conexión exitosa a la base de datos.");

            // Definir la consulta SQL para modificar un registro
            String sql = "UPDATE person SET names = ?, last_name = ?, type_document = ?, number_document = ?, " +
                    "email = ?, cell_phone = ?, career = ?, semester = ? WHERE id = ?";

            // Crear un PreparedStatement con la consulta SQL
            PreparedStatement statement = connection.prepareStatement(sql);

            // Establecer los valores de los parámetros
            statement.setString(1, "John");  // Nombre de la persona
            statement.setString(2, "Doe");  // Apellido de la persona
            statement.setString(3, "CNT");  // Tipo de identificación (por ejemplo, 'DNI' DNI, 'CNT' Carnet 'PPE' Pasaporte, etc.)
            statement.setString(4, "2456789345");  // Número de identificación
            statement.setString(5, "johndoe@example.com");  // Dirección de correo electrónico de la persona
            statement.setString(6, "923456789");  // Número de teléfono de la persona
            statement.setString(7, "AS");  // Carrera de la persona (por ejemplo, 'AS' Análisis de Sistemas , 'PA' Producción Agraria)
            statement.setString(8, "4");  // Semestre de la persona (por ejemplo, 1 hasta 6)
            statement.setInt(9, 2); // ID del registro a modificar

            // Ejecutar la consulta
            int filasModificadas = statement.executeUpdate();

            // Verificar si se modificó el registro exitosamente
            if (filasModificadas > 0) {
                System.out.println("Registro modificado correctamente.");
            } else {
                System.out.println("No se pudo modificar el registro.");
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
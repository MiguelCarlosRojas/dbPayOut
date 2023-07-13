/* Poner en uso la base de datos */
USE dbPayOut;

/* Configurar idioma español en el servidor */
SET LANGUAGE Español
GO
SELECT @@language AS 'Idioma'
GO

/* Configurar el formato de fecha */
SET DATEFORMAT dmy
GO

-- Insertar registros en la tabla payout
INSERT INTO payout (description, tuition, monthly_payment, amount)
VALUES ('Matrícula', '1', '1', 200.00),
       ('Matrícula', '2', '2', 400.00),
       ('Mensualidad', '3', '3', 200.00),
       ('Mensualidad', '4', '4', 400.00),
       ('Mensualidad', '5', '5', 200.00);

-- Obtener todos los registros
SELECT * FROM payout;

-- Insertar registros en la tabla person
INSERT INTO person (names, last_name, type_document, number_document, email, cell_phone, career, semester)
VALUES ('Juan', 'Perez', 'DNI', '12345678', 'juan@example.com', '923456789', 'AS', '1'),
       ('Maria', 'Lopez', 'CNT', '2456789246', 'maria@universidad.edu', '987654321', 'AS', '2'),
       ('Carlos', 'Gonzalez', 'PPE', '485927348923456', 'carlos@example.com', '967890123', 'PA', '1'),
       ('Ana', 'Rodriguez', 'DNI', '83749285', 'ana@universidad.edu', '908172635', 'PA', '2'),
       ('Pedro', 'Garcia', 'CNT', '6556789246', 'pedro@example.com', '926384901', 'AS', '3');

-- Obtener todos los registros
SELECT * FROM person;

-- Insertar registros en la tabla term
INSERT INTO term (person_id)
VALUES (1),
       (2),
       (3),
       (4),
       (5);

-- Obtener todos los registros
SELECT * FROM term;

-- Insertar registros en la tabla detail_term
INSERT INTO detail_term (term_id, payout_id, amount)
VALUES (1, 1, 200),
       (1, 2, 400),
       (2, 3, 200),
       (2, 3, 400),
       (3, 4, 200);

-- Obtener todos los registros
SELECT * FROM detail_term;

-- Insertar registros en la tabla expired
INSERT INTO expired (person_id)
VALUES (1),
       (2),
       (3),
       (4),
       (5);

-- Obtener todos los registros
SELECT * FROM expired;

-- Insertar registros en la tabla detail_expired
INSERT INTO detail_expired (expired_id, payout_id, amount, status)
VALUES (1, 1, 200, 'PA'),
       (1, 2, 400, 'PE'),
       (2, 3, 200, 'PA'),
       (2, 3, 400, 'PE'),
       (3, 4, 200, 'PA');

-- Obtener todos los registros
SELECT * FROM detail_expired;

-- fin


--CRUD Maestro 2
/* Poner en uso la base de datos */
USE dbPayOut;

-- Obtener todos los registros
SELECT * FROM person;

-- Actualizar el correo electrónico de una persona
UPDATE person
SET active = 'A'
WHERE id = 4;

-- Obtener el registro con el ID específico
SELECT * FROM person
WHERE id = 1;

-- Obtener registros activos
SELECT * FROM person
WHERE active = 'A';

-- Eliminar una persona
DELETE FROM person
WHERE id = 6;

-- Obtener el número total de registros
SELECT COUNT(*) FROM person;

-- Obtener registros ordenados por nombres de forma ascendente
SELECT * FROM person
ORDER BY names ASC;

-- Obtener registros filtrados por career
SELECT * FROM person
WHERE career = 'AS';

-- Obtener registros que contengan una cadena específica en el correo electrónico
SELECT * FROM person
WHERE email LIKE '%universidad.edu%';

-- fin


--CRUD Maestro 2
/* Poner en uso la base de datos */
USE dbPayOut;

-- Obtener todos los registros
SELECT * FROM payout;

-- Actualizar el correo electrónico de una persona
UPDATE payout
SET status = 'I'
WHERE id = 2;

-- Obtener el registro con el ID específico
SELECT * FROM payout
WHERE id = 1;

-- Obtener registros activos
SELECT * FROM payout
WHERE status = 'A';

-- Eliminar una persona
DELETE FROM payout
WHERE id = 1;

-- Obtener el número total de registros
SELECT COUNT(*) FROM payout;

-- Obtener registros filtrados por amount
SELECT * FROM payout
WHERE amount = '200';

-- Obtener registros que contengan una cadena específica en la description
SELECT * FROM payout
WHERE description LIKE '%Mensualidad';

-- fin
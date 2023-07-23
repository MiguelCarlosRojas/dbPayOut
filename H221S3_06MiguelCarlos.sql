-- Base de datos
/* Poner en uso base de datos master */
USE master;

/* Si la base de datos ya existe la eliminamos */
DROP DATABASE dbPayOut;

/* Crear base de datos grow up */
CREATE DATABASE dbPayOut;

/* Poner en uso la base de datos */
USE dbPayOut;

/* Crear tabla detail_expired */
CREATE TABLE detail_expired (
    id int identity(1,1)  NOT NULL,
    expired_id int  NOT NULL,
    payout_id int  NOT NULL,
    amount int  NOT NULL,
    status char(2) DEFAULT ('PE') NOT NULL,
    CONSTRAINT detail_expired_pk PRIMARY KEY (id),
    CONSTRAINT status_check_detail_expired CHECK (status IN ('PE', 'PA')),
    CONSTRAINT amount_positive_check_detail_expired CHECK (amount > 0),
    CONSTRAINT amount_check_detail_expired CHECK (amount = 200.00 OR amount = 400.00)

);

/* Ver estructura de tabla detail_expired */
EXEC sp_columns @table_name = 'detail_expired';

/* Crear tabla detail_term */
CREATE TABLE detail_term (
    id int identity(1,1)  NOT NULL,
    term_id int  NOT NULL,
    payout_id int  NOT NULL,
    amount decimal (10, 2) NOT NULL,
    CONSTRAINT detail_term_pk PRIMARY KEY (id),
    CONSTRAINT amount_positive_check_detail_term CHECK (amount > 0),
    CONSTRAINT amount_check_detail_term CHECK (amount = 200.00 OR amount = 400.00)
);

/* Ver estructura de tabla detail_term */
EXEC sp_columns @table_name = 'detail_term';

/* Crear tabla expired */
CREATE TABLE expired (
    id int identity(1,1)  NOT NULL,
    person_id int  NOT NULL,
    date_expired date DEFAULT '2023-07-10' NOT NULL,
    CONSTRAINT expired_pk PRIMARY KEY (id)
);

/* Ver estructura de tabla expired */
EXEC sp_columns @table_name = 'expired';

/* Crear tabla payout */
CREATE TABLE payout (
    id int identity(1,1)  NOT NULL,
    description varchar(100)  NOT NULL,
    tuition char(1)  NOT NULL,
    monthly_payment varchar (1) NOT NULL,
    amount decimal(10,2)  NOT NULL,
    status char(1) DEFAULT ('A') NOT NULL,
    CONSTRAINT payout_pk PRIMARY KEY (id),
    CONSTRAINT amount_positive_check_payout CHECK (amount > 0),
    CONSTRAINT status_check_payout CHECK (status IN ('A', 'I')),
    CONSTRAINT amount_check_payout CHECK (amount = 200.00 OR amount = 400.00),
    CONSTRAINT tuition_check_payout CHECK (tuition IN ('1', '2', '3', '4', '5', '6')),
    CONSTRAINT monthly_payment_check_payout CHECK (monthly_payment IN ('1', '2', '3', '4', '5', '6'))
);

/* Ver estructura de tabla payout */
EXEC sp_columns @table_name = 'payout';

/* Crear tabla person */
CREATE TABLE person (
    id int identity(1,1)  NOT NULL,
    names varchar(60)  NOT NULL,
    last_name varchar(90)  NOT NULL,
    type_document char(3)  NOT NULL,
    number_document char(15)  NOT NULL,
    email varchar(80) CHECK (email LIKE '%@%') NOT NULL,
    cell_phone char(9) CHECK (LEN(cell_phone) = 9 AND cell_phone LIKE '9%') NOT NULL,
    career char(2)  NOT NULL,
    semester char(1)  NOT NULL,
    active char(1) DEFAULT ('A') NOT NULL,
    CONSTRAINT person_pk PRIMARY KEY (id),
    CONSTRAINT active_check_person CHECK (active IN ('A', 'I')),
    CONSTRAINT type_document_check_person CHECK (type_document IN ('DNI', 'CNT', 'PPE')),
    CONSTRAINT unique_number_document_check_person UNIQUE (number_document),
    CONSTRAINT career_check_person CHECK (career IN ('AS', 'PA')),
    CONSTRAINT semester_positive_check_person CHECK (semester > 0),
    CONSTRAINT number_document_check_person CHECK (
        (type_document = 'DNI' AND LEN(number_document) = 8)
        OR (type_document = 'CNT' AND LEN(number_document) = 10)
        OR (type_document = 'PPE' AND LEN(number_document) = 15)
    )
);

/* Ver estructura de tabla person */
EXEC sp_columns @table_name = 'person';

/* Crear tabla term */
CREATE TABLE term (
    id int identity(1,1)  NOT NULL,
    person_id int  NOT NULL,
    date_term date  DEFAULT GETDATE() NOT NULL,
    status char(2) DEFAULT ('PE') NOT NULL,
    active char(1) DEFAULT ('A') NOT NULL,
    CONSTRAINT term_pk PRIMARY KEY (id),
    CONSTRAINT status_check_term CHECK (status IN ('PE', 'CA')),
    CONSTRAINT active_check_term CHECK (active IN ('A', 'I')),
    CONSTRAINT date_term_check_term CHECK (date_term <= '2023-09-10')
);


/* Ver estructura de tabla term */
EXEC sp_columns @table_name = 'term';

-- Relaciones
/* Relacionar tabla detail_expired_expired con tabla detail_expired */
ALTER TABLE detail_expired ADD CONSTRAINT detail_expired_expired
    FOREIGN KEY (expired_id)
    REFERENCES expired (id)
	ON UPDATE CASCADE 
    ON DELETE CASCADE
GO

/* Relacionar tabla detail_expired_payout con tabla detail_expired */
ALTER TABLE detail_expired ADD CONSTRAINT detail_expired_payout
    FOREIGN KEY (payout_id)
    REFERENCES payout (id)
	ON UPDATE CASCADE 
    ON DELETE CASCADE
GO

/* Relacionar tabla detail_term_payout con tabla detail_term */
ALTER TABLE detail_term ADD CONSTRAINT detail_term_payout
    FOREIGN KEY (payout_id)
    REFERENCES payout (id)
	ON UPDATE CASCADE 
    ON DELETE CASCADE
GO

/* Relacionar tabla detail_term_term con tabla detail_term */
ALTER TABLE detail_term ADD CONSTRAINT detail_term_term
    FOREIGN KEY (term_id)
    REFERENCES term (id)
	ON UPDATE CASCADE 
    ON DELETE CASCADE
GO

/* Relacionar tabla reservation_person con tabla term */
ALTER TABLE term ADD CONSTRAINT reservation_person
    FOREIGN KEY (person_id)
    REFERENCES person (id)
	ON UPDATE CASCADE 
    ON DELETE CASCADE
GO

/* Relacionar tabla return_person con tabla expired */
ALTER TABLE expired ADD CONSTRAINT return_person
    FOREIGN KEY (person_id)
    REFERENCES person (id)
	ON UPDATE CASCADE 
    ON DELETE CASCADE
GO

/* Ver relaciones creadas entre las tablas de la base de datos */
SELECT 
    fk.name [Constraint],
    OBJECT_NAME(fk.parent_object_id) [Tabla],
    COL_NAME(fc.parent_object_id,fc.parent_column_id) [Columna FK],
    OBJECT_NAME (fk.referenced_object_id) AS [Tabla base],
    COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS [Columna PK]
FROM 
    sys.foreign_keys fk
    INNER JOIN sys.foreign_key_columns fc ON (fk.OBJECT_ID = fc.constraint_object_id)
GO


-- fin

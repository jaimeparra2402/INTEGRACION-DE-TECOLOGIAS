-- ===========================
-- CREAR USUARIO
-- ===========================
CREATE USER incident_user WITH PASSWORD 'pass';

-- Tabla Customers
CREATE TABLE CUSTOMERS(
    EMAIL varchar(255) PRIMARY KEY,
    NAME varchar(255) NOT NULL,
    VIP_STATUS varchar(255) NOT NULL
);

-- Tabla Tickets
CREATE TABLE TICKETS(
    ID SERIAL PRIMARY KEY,
    "TIMESTAMP" TIMESTAMP DEFAULT NOW(),
    CUSTOMER_EMAIL varchar(255) NOT NULL,
    SUMMARY varchar(255),
    CATEGORY varchar(100) NOT NULL,
    URGENCY varchar(20) NOT NULL,
    STATUS varchar(40) NOT NULL,
    N8N_RUN_URL varchar(255),

    FOREIGN KEY(CUSTOMER_EMAIL) REFERENCES CUSTOMERS(EMAIL)
);

--- Otorgar permisos de las tablas creadas

GRANT ALL PRIVILEGES ON TICKETS TO incident_user;
GRANT ALL PRIVILEGES ON CUSTOMERS TO incident_user;
CREATE DATABASE IF NOT EXISTS TallerMecanico;
USE TallerMecanico;

CREATE TABLE PROVEEDOR (
    IDProveedor INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(200),
    Telefono VARCHAR(15),
    Email VARCHAR(100)
);

CREATE TABLE CLIENTE (
    IDCliente INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido1 VARCHAR(50) NOT NULL,
    Apellido2 VARCHAR(50),
    Telefono VARCHAR(15),
    Email VARCHAR(100),
    UNIQUE (Email)
);

CREATE TABLE PUESTO (
    IDPuesto INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(200)
);

CREATE TABLE EMPLEADO (
    IDEmpleado INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido1 VARCHAR(50) NOT NULL,
    Apellido2 VARCHAR(50),
    Telefono VARCHAR(15),
    IDPuesto INT,
    Estado BOOLEAN DEFAULT 1,
    FOREIGN KEY (Puesto) REFERENCES PUESTO(IDPuesto)
);

CREATE TABLE VEHICULO (
    IDVehiculo INT AUTO_INCREMENT PRIMARY KEY,
    Marca VARCHAR(50),
    Modelo INT,
    Anio INT,
    Placa VARCHAR(10),
    Color VARCHAR(50),
    IDCliente INT,
    FOREIGN KEY (Cliente) REFERENCES CLIENTE(IDCliente)
);

CREATE TABLE SERVICIO (
    IDServicio INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(200),
    Costo DECIMAL(10, 2),
    Garantia VARCHAR(100),
    IDEmpleado INT,
    IDVehiculo INT,
    FOREIGN KEY (Empleado) REFERENCES EMPLEADO(IDEmpleado),
    FOREIGN KEY (Vehiculo) REFERENCES VEHICULO(IDVehiculo)
);

CREATE TABLE PIEZA (
    IDPieza INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    CantidadEnStock INT,
    FechaAdquisicion DATE,
    Estado BOOLEAN DEFAULT 1,
    PrecioCompra DECIMAL(10, 2),
    PrecioVenta DECIMAL(10, 2),
    IDProveedor INT,
    FOREIGN KEY (Proveedor) REFERENCES PROVEEDOR(IDProveedor)
);

CREATE TABLE CITA (
    IDCita INT AUTO_INCREMENT PRIMARY KEY,
    IDCliente INT,
    FechaEntrada DATETIME,
    FechaSalida DATETIME,
    IDServicio INT,
    IDEmpleado INT,
    FOREIGN KEY (IDCliente) REFERENCES CLIENTE(IDCliente),
    FOREIGN KEY (Servicio) REFERENCES SERVICIO(IDServicio),
    FOREIGN KEY (Empleado) REFERENCES EMPLEADO(IDEmpleado)
);

INSERT INTO PROVEEDOR (Nombre, Descripcion, Telefono, Email)
VALUES
    ('Proveedor 1', 'Descripción del proveedor 1', '123-456-7890', 'proveedor1@example.com'),
    ('Proveedor 2', 'Descripción del proveedor 2', '987-654-3210', 'proveedor2@example.com');

INSERT INTO CLIENTE (Nombre, Apellido1, Apellido2, Telefono, Email)
VALUES
    ('Cliente 1', 'Apellido1 Cliente 1', 'Apellido2 Cliente 1', '555-123-4567', 'cliente1@example.com'),
    ('Cliente 2', 'Apellido1 Cliente 2', 'Apellido2 Cliente 2', '555-987-6543', 'cliente2@example.com'),
    ('MYSQL', 'MYSQL', 'MYSQL', '555-123-4567', 'MYSQL@example.com');

INSERT INTO PUESTO (Nombre, Descripcion)
VALUES
    ('Mecánico', 'Descripción del puesto de mecánico'),
    ('Recepcionista', 'Descripción del puesto de recepcionista');

INSERT INTO EMPLEADO (Nombre, Apellido1, Apellido2, Telefono, Puesto)
VALUES
    ('Empleado 1', 'Apellido1 Empleado 1', 'Apellido2 Empleado 1', '555-111-2222', 1),
    ('Empleado 2', 'Apellido1 Empleado 2', 'Apellido2 Empleado 2', '555-333-4444', 2);

INSERT INTO VEHICULO (Marca, Modelo, Anio, Placa, Color, Cliente)
VALUES
    ('Toyota', 2020, 1234, 'ABC123', 'Rojo', 1),
    ('Ford', 2019, 5678, 'XYZ987', 'Azul', 2);

INSERT INTO SERVICIO (Nombre, Descripcion, Costo, Garantia, Empleado, Vehiculo)
VALUES
    ('Cambio de aceite', 'Descripción del cambio de aceite', 50.00, 'Garantía de 3 meses', 1, 1),
    ('Reparación de frenos', 'Descripción de la reparación de frenos', 120.00, 'Garantía de 6 meses', 2, 2);

INSERT INTO PIEZA (Nombre, CantidadEnStock, FechaAdquisicion, PrecioCompra, PrecioVenta, Proveedor)
VALUES
    ('Filtro de aceite', 100, '2023-01-15', 5.00, 10.00, 1),
    ('Pastillas de freno', 50, '2023-02-20', 10.00, 20.00, 2);

INSERT INTO CITA (IDCliente, FechaEntrada, FechaSalida, Servicio, Empleado)
VALUES
    (1, '2023-10-15 10:00:00', '2023-10-15 14:00:00', 1, 1),
    (2, '2023-10-16 11:00:00', '2023-10-16 15:00:00', 2, 2);

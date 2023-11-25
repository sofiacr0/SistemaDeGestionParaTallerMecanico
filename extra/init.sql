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
    FOREIGN KEY (IDPuesto) REFERENCES PUESTO(IDPuesto)
);

CREATE TABLE VEHICULO (
    IDVehiculo INT AUTO_INCREMENT PRIMARY KEY,
    Marca VARCHAR(50),
    Modelo INT,
    Anio INT,
    Placa VARCHAR(10),
    Color VARCHAR(50),
    IDCliente INT,
    FOREIGN KEY (IDCliente) REFERENCES CLIENTE(IDCliente)
);

CREATE TABLE SERVICIO (
    IDServicio INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(200),
    Costo DECIMAL(10, 2),
    Garantia VARCHAR(100),
    IDEmpleado INT,
    IDVehiculo INT,
    FOREIGN KEY (IDEmpleado) REFERENCES EMPLEADO(IDEmpleado),
    FOREIGN KEY (IDVehiculo) REFERENCES VEHICULO(IDVehiculo)
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
    FOREIGN KEY (IDProveedor) REFERENCES PROVEEDOR(IDProveedor)
);

CREATE TABLE CITA (
    IDCita INT AUTO_INCREMENT PRIMARY KEY,
    IDCliente INT,
    FechaEntrada DATETIME,
    FechaSalida DATETIME,
    IDServicio INT,
    IDEmpleado INT,
    FOREIGN KEY (IDCliente) REFERENCES CLIENTE(IDCliente),
    FOREIGN KEY (IDServicio) REFERENCES SERVICIO(IDServicio),
    FOREIGN KEY (IDEmpleado) REFERENCES EMPLEADO(IDEmpleado)
);

INSERT INTO `PROVEEDOR` (`IDProveedor`, `Nombre`, `Descripcion`, `Telefono`, `Email`) VALUES
(1, 'AutoRepuestos Velázquez', 'Proveedor de repuestos automotrices de alta calidad.', '123-456-7890', 'info@autorepuestosvelazquez.com'),
(2, 'Herramientas Martínez', 'Especialistas en suministro de herramientas para talleres mecánicos.', '987-654-3210', 'ventas@herramientasmartinez.com'),
(3, 'Neumáticos RápidoGiro', 'Especialistas en neumáticos y servicios de alineación.', '555-7890-1234', 'info@rapido-giro-neumaticos.com');

INSERT INTO `CLIENTE` (`IDCliente`, `Nombre`, `Apellido1`, `Apellido2`, `Telefono`, `Email`)
VALUES
(1, 'Carlos', 'Mendoza', 'Rivera', '555-123-4567', 'Carlos@example.com'),
(2, 'Laura', 'Fernandez', 'Salazar', '555-987-6543', 'Laura23@example.com'),
(3, 'Roberto', 'Diaz', 'Perez', '555-123-4567', 'Rob@example.com');

INSERT INTO `PUESTO` (`IDPuesto`, `Nombre`, `Descripcion`) VALUES
(1, 'Mecanico', 'Descripcion'),
(2, 'Recepcionista', 'Descripcion\r\n');

INSERT INTO `EMPLEADO` (`IDEmpleado`, `Nombre`, `Apellido1`, `Apellido2`, `Telefono`, `Puesto`, `Estado`) 
VALUES
(1, 'Jose', 'Lopez', 'Ramirez', '555-111-2222', 1, 1),
(2, 'Ana', 'Gonzales', 'Herrera', '555-333-4444', 2, 1),
(3, 'Maria', 'Martinez', 'Garcia', '555112233', 1, 1);

INSERT INTO `VEHICULO` (`IDVehiculo`, `Marca`, `Modelo`, `Anio`, `Placa`, `Color`, `Cliente`) VALUES
(1, 'Toyota', 2020, 1234, 'ABC123', 'Rojo', 1),
(2, 'Ford', 2019, 5678, 'XYZ987', 'Azul', 2),
(3, 'Honda', 2019, 1234, 'ABC-123', 'Azul', 3);

INSERT INTO `SERVICIO` (`IDServicio`, `Nombre`, `Descripcion`, `Costo`, `Garantia`, `Empleado`, `Vehiculo`) VALUES
(1, 'Cambio de aceite', 'Cambio de aceite rápido y eficiente para el vehículo.', 50.00, 'Garanti­a de 3 meses', 1, 1),
(2, 'Reparacion de frenos', 'Seguridad en frenos: inspección, reparación y mantenimiento.', 120.00, 'Garantia de 6 meses', 1, 2),
(3, 'Reemplazo de neumaticos', '\"Reemplazo de neumaticos: Instalacion experta para un rendimiento óptimo y seguridad en la carretera.\"', 500.00, 'Garantia 8 meses', 3, 3);

INSERT INTO `PIEZA` (`IDPieza`, `Nombre`, `CantidadEnStock`, `FechaAdquisicion`, `Estado`, `PrecioCompra`, `PrecioVenta`, `Proveedor`) 
VALUES
(1, 'Filtro de aceite', 100, '2023-01-15', 1, 5.00, 10.00, 1),
(2, 'Pastillas de freno', 50, '2023-02-20', 1, 10.00, 20.00, 2),
(3, 'Bateria para carro', 5, '2023-08-25', 1, 2500.00, 3000.00, 1);

INSERT INTO `CITA` (`IDCita`, `IDCliente`, `FechaEntrada`, `FechaSalida`, `Servicio`, `Empleado`) 
VALUES
(1, 1, '2023-10-15 10:00:00', '2023-10-15 14:00:00', 1, 1),
(2, 2, '2023-10-16 11:00:00', '2023-10-16 15:00:00', 2, 2),
(3, 3, '2023-11-23 10:00:00', '2023-11-23 13:00:00', 1, 1);

DROP TABLE IF EXISTS `vista_citas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`user`@`%` SQL SECURITY DEFINER VIEW `vista_citas`  AS SELECT `CITA`.`IDCita` AS `id_cita`, 
concat(`CLIENTE`.`Nombre`,' ',`CLIENTE`.`Apellido1`,' ',`CLIENTE`.`Apellido2`) AS `nombre_cliente`, date_format(`CITA`.`FechaEntrada`,'%d de %M de %Y %H:%i:%s') AS `fecha_entrada`,
 date_format(`CITA`.`FechaSalida`,'%d de %M de %Y %H:%i:%s') AS `fecha_salida`, concat(`EMPLEADO`.`Nombre`,' ',`EMPLEADO`.`Apellido1`,' ',`EMPLEADO`.`Apellido2`) AS `nombre_empleado`, `SERVICIO`.`Nombre` AS `nombre_servicio` 
 FROM (((`CITA` join `CLIENTE` on((`CITA`.`IDCliente` = `CLIENTE`.`IDCliente`))) join `EMPLEADO` on((`CITA`.`Empleado` = `EMPLEADO`.`IDEmpleado`))) join `SERVICIO` on((`CITA`.`Servicio` = `SERVICIO`.`IDServicio`))) ;
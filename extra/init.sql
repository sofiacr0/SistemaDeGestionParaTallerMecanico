CREATE DATABASE IF NOT EXISTS TallerMecanico CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
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

-- UNA MAUSQUEHERRAMIENTA QUE NOS AYUDARÁ MÁS TARDE
CREATE TABLE MesesEquivalencia (
    MesIngles VARCHAR(10),
    MesEspanol VARCHAR(10)
);

INSERT INTO MesesEquivalencia (MesIngles, MesEspanol)
VALUES
    ('January', 'enero'),
    ('February', 'febrero'),
    ('March', 'marzo'),
    ('April', 'abril'),
    ('May', 'mayo'),
    ('June', 'junio'),
    ('July', 'julio'),
    ('August', 'agosto'),
    ('September', 'septiembre'),
    ('October', 'octubre'),
    ('November', 'noviembre'),
    ('December', 'diciembre');

-- VISTA CITAS 
DROP TABLE IF EXISTS vista_citas;

CREATE VIEW vista_citas AS 
SELECT 
    -- ID
    CITA.IDCita AS id_cita, 

    -- Cliente
    CONCAT(CLIENTE.Nombre, ' ', CLIENTE.Apellido1, ' ', CLIENTE.Apellido2) AS nombre_cliente, 

   -- Entrada
    CONCAT(
        DATE_FORMAT(CITA.FechaEntrada, '%d de '),
        (SELECT MesEspanol FROM MesesEquivalencia WHERE MesIngles = MONTHNAME(CITA.FechaEntrada)),
        DATE_FORMAT(CITA.FechaEntrada, ' de %Y %H:%i:%s')
    ) AS fecha_entrada_completa,

    -- Salida
    CONCAT(
        DATE_FORMAT(CITA.FechaSalida, '%d de '),
        (SELECT MesEspanol FROM MesesEquivalencia WHERE MesIngles = MONTHNAME(CITA.FechaSalida)),
        DATE_FORMAT(CITA.FechaSalida, ' de %Y %H:%i:%s')
    ) AS fecha_salida_completa,


    -- Servicio
    SERVICIO.Nombre AS nombre_servicio,

    -- Empleado
    CONCAT(EMPLEADO.Nombre, ' ', EMPLEADO.Apellido1, ' ', EMPLEADO.Apellido2) AS nombre_empleado 
    
FROM 
    CITA 
    JOIN CLIENTE ON CITA.IDCliente = CLIENTE.IDCliente 
    JOIN EMPLEADO ON CITA.IDEmpleado = EMPLEADO.IDEmpleado 
    JOIN SERVICIO ON CITA.IDServicio = SERVICIO.IDServicio;

-- VISTA EMPLEADO

-- VISTA CLIENTE
CREATE VIEW vista_clientes AS
SELECT
    IDCliente,
    CONCAT(Nombre, ' ', Apellido1, ' ', COALESCE(Apellido2, '')) AS NombreCompleto,
    Telefono,
    Email
FROM CLIENTE;


-- RELLENO TABLA PROVEEDOR 
INSERT INTO PROVEEDOR (IDProveedor, Nombre, Descripcion, Telefono, Email) VALUES
(1, 'AutoRepuestos Velazquez', 'Proveedor de repuestos automotrices de alta calidad.', '123-456-7890', 'info@autorepuestosvelazquez.com'),
(2, 'Herramientas Martinez', 'Especialistas en suministro de herramientas para talleres mecanicos.', '987-654-3210', 'ventas@herramientasmartinez.com'),
(3, 'Neumaticos RapidoGiro', 'Especialistas en neumaticos y servicios de alineacion.', '555-7890-1234', 'info@rapido-giro-neumaticos.com');

-- RELLENO TABLA CLIENTE 
INSERT INTO `CLIENTE` (`IDCliente`, `Nombre`, `Apellido1`, `Apellido2`, `Telefono`, `Email`) VALUES
(1, 'Carlos', 'Mendoza', 'Rivera', '555-123-4567', 'Carlos@example.com'),
(2, 'Laura', 'Fernandez', 'Salazar', '555-987-6543', 'Laura23@example.com'),
(3, 'Roberto', 'Diaz', 'Perez', '555-123-4567', 'Rob@example.com'),
(4, 'Ana', 'Martinez', 'Sanchez', '349-876-5210', 'ana.martinez@example.com'),
(5, 'Miguel', 'Rodriguez', 'Martinez', '341-112-2333', 'miguel@example.com'),
(6, 'Isabel', 'Gonzales', 'Diaz', '555-344-4666', 'isabel@example.com'),
(7, 'David', 'Garcia', 'Palacios', '555-710-1330', 'David@example.com'),
(8, 'Jorge', 'Hernandez', 'Jimenez', '555-222-5111', 'JH@example.com'),
(9, 'Andres', 'Soto', 'Medina', '555-892-1346', 'AndySoto@example.com'),
(10, 'Patricia', 'Ortiz', 'Vega', '555-032-2467', 'Patricia@example.com');

-- RELLENO TABLA PUESTO 
INSERT INTO PUESTO (IDPuesto, Nombre, Descripcion) VALUES
(1, 'Mecanico', 'Descripcion'),
(2, 'Recepcionista', 'Descripcion\r\n');

-- RELLENO TABLA EMPLEADO
INSERT INTO EMPLEADO (IDEmpleado, Nombre, Apellido1, Apellido2, Telefono, IDPuesto, Estado) 
VALUES
(1, 'Jose', 'Lopez', 'Ramirez', '555-111-2222', 1, 1),
(2, 'Ana', 'Gonzales', 'Herrera', '555-333-4444', 2, 1),
(3, 'Maria', 'Martinez', 'Garcia', '555112233', 1, 1);

-- RELLENO TABLA VEHICULO
INSERT INTO `VEHICULO` (`IDVehiculo`, `Marca`, `Modelo`, `Anio`, `Placa`, `Color`, `IDCliente`) VALUES
(1, 'Toyota', 2020, 1234, 'ABC123', 'Rojo', 1),
(2, 'Ford', 2019, 5678, 'XYZ987', 'Azul', 2),
(3, 'Honda', 2019, 1234, 'ABC-123', 'Azul', 3),
(4, 'Ford', 2022, 8929, 'XYZ-789', 'Blanco', 4),
(5, 'Chevrolet', 2019, 7823, 'GHI-789', 'Negro', 5),
(6, 'Volkswagen', 2018, 1356, 'JKL-012', 'Blanco', 6),
(7, 'Nissan', 2016, 6789, 'MNO-345', 'Gris', 7),
(8, 'Mercedes-Benz', 2021, 3456, 'PQR-678', 'Negro', 8),
(9, 'BMW', 2017, 3456, 'STU-901', 'Dorado', 9),
(10, 'Hyundai', 2008, 6789, 'YZA-567', 'Rojo', 10);

-- RELLENO TABLA SERVICIO
INSERT INTO SERVICIO (IDServicio, Nombre, Descripcion, Costo, Garantia, IDEmpleado, IDVehiculo) VALUES
(1, 'Cambio de aceite', 'Cambio de aceite rapido y eficiente para el vehiculo.', 50.00, 'Garantia de 3 meses', 1, 1),
(2, 'Reparacion de frenos', 'Seguridad en frenos: inspeccion, reparacion y mantenimiento.', 120.00, 'Garantia de 6 meses', 1, 2),
(3, 'Reemplazo de neumaticos', 'Reemplazo de neumaticos: Instalacion experta para un rendimiento optimo y seguridad en la carretera.', 500.00, 'Garantia 8 meses', 3, 3);

-- RELLENO TABLA PIEZA
INSERT INTO PIEZA (IDPieza, Nombre, CantidadEnStock, FechaAdquisicion, PrecioCompra, PrecioVenta, IDProveedor) 
VALUES
(1, 'Filtro de aceite', 100, '2023-01-15', 5.00, 10.00, 1),
(2, 'Pastillas de freno', 50, '2023-02-20', 10.00, 20.00, 2),
(3, 'Bateria para carro', 5, '2023-08-25', 2500.00, 3000.00, 1);

-- RELLENO TABLA CITA
INSERT INTO CITA (IDCita, IDCliente, FechaEntrada, FechaSalida, IDServicio, IDEmpleado) 
VALUES
(1, 1, '2023-10-15 10:00:00', '2023-10-15 14:00:00', 1, 1),
(2, 2, '2023-10-16 11:00:00', '2023-10-16 15:00:00', 2, 2);

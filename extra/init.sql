-- ULTIMA VERSION: 25 DE NOVIEMBRE DEL 2023 9:05 PM

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
    Modelo VARCHAR(50),
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
CREATE VIEW vista_citas AS 
SELECT 
    -- ID
    CITA.IDCita AS id_cita, 
    -- Cliente
    CONCAT(CLIENTE.Nombre, ' ', CLIENTE.Apellido1, ' ', CLIENTE.Apellido2) AS n1, 
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
CREATE VIEW vista_empleados AS
SELECT
    -- ID
    EMPLEADO.IDEmpleado AS id_empleado,
    -- Nombre Empleado
    CONCAT(EMPLEADO.Nombre, ' ', EMPLEADO.Apellido1, ' ', EMPLEADO.Apellido2) AS nombre_empleado,
    -- Telefono
    EMPLEADO.Telefono,
    -- Puesto
    PUESTO.Nombre AS nombre_puesto,
    -- Activo / Inactivo
    CASE EMPLEADO.Estado
        WHEN 1 THEN 'Activo'
        WHEN 0 THEN 'Inactivo'
        ELSE 'Desconocido'
    END AS estado_empleado
FROM
    EMPLEADO
JOIN
    PUESTO ON EMPLEADO.IDPuesto = PUESTO.IDPuesto;

-- VISTA CLIENTE
CREATE VIEW vista_clientes AS
SELECT
    IDCliente,
    CONCAT(Nombre, ' ', Apellido1, ' ', COALESCE(Apellido2, '')) AS NombreCompleto,
    Telefono,
    Email
FROM CLIENTE;

-- VISTA SERVICIO
DROP TABLE IF EXISTS vista_servicios;

CREATE VIEW vista_servicios AS
SELECT
    -- ID
    SERVICIO.IDServicio AS id_servicio,
    -- Nombre Servicio
    SERVICIO.Nombre AS nombre_servicio,
    -- Descripcion
    SERVICIO.Descripcion,
    -- Costo
    SERVICIO.Costo,
    -- Garantia
    SERVICIO.Garantia,
    -- Empleado
    CONCAT(EMPLEADO.Nombre, ' ',EMPLEADO.Apellido1, ' ', EMPLEADO.Apellido2) AS nombre_empleado,
    -- Vehiculo
    CONCAT(
        VEHICULO.Marca, ' ',
        VEHICULO.Modelo, ' ',
        VEHICULO.Placa, ' ',
        VEHICULO.Color
    ) AS nombre_vehiculo,
     -- Cliente
    CONCAT(CLIENTE.Nombre, ' ', CLIENTE.Apellido1, ' ', CLIENTE.Apellido2) AS n3
FROM
    SERVICIO
JOIN
    EMPLEADO ON SERVICIO.IDEmpleado = EMPLEADO.IDEmpleado
JOIN
    VEHICULO ON SERVICIO.IDVehiculo = VEHICULO.IDVehiculo
JOIN
    CLIENTE ON VEHICULO.IDCliente= CLIENTE.IDCliente;

-- VISTA VEHICULOS
CREATE VIEW vista_vehiculos AS
SELECT
 -- ID Vehiculo
   VEHICULO.IDVehiculo AS id_vehiculo,
   -- Marca Vehiculo
   VEHICULO.Marca,
   -- Modelo Vehiculo
   VEHICULO.Modelo,
   -- Año Vehiculo
   VEHICULO.Anio,
   -- Placa Vehiculo
   VEHICULO.Placa,
   -- Color Vehiculo
   VEHICULO.Color,
   -- Nombre cliente
   CONCAT(CLIENTE.Nombre, ' ', CLIENTE.Apellido1, ' ', CLIENTE.Apellido2) AS n4,
   -- Telefono Cliente (Si se lo quieren quitar, nomas lo puse por libertad creativa :))
   CLIENTE.Telefono AS numero_cliente
FROM
   VEHICULO
JOIN
    CLIENTE ON VEHICULO.IDCliente= CLIENTE.IDCliente;

-- VISTA PIEZA
CREATE VIEW vista_piezas AS
SELECT
   -- ID
   PIEZA.IDPieza,
   -- Nombre
   PIEZA.Nombre,
   -- Cantidad
   PIEZA.CantidadEnStock,
   -- Fecha de adquisicion
   CONCAT(
   DATE_FORMAT(PIEZA.FechaAdquisicion, '%d de '),
   (SELECT MesEspanol FROM MesesEquivalencia WHERE MesIngles = MONTHNAME(PIEZA.FechaAdquisicion)),
   DATE_FORMAT(PIEZA.FechaAdquisicion, ' de %Y')
   ) AS FechaAdquisicion,
   -- Precio de compra
   PIEZA.PrecioCompra,
   -- Precio de venta
   PIEZA.PrecioVenta,
   -- Nombre proveedor
   PROVEEDOR.Nombre AS nombre_proveedor,
   -- Telefono proveedor
   PROVEEDOR.Telefono AS telefono_proveedor
FROM PIEZA
JOIN PROVEEDOR ON PROVEEDOR.IDProveedor = PIEZA.IDProveedor;

-- RELLENO TABLA PROVEEDOR 
IINSERT INTO PROVEEDOR (IDProveedor, Nombre, Descripcion, Telefono, Email) VALUES
(1, 'AutoRepuestos Velazquez', 'Proveedor de repuestos automotrices de alta calidad.', '123-456-7890', 'info@autorepuestosvelazquez.com'),
(2, 'Herramientas Martinez', 'Especialistas en suministro de herramientas para talleres mecánicos.', '987-654-3210', 'ventas@herramientasmartinez.com'),
(3, 'Neumáticos RapidoGiro', 'Especialistas en neumáticos y servicios de alineación.', '555-7890-1234', 'info@rapido-giro-neumaticos.com'),
(4, 'Sistemas de Diagnóstico Automotriz', 'Proveedor de equipos de diagnóstico y escáneres para talleres.', '111-222-3333', 'ventas@diagnosticoautomotriz.com'),
(5, 'Lubricantes y Aceites Especiales', 'Suministro de lubricantes y aceites de alta calidad para motores.', '444-555-6666', 'info@aceitesespeciales.com'),
(6, 'Baterías PowerCharge', 'Especialistas en baterías para vehículos de todo tipo.', '777-888-9999', 'ventas@powerchargebaterias.com'),
(7, 'Frenos y Partes de Suspensión', 'Proveedor de piezas de frenos y componentes de suspensión.', '321-654-9876', 'info@frenossuspension.com'),
(8, 'Iluminación Automotriz LuzTotal', 'Suministro de sistemas de iluminación para vehículos.', '999-888-7777', 'ventas@luztotaliluminacion.com'),
(9, 'Radiadores y Sistemas de Enfriamiento', 'Proveedor de radiadores y sistemas de enfriamiento para motores.', '333-666-9999', 'info@enfriamientosistemas.com'),
(10, 'Hules y Juntas Especializadas', 'Especialistas en hules y juntas para sellos y aislamientos.', '555-111-7777', 'ventas@hulesjuntas.com');


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
(1, 'Mecánico', 'Encargado de realizar diagnósticos, reparaciones y mantenimiento de vehículos. Experiencia en el uso de herramientas y equipos especializados en mecánica automotriz.'),
(2, 'Recepcionista', 'Responsable de gestionar el front desk del taller, atender llamadas, programar citas y coordinar la comunicación entre clientes y mecánicos.'),
(3, 'Especialista en Electrónica Automotriz', 'Experto en diagnóstico y reparación de sistemas electrónicos y computarizados en vehículos modernos.'),
(4, 'Técnico en Alineación y Balanceo', 'Encargado de realizar alineaciones, balanceo de ruedas y ajustes necesarios para garantizar un manejo seguro y eficiente.'),
(5, 'Especialista en Frenos y Suspensión', 'Experto en el mantenimiento y reparación de sistemas de frenado y suspensión para garantizar la seguridad y el rendimiento del vehículo.'),
(6, 'Mecánico de Motores', 'Encargado de desmontar, reparar y ensamblar motores de vehículos, identificando y solucionando problemas mecánicos.'),
(7, 'Técnico en Sistemas de Escape', 'Especializado en la instalación y reparación de sistemas de escape, catalizadores y tuberías para garantizar la eficiencia y cumplimiento ambiental.'),
(8, 'Asesor de Servicio al Cliente', 'Responsable de recibir a los clientes, entender sus necesidades, proporcionar presupuestos y asesorar sobre los servicios necesarios para sus vehículos.'),
(9, 'Especialista en Diagnóstico de Transmisiones', 'Experto en el diagnóstico y reparación de problemas en sistemas de transmisión automática y manual.'),
(10, 'Auxiliar de Almacén de Repuestos', 'Encargado de gestionar y mantener organizado el inventario de repuestos, realizar pedidos y asegurar la disponibilidad de piezas necesarias para las reparaciones.');


-- RELLENO TABLA EMPLEADO
INSERT INTO EMPLEADO (IDEmpleado, Nombre, Apellido1, Apellido2, Telefono, IDPuesto, Estado) 
VALUES
(1, 'Jose', 'Lopez', 'Ramirez', '555-111-2222', 1, 1),
(2, 'Ana', 'Gonzales', 'Herrera', '555-333-4444', 2, 1),
(3, 'Maria', 'Martinez', 'Garcia', '555112233', 1, 1)
(4, 'Carlos', 'Perez', 'Fernandez', '555-555-5555', 3, 1),
(5, 'Luis', 'Ramirez', 'Diaz', '555-666-7777', 4, 1),
(6, 'Laura', 'Gomez', 'Santos', '555-888-9999', 5, 1),
(7, 'Pedro', 'Torres', 'Jimenez', '555-999-0000', 6, 1),
(8, 'Isabel', 'Castro', 'Rojas', '555-111-0000', 7, 1),
(9, 'Javier', 'Serrano', 'Moreno', '555-222-3333', 8, 1),
(10, 'Sara', 'Fernandez', 'Navarro', '555-444-5555', 9, 1);

-- RELLENO TABLA VEHICULO
INSERT INTO `VEHICULO` (`IDVehiculo`, `Marca`, `Modelo`, `Anio`, `Placa`, `Color`, `IDCliente`) VALUES
(1, 'Toyota', 'Corolla', 2023, 'AAA-123', 'Blanco', 1),
(2, 'Honda', 'Civic', 2022, 'BBB-456', 'Negro', 2),
(3, 'Nissan', 'Altima', 2021, 'CCC-789', 'Rojo', 3),
(4, 'Volkswagen', 'Jetta', 2020, 'DDD-012', 'Azul', 4),
(5, 'Chevrolet', 'Spark', 2019, 'EEE-345', 'Verde', 5),
(6, 'Ford', 'F-150', 2018, 'FFF-678', 'Gris', 6),
(7, 'Kia', 'Rio', 2017, 'GGG-901', 'Marron', 7),
(8, 'Hyundai', 'Elantra', 2016, 'HHH-234', 'Dorado', 8),
(9, 'Mazda', '3', 2015, 'III-567', 'Plateado', 9),
(10, 'Subaru', 'Impreza', 2014, 'JJJ-890', 'Negro', 10);


-- RELLENO TABLA SERVICIO
INSERT INTO SERVICIO (IDServicio, Nombre, Descripcion, Costo, Garantia, IDEmpleado, IDVehiculo) VALUES
(1, 'Cambio de aceite', 'Cambio de aceite rapido y eficiente para el vehiculo.', 50.00, 'Garantia de 3 meses', 1, 1),
(2, 'Reparacion de frenos', 'Seguridad en frenos: inspeccion, reparacion y mantenimiento.', 120.00, 'Garantia de 6 meses', 1, 2),
(3, 'Reemplazo de neumaticos', 'Reemplazo de neumaticos: Instalacion experta para un rendimiento optimo y seguridad en la carretera.', 500.00, 'Garantia 8 meses', 3, 3),
(4, 'Alineacion y balanceo', 'Servicio profesional de alineación y balanceo para un manejo suave y seguro.', 80.00, 'Garantia de 4 meses', 2, 4),
(5, 'Diagnóstico electrónico', 'Diagnóstico avanzado para identificar y solucionar problemas electrónicos en el vehículo.', 150.00, 'Garantia de 3 meses', 3, 5),
(6, 'Cambio de batería', 'Reemplazo y instalación de baterías de alta calidad para un arranque confiable.', 100.00, 'Garantia de 12 meses', 4, 6),
(7, 'Reparación de transmisión', 'Servicio especializado para reparar problemas en la transmisión automática o manual.', 300.00, 'Garantia de 9 meses', 5, 7),
(8, 'Servicio de frenos ABS', 'Reparación y mantenimiento de sistemas de frenos antibloqueo (ABS) para mayor seguridad.', 180.00, 'Garantia de 6 meses', 6, 8),
(9, 'Cambio de bujías y cables', 'Sustitución de bujías y cables para un rendimiento óptimo del motor.', 60.00, 'Garantia de 3 meses', 7, 9),
(10, 'Servicio de aire acondicionado', 'Mantenimiento y reparación del sistema de aire acondicionado para un viaje cómodo.', 120.00, 'Garantia de 5 meses', 8, 10);

-- RELLENO TABLA PIEZA
INSERT INTO PIEZA (IDPieza, Nombre, CantidadEnStock, FechaAdquisicion, PrecioCompra, PrecioVenta, IDProveedor) 
VALUES
(1, 'Filtro de aceite', 100, '2023-01-15', 5.00, 10.00, 1),
(2, 'Pastillas de freno', 50, '2023-02-20', 10.00, 20.00, 2),
(3, 'Bateria para carro', 5, '2023-08-25', 2500.00, 3000.00, 1),
(4, 'Liquido de frenos', 30, '2023-03-10', 8.00, 15.00, 3),
(5, 'Neumático radial', 20, '2023-05-05', 60.00, 100.00, 4),
(6, 'Bujías de encendido', 50, '2023-06-18', 2.50, 5.00, 5),
(7, 'Aceite de transmisión', 40, '2023-07-22', 12.00, 25.00, 6),
(8, 'Filtro de aire', 80, '2023-09-05', 3.00, 7.00, 7),
(9, 'Cables de bujías', 25, '2023-10-15', 4.50, 9.00, 8),
(10, 'Líquido refrigerante', 35, '2023-11-30', 6.00, 12.00, 9);

-- RELLENO TABLA CITA
INSERT INTO CITA (IDCita, IDCliente, FechaEntrada, FechaSalida, IDServicio, IDEmpleado) 
VALUES
(1, 1, '2023-10-15 10:00:00', '2023-10-15 14:00:00', 1, 1),
(2, 2, '2023-10-16 11:00:00', '2023-10-16 15:00:00', 2, 2),
(3, 3, '2023-10-18 09:30:00', '2023-10-18 13:30:00', 3, 3),
(4, 4, '2023-10-20 14:00:00', '2023-10-20 18:00:00', 4, 4),
(5, 5, '2023-10-22 08:45:00', '2023-10-22 12:45:00', 5, 5),
(6, 6, '2023-10-25 12:30:00', '2023-10-25 16:30:00', 6, 6),
(7, 7, '2023-10-27 10:15:00', '2023-10-27 14:15:00', 7, 7),
(8, 8, '2023-10-29 15:00:00', '2023-10-29 19:00:00', 8, 8),
(9, 9, '2023-11-01 13:45:00', '2023-11-01 17:45:00', 9, 9),
(10, 10, '2023-11-03 11:30:00', '2023-11-03 15:30:00', 10, 10);

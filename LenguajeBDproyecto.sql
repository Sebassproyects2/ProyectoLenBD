-- =============================================================================
--                              Creacion de tablas
-- =============================================================================

CREATE TABLE Hotel (
Id_Hotel NUMBER PRIMARY KEY not null, -- llave primaria
Nombre VARCHAR(50) NOT NULL,
Ciudad VARCHAR(50) NOT NULL,
Canton VARCHAR(50) NOT NULL,
Distrito VARCHAR(50) NOT NULL,
Detalle_Direccion VARCHAR(50) NOT NULL,
Telefono VARCHAR(30) NOT NULL,
Numero_pisos INT NOT NULL
);

CREATE TABLE Proveedor (
Id_Proveedor NUMBER PRIMARY KEY not null, -- llave primaria
Nombre VARCHAR(30) NOT NULL,
Contacto VARCHAR(30) NOT NULL,
Telefono INT NOT NULL,
Email varchar(30) NOT NULL,
Ciudad varchar(30) NOT NULL,
Tipo varchar(30) NOT NULL,
Fecha_registro DATE NOT NULL
);

CREATE TABLE Suministro (
Id_Suministro NUMBER PRIMARY KEY not null, -- llave primaria
FK_Proveedor NUMBER NOT NULL,
FK_Hotel NUMBER NOT NULL,
Nombre varchar(30) NOT NULL,
Descripcion VARCHAR(50) NOT NULL,
Cantidad INT NOT NULL,
Costo FLOAT NOT NULL,
CONSTRAINT FK_idProveedor FOREIGN KEY (FK_Proveedor) REFERENCES Proveedor (Id_Proveedor),
CONSTRAINT FK_idHotel FOREIGN KEY (FK_Hotel) REFERENCES Hotel (Id_Hotel)
);

CREATE TABLE Promocion (
Id_Promocion NUMBER PRIMARY KEY not null, -- llave primaria
FK_Hotel NUMBER NOT NULL,
Descripcion VARCHAR(30) NOT NULL,
Fecha_Inicio DATE NOT NULL,
Fecha_Fin DATE NOT NULL,
CONSTRAINT FK_idHotelPromo FOREIGN KEY (FK_Hotel) REFERENCES Hotel (Id_Hotel)
);

CREATE TABLE Tipo_Promocion (
Id_Tipo_Promocion NUMBER PRIMARY KEY not null, -- llave primaria
Nombre VARCHAR(30) NOT NULL,
Detalle VARCHAR(300) NOT NULL
);

CREATE TABLE Vehiculo (
Id_Vehiculo NUMBER PRIMARY KEY not null, -- llave primaria
FK_Hotel NUMBER NOT NULL,
Tipo VARCHAR(30) NOT NULL,
Marca VARCHAR(30) NOT NULL,
Modelo VARCHAR(50) NOT NULL,
Aï¿½o INT NOT NULL,
Placa CHAR(8) NOT NULL,
CONSTRAINT FK_idHotelVehiculo FOREIGN KEY (FK_Hotel) REFERENCES Hotel (Id_Hotel)
);

CREATE TABLE Inventario (
Id_Inventario NUMBER PRIMARY KEY not null, -- llave primaria
FK_Hotel NUMBER NOT NULL,
Nombre VARCHAR(30) NOT NULL,
Tipo VARCHAR(30) NOT NULL,
Marca VARCHAR(50) NOT NULL,
Modelo VARCHAR(50) NOT NULL,
Serie VARCHAR (20) NOT NULL,
Fecha_Registro DATE NOT NULL,
Cantidad INT NOT NULL,
CONSTRAINT FK_idHotelInv FOREIGN KEY (FK_Hotel) REFERENCES Hotel (Id_Hotel)
);

CREATE TABLE Puesto (
Id_Puesto NUMBER PRIMARY KEY not null, -- llave primaria
Nombre VARCHAR(30) NOT NULL,
Salario INT NOT NULL
);

CREATE TABLE Empleado (
Id_Empleado NUMBER PRIMARY KEY not null, -- llave primaria
FK_Hotel NUMBER NOT NULL,
FK_Puesto NUMBER NOT NULL,
Nombre VARCHAR(30) NOT NULL,
Cedula INT NOT NULL,
Correo VARCHAR(50) NOT NULL,
Telefono INT NOT NULL,
Fecha_Ingreso DATE NOT NULL,
CONSTRAINT FK_idHotelEmpleado FOREIGN KEY (FK_Hotel) REFERENCES Hotel (Id_Hotel),
CONSTRAINT FK_idPuestoEmpleado FOREIGN KEY (FK_Puesto) REFERENCES Puesto (Id_Puesto)
);

CREATE TABLE Evento (
Id_Evento NUMBER PRIMARY KEY not null, -- llave primaria
FK_Hotel NUMBER NOT NULL,
Nombre VARCHAR(30) NOT NULL,
Capacidad VARCHAR(30) NOT NULL,
Fecha_Inicio DATE NOT NULL,
Fecha_Fin DATE NOT NULL,
CONSTRAINT FK_idHotelEvento FOREIGN KEY (FK_Hotel) REFERENCES Hotel (Id_Hotel)
);

CREATE TABLE Huesped (
Id_Huesped NUMBER PRIMARY KEY not null, -- llave primaria
Nombre VARCHAR(30) NOT NULL,
Cedula INT NOT NULL,
Apellido1 VARCHAR(30) NOT NULL,
Apellido2 VARCHAR(30) NOT NULL,
Correo VARCHAR(30) NOT NULL,
Telefono INT NOT NULL,
Fecha_Nacimiento DATE NOT NULL,
Fecha_Registro DATE NOT NULL
);

CREATE TABLE TipoHabitacion (
Id_TipoHabitacion NUMBER PRIMARY KEY not null, -- llave primaria
Nombre VARCHAR(50) NOT NULL,
Capacidad VARCHAR(20) NOT NULL,
Numero_Camas INT NOT NULL,
Vista VARCHAR(30) NOT NULL,
Precio_PorNoche DECIMAL(10, 2) NOT NULL,
Estado VARCHAR(30) NOT NULL
);

CREATE TABLE Habitacion (
Id_Habitacion NUMBER PRIMARY KEY not null, -- llave primaria
FK_TipoHabitacion NUMBER NOT NULL,
Numero_Habitacion INT NOT NULL,
Descripcion VARCHAR(50) NOT NULL,
Estado VARCHAR(30) NOT NULL,
CONSTRAINT FK_idTipoHabitacion FOREIGN KEY (FK_TipoHabitacion) REFERENCES TipoHabitacion (Id_TipoHabitacion)
);

CREATE TABLE Mantenimiento (
Id_Mantenimiento NUMBER PRIMARY KEY not null, -- llave primaria
FK_Habitacion NUMBER NOT NULL,
FK_Proveedor NUMBER NOT NULL,
Descripcion VARCHAR(50)NOT NULL,
Fecha_Inicio DATE NOT NULL,
CONSTRAINT FK_idHabitacionMantenimiento FOREIGN KEY (FK_Habitacion) REFERENCES Habitacion (Id_Habitacion),
CONSTRAINT FK_idProveedorMantenimiento  FOREIGN KEY (FK_Proveedor) REFERENCES Proveedor (Id_Proveedor)
);

CREATE TABLE Restaurante (
Id_Restaurante NUMBER PRIMARY KEY not null, -- llave primaria
FK_Hotel NUMBER NOT NULL,
Nombre VARCHAR(50)NOT NULL,
Num_Mesas INT NOT NULL,
Capacidad INT NOT NULL,
CONSTRAINT FK_idHotelRestaurante FOREIGN KEY (FK_Hotel) REFERENCES Hotel (Id_Hotel)
);

CREATE TABLE ReservacionRestaurante (
Id_ReservacionRestaurante NUMBER PRIMARY KEY not null, -- llave primaria
FK_Huesped NUMBER NOT NULL,
FK_Hotel NUMBER NOT NULL,
Nombre_Rest VARCHAR (30) NOT NULL,
Fecha_Reservacion DATE NOT NULL,
Cantidad INT NOT NULL,
CONSTRAINT FK_idHuespedRe FOREIGN KEY (FK_Huesped) REFERENCES Huesped (Id_Huesped),
CONSTRAINT FK_idHotelRe FOREIGN KEY (FK_Hotel) REFERENCES Hotel (Id_Hotel)
);

ALTER TABLE ReservacionRestaurante
DROP COLUMN Nombre_Rest;

ALTER TABLE ReservacionRestaurante
ADD FK_Restaurante NUMBER;

ALTER TABLE ReservacionRestaurante
ADD CONSTRAINT FK_idRestauranteRe
FOREIGN KEY (FK_Restaurante) REFERENCES Restaurante(Id_Restaurante);


CREATE TABLE Servicio (
Id_Servicio NUMBER PRIMARY KEY not null, -- llave primaria
Nombre VARCHAR(50)NOT NULL,
Precio FLOAT NOT NULL,
Tipo VARCHAR(50) NOT  NULL
);

CREATE TABLE CheckIn (
Id_CheckIn NUMBER PRIMARY KEY not null, -- llave primaria
Fecha_CheckIn DATE NOT NULL,
Estado VARCHAR(30) NOT NULL
);

DROP TABLE CheckIn CASCADE CONSTRAINTS;

--===========================================================================

CREATE TABLE CheckOut (
Id_CheckOut NUMBER PRIMARY KEY not null, -- llave primaria
Fecha_CheckOut DATE NOT NULL,
Estado VARCHAR(30) NOT NULL,
Mensaje VARCHAR(30) NOT NULL
);
DROP TABLE CheckOut CASCADE CONSTRAINTS;


-----------------------------------------------------------------------------------
CREATE TABLE Reservacion (
Id_Reservacion NUMBER PRIMARY KEY not null, -- llave primaria
FK_Huesped NUMBER NOT NULL,
FK_Hotel NUMBER NOT NULL,
FK_Habitacion NUMBER NOT NULL,
FK_Promocion NUMBER NOT NULL,
FK_CheckIn NUMBER NOT NULL,
FK_CheckOut NUMBER NOT NULL,
Estado VARCHAR(30) NOT NULL,
Comentarios VARCHAR(255) NULL,
CONSTRAINT FK_Reservacion_Huesped FOREIGN KEY (FK_Huesped) REFERENCES Huesped (Id_Huesped),
CONSTRAINT FK_Reservacion_Hotel FOREIGN KEY (FK_Hotel) REFERENCES Hotel (Id_Hotel),
CONSTRAINT FK_Reservacion_Habitacion FOREIGN KEY (FK_Habitacion) REFERENCES Habitacion (Id_Habitacion),
CONSTRAINT FK_Reservacion_CheckIn FOREIGN KEY (FK_CheckIn) REFERENCES CheckIn (Id_CheckIn),
CONSTRAINT FK_Reservacion_CheckOut FOREIGN KEY (FK_CheckOut) REFERENCES CheckOut (Id_CheckOut),
CONSTRAINT FK_Reservacion_Promocion FOREIGN KEY (FK_Promocion) REFERENCES Promocion (Id_Promocion)
);

ALTER TABLE Reservacion DROP COLUMN FK_CheckIn;

ALTER TABLE Reservacion DROP COLUMN FK_CheckOut;

ALTER TABLE Reservacion
ADD Fecha_CheckIn DATE;

ALTER TABLE Reservacion
ADD Fecha_CheckOut DATE;

CREATE TABLE Factura (
Id_Factura NUMBER PRIMARY KEY not null, -- llave primaria
FK_Reservacion NUMBER NOT NULL,
Fecha_Emision DATE NOT NULL,
Descuento INT NOT NULL,
Metodo_Pago VARCHAR(30) NOT NULL,
Monto FLOAT NOT NULL,
Estado VARCHAR(30) NOT NULL,
CONSTRAINT FK_idResevacion FOREIGN KEY (FK_Reservacion) REFERENCES Reservacion (Id_Reservacion)
);

-- ============================================================================
--                              Inserts
-- =============================================================================


-- ======================= Hoteles=======================

CREATE OR REPLACE PROCEDURE agregarHoteles(
    v_id_hotel IN NUMBER,
    v_nombre IN VARCHAR2,
    v_ciudad IN VARCHAR2,
    v_canton IN VARCHAR2,
    v_distrito IN VARCHAR2,
    v_detalle_direccion IN VARCHAR2,
    v_telefono IN VARCHAR2,
    v_numero_pisos IN INT
)
AS
BEGIN
    INSERT INTO Hotel (Id_Hotel, Nombre, Ciudad, Canton, Distrito, Detalle_Direccion, Telefono, Numero_pisos)
    VALUES (v_id_hotel, v_nombre, v_ciudad, v_canton, v_distrito, v_detalle_direccion, v_telefono, v_numero_pisos);
    
commit;
Exception
when others then 
rollback;

END;

BEGIN

agregarHoteles(1, 'Hotel Verde', 'San Josï¿½', 'Central', 'Carmen', 'Av. Principal #123', '2222-3333', 5);
agregarHoteles(2, 'Hotel Vistas', 'Alajuela', 'Central', 'San Josï¿½', 'Calle Sol #45', '2444-5555', 3);
agregarHoteles(3, 'Hotel Flores', 'Heredia', 'San Rafael', 'Los ï¿½ngeles', 'Blvd. Este #67', '2666-7777', 4);
agregarHoteles(4, 'Hotel Catedral', 'Cartago', 'Oreamuno', 'San Rafael', 'Carretera Vieja #89', '2555-6666', 6);    
agregarHoteles(5, 'Hotel Marea', 'Puntarenas', 'Central', 'Barrio El Carmen', 'Paseo Marï¿½timo #101', '2777-8888', 2);
agregarHoteles(6, 'prueba eliminacion', 'Puntarenas', 'Central', 'Barrio El Carmen', 'Paseo Marï¿½timo #101', '2777-8888', 2);
END;


-- =================== Provedor ==============================================

CREATE OR REPLACE PROCEDURE agregarProveedor(
    v_id_proveedor IN NUMBER,
    v_nombre IN VARCHAR2,
    v_contacto IN VARCHAR2,
    v_telefono IN INT,
    v_email IN VARCHAR2,
    v_ciudad IN VARCHAR2,
    v_tipo IN VARCHAR2,
    v_fecha_registro IN DATE
)
AS
BEGIN
    
    INSERT INTO Proveedor (Id_Proveedor, Nombre, Contacto, Telefono, Email, Ciudad, Tipo, Fecha_registro)
    VALUES (v_id_proveedor, v_nombre, v_contacto, v_telefono, v_email, v_ciudad, v_tipo, v_fecha_registro);
    
COMMIT;  

EXCEPTION
WHEN OTHERS THEN
ROLLBACK;  
END;

BEGIN
agregarProveedor(1, 'Suministros Varios CR', 'Juan Pï¿½rez', 88885555, 'contacto@suministroscr.com', 'San Josï¿½', 'Limpieza', TO_DATE('2023-01-15', 'YYYY-MM-DD'));
agregarProveedor(2, 'Alimentos CR', 'Marï¿½a Lï¿½pez', 87776666, 'ventas@alimentospv.com', 'Heredia', 'Alimentos', TO_DATE('2022-12-01', 'YYYY-MM-DD'));
agregarProveedor(3, 'Gallo', 'Carlos Ramï¿½rez', 86667777, 'info@electrotico.com', 'Alajuela', 'Electrodomï¿½sticos', TO_DATE('2023-02-10', 'YYYY-MM-DD'));
agregarProveedor(4, 'Muebles Cartago', 'Ana Gï¿½mez', 85554444, 'soporte@mueblesfinos.com', 'Cartago', 'Mobiliario', TO_DATE('2022-11-20', 'YYYY-MM-DD'));
agregarProveedor(5, 'Decoraciones SA', 'Pedro Rojas', 84443333, 'ventas@decoraciones.com', 'Puntarenas', 'Decoraciï¿½n', TO_DATE('2023-03-05', 'YYYY-MM-DD'));
END;



-- ====================== Suministros ==============================

CREATE OR REPLACE PROCEDURE agregarSuministro(
    v_id_suministro IN NUMBER,
    v_fk_proveedor IN NUMBER,
    v_fk_hotel IN NUMBER,
    v_nombre IN VARCHAR2,
    v_descripcion IN VARCHAR2,
    v_cantidad IN INT,
    v_costo IN FLOAT
)
AS
BEGIN

    INSERT INTO Suministro (Id_Suministro, FK_Proveedor, FK_Hotel, Nombre, Descripcion, Cantidad, Costo)
    VALUES (v_id_suministro, v_fk_proveedor, v_fk_hotel, v_nombre, v_descripcion, v_cantidad, v_costo);
    
COMMIT;  
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;  
END;

BEGIN

agregarSuministro(1, 1, 1, 'Jabï¿½n lï¿½quido', 'Jabï¿½n antibacterial 500ml', 100, 20000);
agregarSuministro(2, 2, 2, 'Cafï¿½ premium', 'Cafï¿½ en grano 1kg', 50, 30000);
agregarSuministro(3, 3, 3, 'Televisor LED', 'Smart TV 42 pulgadas', 10, 500000);
agregarSuministro(4, 4, 4, 'Sillï¿½n de recepciï¿½n', 'Sillï¿½n de cuero negro', 5, 200000);
agregarSuministro(5, 5, 5, 'Cuadros decorativos', 'Set de 3 cuadros modernos', 15, 100000);
END;

-- ===================   Promocion ==================================

CREATE OR REPLACE PROCEDURE agregarPromocion(
    v_id_promocion IN NUMBER,
    v_fk_hotel IN NUMBER,
    v_descripcion IN VARCHAR2,
    v_fecha_inicio IN DATE,
    v_fecha_fin IN DATE
)
AS
BEGIN

    INSERT INTO Promocion (Id_Promocion, FK_Hotel, Descripcion, Fecha_Inicio, Fecha_Fin)
    VALUES (v_id_promocion, v_fk_hotel, v_descripcion, v_fecha_inicio, v_fecha_fin);
    
    COMMIT;  

EXCEPTION
WHEN OTHERS THEN
ROLLBACK;  
END;

BEGIN

agregarPromocion(1, 1, 'Descuento verano', TO_DATE('2025-06-01', 'YYYY-MM-DD'), TO_DATE('2025-07-31', 'YYYY-MM-DD'));
agregarPromocion(2, 2, 'Fin de semana romï¿½ntico', TO_DATE('2025-02-14', 'YYYY-MM-DD'), TO_DATE('2025-02-16', 'YYYY-MM-DD'));
agregarPromocion(3, 3, 'Estadï¿½a lealtad', TO_DATE('2025-03-10', 'YYYY-MM-DD'), TO_DATE('2025-04-10', 'YYYY-MM-DD'));
agregarPromocion(4, 4, 'Promociï¿½n familiar', TO_DATE('2025-05-01', 'YYYY-MM-DD'), TO_DATE('2025-05-31', 'YYYY-MM-DD'));
agregarPromocion(5, 5, '2x1 en habitaciones dobles', TO_DATE('2025-09-01', 'YYYY-MM-DD'), TO_DATE('2025-09-15', 'YYYY-MM-DD'));
END;

-- ================ Tipo_Promocion ===========================

CREATE OR REPLACE PROCEDURE agregarTipoPromocion(
    v_id_tipo_promocion IN NUMBER,
    v_nombre IN VARCHAR2,
    v_detalle IN VARCHAR2
)
AS
BEGIN

    INSERT INTO Tipo_Promocion (Id_Tipo_Promocion, Nombre, Detalle)
    VALUES (v_id_tipo_promocion, v_nombre, v_detalle);
    
COMMIT;  

EXCEPTION
WHEN OTHERS THEN
ROLLBACK;  
END;

BEGIN

agregarTipoPromocion(1, 'Descuento', 'Se aplica un descuento sobre el precio total de la reserva');
agregarTipoPromocion(2, 'Paquete', 'Incluye alojamiento y actividades turï¿½sticas');
agregarTipoPromocion(3, 'Upgrade gratis', 'Los huï¿½spedes reciben una mejora de habitaciï¿½n sin costo adicional');
agregarTipoPromocion(4, 'Puntos dobles', 'Se duplican los puntos de fidelidad en esta promociï¿½n');
agregarTipoPromocion(5, 'Cena incluida', 'La promociï¿½n incluye una cena gratis por noche reservada');
END;

-- ======================= Vehiculo ========================================

CREATE OR REPLACE PROCEDURE agregarVehiculo(
    v_id_vehiculo IN NUMBER,
    v_fk_hotel IN NUMBER,
    v_tipo IN VARCHAR2,
    v_marca IN VARCHAR2,
    v_modelo IN VARCHAR2,
    v_ano IN INT,
    v_placa IN CHAR
)
AS
BEGIN

    INSERT INTO Vehiculo (Id_Vehiculo, FK_Hotel, Tipo, Marca, Modelo, Aï¿½o, Placa)
    VALUES (v_id_vehiculo, v_fk_hotel, v_tipo, v_marca, v_modelo, v_ano, v_placa);
    
COMMIT;  
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;  
END;

BEGIN

    agregarVehiculo(1, 1, 'Automï¿½vil', 'Toyota', 'Corolla', 2020, 'ABC1234');
    agregarVehiculo(2, 2, 'Minivan', 'Honda', 'Odyssey', 2021, 'DEF1234');
    agregarVehiculo(3, 3, 'pick-up', 'Ford', 'Explorer', 2019, 'GHIJ123');
    agregarVehiculo(4, 4, 'Buseta', 'Mercedes', 'Sprinter', 2022, 'ABC4567');
    agregarVehiculo(5, 5, 'Motocicleta', 'Yamaha', 'XSR900', 2023, 'TRU8523');
END;


-- ======================== Inventario ==================================

CREATE OR REPLACE PROCEDURE agregarInventario(
    v_id_inventario IN NUMBER,
    v_fk_hotel IN NUMBER,
    v_nombre IN VARCHAR2,
    v_tipo IN VARCHAR2,
    v_marca IN VARCHAR2,
    v_modelo IN VARCHAR2,
    v_serie IN VARCHAR2,
    v_fecha_registro IN DATE,
    v_cantidad IN INT
)
AS
BEGIN

    INSERT INTO Inventario (Id_Inventario, FK_Hotel, Nombre, Tipo, Marca, Modelo, Serie, Fecha_Registro, Cantidad)
    VALUES (v_id_inventario, v_fk_hotel, v_nombre, v_tipo, v_marca, v_modelo, v_serie, v_fecha_registro, v_cantidad);
    
COMMIT;  
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;  
END;

BEGIN

agregarInventario(1, 1, 'Televisor', 'Electrï¿½nico', 'Samsung', 'SmartTV 50"', 'SER123456', TO_DATE('2024-01-10', 'YYYY-MM-DD'), 10);
agregarInventario(2, 2, 'Aire Acondicionado', 'Electrodomï¿½stico', 'LG', 'Max', 'SER654321', TO_DATE('2023-12-15', 'YYYY-MM-DD'), 8);
agregarInventario(3, 3, 'Colchï¿½n King Size', 'Mobiliario', 'Sealy', 'Suave', 'SER987654', TO_DATE('2024-02-20', 'YYYY-MM-DD'), 20);
agregarInventario(4, 4, 'Computadora', 'Electrï¿½nico', 'Dell', 'Inspiron 15', 'SER741852', TO_DATE('2024-03-01', 'YYYY-MM-DD'), 5);
agregarInventario(5, 5, 'Sillas de conferencia', 'Mobiliario', 'Mugui', 'Ergonomico', 'SER369258', TO_DATE('2024-01-30', 'YYYY-MM-DD'), 50);
END;

-- ================ Puesto ==============================

CREATE OR REPLACE PROCEDURE agregarPuesto(
    v_id_puesto IN NUMBER,
    v_nombre IN VARCHAR2,
    v_salario IN INT
)
AS
BEGIN
    
    INSERT INTO Puesto (Id_Puesto, Nombre, Salario)
    VALUES (v_id_puesto, v_nombre, v_salario);
    
COMMIT;
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;  
END;

BEGIN

agregarPuesto(1, 'Recepcionista', 500000);
agregarPuesto(2, 'Gerente', 1600000);
agregarPuesto(3, 'Cocinero', 800000);
agregarPuesto(4, 'Mucama', 500000);
agregarPuesto(5, 'Mantenimiento', 750000);
END;

-- ================ Empleado ===============================

CREATE OR REPLACE PROCEDURE agregarEmpleado(
    v_id_empleado IN NUMBER,
    v_fk_hotel IN NUMBER,
    v_fk_puesto IN NUMBER,
    v_nombre IN VARCHAR2,
    v_cedula IN INT,
    v_correo IN VARCHAR2,
    v_telefono IN INT,
    v_fecha_ingreso IN DATE
)
AS
BEGIN
    
    INSERT INTO Empleado (Id_Empleado, FK_Hotel, FK_Puesto, Nombre, Cedula, Correo, Telefono, Fecha_Ingreso)
    VALUES (v_id_empleado, v_fk_hotel, v_fk_puesto, v_nombre, v_cedula, v_correo, v_telefono, v_fecha_ingreso);
    
COMMIT;  
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;  
END;

BEGIN

agregarEmpleado(1, 1, 1, 'Maria Rodriguez', 12345678, 'mariaRodriguez@gmail.com', 88881111, TO_DATE('2022-05-10', 'YYYY-MM-DD'));
agregarEmpleado(2, 2, 2, 'Ricardo Arce', 87654321, 'ricardoArce@gmail.com', 89992222, TO_DATE('2021-08-15', 'YYYY-MM-DD'));
agregarEmpleado(3, 3, 3, 'Keylin Peï¿½a', 11223344, 'keypeï¿½a@gmail.com', 87773333, TO_DATE('2023-01-20', 'YYYY-MM-DD'));
agregarEmpleado(4, 4, 4, 'Josï¿½ Fernï¿½ndez', 44332211, 'josefernandez@gmail.com', 85554444, TO_DATE('2020-11-30', 'YYYY-MM-DD'));
agregarEmpleado(5, 5, 5, 'Valeria Solano', 55667788, 'valeriasolano@gmail.com', 82221111, TO_DATE('2024-02-05', 'YYYY-MM-DD'));
END;

-- =========================== Evento ====================================

CREATE OR REPLACE PROCEDURE agregarEvento(
    v_id_evento IN NUMBER,
    v_fk_hotel IN NUMBER,
    v_nombre IN VARCHAR2,
    v_capacidad IN VARCHAR2,
    v_fecha_inicio IN DATE,
    v_fecha_fin IN DATE
)
AS
BEGIN

    INSERT INTO Evento (Id_Evento, FK_Hotel, Nombre, Capacidad, Fecha_Inicio, Fecha_Fin)
    VALUES (v_id_evento, v_fk_hotel, v_nombre, v_capacidad, v_fecha_inicio, v_fecha_fin);
    
COMMIT;
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;
END;

BEGIN

    agregarEvento(1, 1, 'Conferencia Tech', '100', TO_DATE('2025-04-10', 'YYYY-MM-DD'), TO_DATE('2025-04-12', 'YYYY-MM-DD'));
    agregarEvento(2, 2, 'Boda', '70', TO_DATE('2025-05-20', 'YYYY-MM-DD'), TO_DATE('2025-05-21', 'YYYY-MM-DD'));
    agregarEvento(3, 3, 'Fiesta Empresarial', '200', TO_DATE('2025-06-15', 'YYYY-MM-DD'), TO_DATE('2025-06-16', 'YYYY-MM-DD'));
    agregarEvento(4, 4, 'Evento empleo', '80', TO_DATE('2025-07-05', 'YYYY-MM-DD'), TO_DATE('2025-07-06', 'YYYY-MM-DD'));
    agregarEvento(5, 5, 'Graduacion', '120', TO_DATE('2025-08-10', 'YYYY-MM-DD'), TO_DATE('2025-08-10', 'YYYY-MM-DD'));
END;

-- ======================= Huesped =======================

CREATE OR REPLACE PROCEDURE agregarHuesped(
    v_id_huesped IN NUMBER,
    v_nombre IN VARCHAR2,
    v_cedula IN INT,
    v_apellido1 IN VARCHAR2,
    v_apellido2 IN VARCHAR2,
    v_correo IN VARCHAR2,
    v_telefono IN INT,
    v_fecha_nacimiento IN DATE,
    v_fecha_registro IN DATE
)
AS
BEGIN

    INSERT INTO Huesped (Id_Huesped, Nombre, Cedula, Apellido1, Apellido2, Correo, Telefono, Fecha_Nacimiento, Fecha_Registro)
    VALUES (v_id_huesped, v_nombre, v_cedula, v_apellido1, v_apellido2, v_correo, v_telefono, v_fecha_nacimiento, v_fecha_registro);
    
COMMIT;  
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;
END;

BEGIN

agregarHuesped(1, 'Carlos', 12345678, 'Gï¿½mez', 'Ramï¿½rez', 'carlosgomez@gmail.com', 88881111, TO_DATE('1990-05-10', 'YYYY-MM-DD'), TO_DATE('2024-02-01', 'YYYY-MM-DD'));
agregarHuesped(2, 'Ana', 87654321, 'Martï¿½nez', 'Fernï¿½ndez', 'anamartinez@gmail.com', 89992222, TO_DATE('1985-08-20', 'YYYY-MM-DD'), TO_DATE('2024-02-03', 'YYYY-MM-DD'));
agregarHuesped(3, 'Javier', 11223344, 'Lï¿½pez', 'Hernï¿½ndez', 'javierlopez@gmail.com', 87773333, TO_DATE('1995-11-15', 'YYYY-MM-DD'), TO_DATE('2024-02-05', 'YYYY-MM-DD'));
agregarHuesped(4, 'Sofï¿½a', 44332211, 'Rodrï¿½guez', 'Dï¿½az', 'sofiarodriguez@gmail.com', 85554444, TO_DATE('2000-01-25', 'YYYY-MM-DD'), TO_DATE('2024-02-07', 'YYYY-MM-DD'));
agregarHuesped(5, 'Miguel', 55667788, 'Fernï¿½ndez', 'Castro', 'miguelfernandez@gmail.com', 82221111, TO_DATE('1988-06-30', 'YYYY-MM-DD'), TO_DATE('2024-02-09', 'YYYY-MM-DD'));
END;

--  ========================== TipoHabitacion ===================

CREATE OR REPLACE PROCEDURE agregarTipoHabitacion(
    v_id_tipohabitacion IN NUMBER,
    v_nombre IN VARCHAR2,
    v_capacidad IN VARCHAR2,
    v_numero_camas IN INT,
    v_vista IN VARCHAR2,
    v_precio_pornoche IN DECIMAL,
    v_estado IN VARCHAR2
)
AS
BEGIN

    INSERT INTO TipoHabitacion (Id_TipoHabitacion, Nombre, Capacidad, Numero_Camas, Vista, Precio_PorNoche, Estado)
    VALUES (v_id_tipohabitacion, v_nombre, v_capacidad, v_numero_camas, v_vista, v_precio_pornoche, v_estado);
    
COMMIT;
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;
END;

BEGIN

agregarTipoHabitacion(1, 'Habitacion individual', '1 Persona', 1, 'Vista al mar', 12500, 'Disponible');
agregarTipoHabitacion(2, 'Habitaciï¿½n doble', '2 personas', 2, 'Vista a la ciudad', 20000, 'Disponible');
agregarTipoHabitacion(3, 'Habitaciï¿½n familiar', '4 personas', 3, 'Vista al jardï¿½n', 27500, 'Ocupado');
agregarTipoHabitacion(4, 'Penthouse', '6 personas', 5, 'Vista panorï¿½mica', 37000, 'Mantenimiento');
agregarTipoHabitacion(5, 'Habitacion tematica', '3 personas', 2, 'Vista a la playa', 42000, 'Reservado');
END;

-- =================== Habitacion ===========================

CREATE OR REPLACE PROCEDURE agregarHabitacion(
    v_id_habitacion IN NUMBER,
    v_fk_tipohabitacion IN NUMBER,
    v_numero_habitacion IN INT,
    v_descripcion IN VARCHAR2,
    v_estado IN VARCHAR2
)
AS
BEGIN

    INSERT INTO Habitacion (Id_Habitacion, FK_TipoHabitacion, Numero_Habitacion, Descripcion, Estado)
    VALUES (v_id_habitacion, v_fk_tipohabitacion, v_numero_habitacion, v_descripcion, v_estado);
    
COMMIT;
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;  
END;

BEGIN

    agregarHabitacion(1, 1, 101, 'Habitacion con jacuzzi y terraza privada', 'Disponible');
    agregarHabitacion(2, 2, 202, 'Habitacion con 2 camas individuales', 'Disponible');
    agregarHabitacion(3, 3, 303, 'Habitacion con cama matrimonial y 2 individuales', 'Ocupado');
    agregarHabitacion(4, 4, 404, 'Penthouse con bar y sala de estar', 'Mantenimiento');
    agregarHabitacion(5, 5, 505, 'Habitacion con acceso directo a la playa', 'Reservado');
END;

-- ====================== Mantenimiento ============================

CREATE OR REPLACE PROCEDURE agregarMantenimiento(
    v_id_mantenimiento IN NUMBER,
    v_fk_habitacion IN NUMBER,
    v_fk_proveedor IN NUMBER,
    v_descripcion IN VARCHAR2,
    v_fecha_inicio IN DATE
)
AS
BEGIN
    
    INSERT INTO Mantenimiento (Id_Mantenimiento, FK_Habitacion, FK_Proveedor, Descripcion, Fecha_Inicio)
    VALUES (v_id_mantenimiento, v_fk_habitacion, v_fk_proveedor, v_descripcion, v_fecha_inicio);
    
COMMIT;
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;  
END;

BEGIN

    agregarMantenimiento(1, 4, 1, 'Reparaciï¿½n de jacuzzi', TO_DATE('2024-02-15', 'YYYY-MM-DD'));
    agregarMantenimiento(2, 5, 2, 'Cambio de muebles en la sala', TO_DATE('2024-02-18', 'YYYY-MM-DD'));
    agregarMantenimiento(3, 3, 3, 'Revisiï¿½n del aire acondicionado', TO_DATE('2024-02-20', 'YYYY-MM-DD'));
    agregarMantenimiento(4, 2, 4, 'Pintura de las paredes', TO_DATE('2024-02-22', 'YYYY-MM-DD'));
    agregarMantenimiento(5, 1, 5, 'Limpieza profunda y sanitizaciï¿½n', TO_DATE('2024-02-25', 'YYYY-MM-DD'));
END;

-- ================= Restaurante ========================

CREATE OR REPLACE PROCEDURE agregarRestaurante(
    v_id_restaurante IN NUMBER,
    v_fk_hotel IN NUMBER,
    v_nombre IN VARCHAR2,
    v_num_mesas IN INT,
    v_capacidad IN INT
)
AS
BEGIN

    INSERT INTO Restaurante (Id_Restaurante, FK_Hotel, Nombre, Num_Mesas, Capacidad)
    VALUES (v_id_restaurante, v_fk_hotel, v_nombre, v_num_mesas, v_capacidad);
    
COMMIT;  
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;  
END;

BEGIN

    agregarRestaurante(1, 1, 'Bueno Mariscos', 20, 80);
    agregarRestaurante(2, 2, 'Esquina Italiana', 25, 100);
    agregarRestaurante(3, 3, 'Shun Fa', 15, 60);
    agregarRestaurante(4, 4, 'Buena Esquina', 10, 40);
    agregarRestaurante(5, 5, 'Sabores caribeï¿½os', 30, 120);
END;

-- ================= ReservacionRestaurante ========================
CREATE OR REPLACE PROCEDURE agregarReservacionRestaurante(
    v_id_reservacion IN NUMBER,
    v_fk_huesped IN NUMBER,
    v_fk_hotel IN NUMBER,
    v_fk_restaurante IN NUMBER,
    v_fecha_reservacion IN DATE,
    v_cantidad IN INT
)
AS
BEGIN
    INSERT INTO ReservacionRestaurante (Id_ReservacionRestaurante, FK_Huesped, FK_Hotel, FK_Restaurante, Fecha_Reservacion, Cantidad)
    VALUES (v_id_reservacion, v_fk_huesped, v_fk_hotel, v_fk_restaurante, v_fecha_reservacion, v_cantidad);
COMMIT;
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;
END;

BEGIN
/*
-- Estos inserts son los originales
    agregarReservacionRestaurante(1, 1, 1, 'Bueno Mariscos', TO_DATE('2024-03-01', 'YYYY-MM-DD'), 2);
    agregarReservacionRestaurante(2, 2, 2, 'Esquina Italiana', TO_DATE('2024-03-02', 'YYYY-MM-DD'), 4);
    agregarReservacionRestaurante(3, 3, 3, 'Shun Fa', TO_DATE('2024-03-03', 'YYYY-MM-DD'), 3);
    agregarReservacionRestaurante(4, 4, 4, 'Buena Esquina', TO_DATE('2024-03-04', 'YYYY-MM-DD'), 1);
    agregarReservacionRestaurante(5, 5, 5, 'Sabores caribeï¿½os', TO_DATE('2024-03-05', 'YYYY-MM-DD'), 5);*/
-- Insert nuevo con las modificaciones realizadas
    agregarReservacionRestaurante(6, 5, 5, 5, TO_DATE('2025-03-05', 'YYYY-MM-DD'), 5);
END;

-- ================= Servicio ========================

CREATE OR REPLACE PROCEDURE agregarServicio(
    v_id_servicio IN NUMBER,
    v_nombre IN VARCHAR2,
    v_precio IN FLOAT,
    v_tipo IN VARCHAR2
)
AS
BEGIN

    INSERT INTO Servicio (Id_Servicio, Nombre, Precio, Tipo)
    VALUES (v_id_servicio, v_nombre, v_precio, v_tipo);
    
COMMIT;
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;  
END;

BEGIN

agregarServicio(1, 'Spa', 12500, 'Bienestar');
agregarServicio(2, 'Transporte al Aeropuerto', 35000, 'Transporte');
agregarServicio(3, 'Cena Romï¿½ntica', 37000, 'Gastronomï¿½a');
agregarServicio(4, 'Tour de la Ciudad', 30000, 'Turismo');
agregarServicio(5, 'Lavanderï¿½a Express', 7000, 'Limpieza');
agregarServicio(6, 'Pruebas', 7000, 'Limpieza');
END;

-- ================= CheckIn ========================

CREATE OR REPLACE PROCEDURE agregarCheckIn(
    v_id_checkin IN NUMBER,
    v_fecha_checkin IN DATE,
    v_estado IN VARCHAR2
)
AS
BEGIN

    INSERT INTO CheckIn (Id_CheckIn, Fecha_CheckIn, Estado)
    VALUES (v_id_checkin, v_fecha_checkin, v_estado);
    
COMMIT;  
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;  
END;

BEGIN

    agregarCheckIn(1, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 'Confirmado');
    agregarCheckIn(2, TO_DATE('2024-03-11', 'YYYY-MM-DD'), 'Pendiente');
    agregarCheckIn(3, TO_DATE('2024-03-12', 'YYYY-MM-DD'), 'Confirmado');
    agregarCheckIn(4, TO_DATE('2024-03-13', 'YYYY-MM-DD'), 'Cancelado');
    agregarCheckIn(5, TO_DATE('2024-03-14', 'YYYY-MM-DD'), 'Confirmado');
END;

-- ================= Checkout ========================

CREATE OR REPLACE PROCEDURE agregarCheckOut(
    v_id_checkout IN NUMBER,
    v_fecha_checkout IN DATE,
    v_estado IN VARCHAR2,
    v_mensaje IN VARCHAR2
)
AS
BEGIN

    INSERT INTO CheckOut (Id_CheckOut, Fecha_CheckOut, Estado, Mensaje)
    VALUES (v_id_checkout, v_fecha_checkout, v_estado, v_mensaje);
    
COMMIT;
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;  
END;

BEGIN

agregarCheckOut(1, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 'Confirmado', 'Huesped salio');
agregarCheckOut(2, TO_DATE('2024-03-11', 'YYYY-MM-DD'), 'Pendiente', 'Pendiente');
agregarCheckOut(3, TO_DATE('2024-03-12', 'YYYY-MM-DD'), 'Confirmado', 'Salida confirmada');
agregarCheckOut(4, TO_DATE('2024-03-13', 'YYYY-MM-DD'), 'Cancelado', 'Reserva cancelada');
agregarCheckOut(5, TO_DATE('2024-03-14', 'YYYY-MM-DD'), 'Confirmado', 'Salida confirmada');
END;

-- ================= Reservacion ========================

CREATE OR REPLACE PROCEDURE agregarReservacion(
    v_id_reservacion   IN NUMBER,
    v_fk_huesped       IN NUMBER,
    v_fk_hotel         IN NUMBER,
    v_fk_habitacion    IN NUMBER,
    v_fk_promocion     IN NUMBER,
    v_fecha_checkin    IN DATE,
    v_fecha_checkout   IN DATE,
    v_estado           IN VARCHAR2,
    v_comentarios      IN VARCHAR2
)
AS
BEGIN
    INSERT INTO Reservacion (
        Id_Reservacion, FK_Huesped, FK_Hotel, FK_Habitacion, FK_Promocion,
        Fecha_CheckIn, Fecha_CheckOut, Estado, Comentarios
    )
    VALUES (
        v_id_reservacion, v_fk_huesped, v_fk_hotel, v_fk_habitacion, v_fk_promocion,
        v_fecha_checkin, v_fecha_checkout, v_estado, v_comentarios
    );
    
    COMMIT;  
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;

-- Los inserts del 1 - 5 son con el formato antiguo, se deja el ejemplo 6 para ver como se agrega con el nuevo formato yy hacer ejemplos de CRUD
BEGIN
    /*
    agregarReservacion(1, 1, 1, 1, 1, 1, 1, 'Confirmado', 'Reservaciï¿½n para una noche en habitaciï¿½n con jacuzzi');
    agregarReservacion(2, 2, 2, 2, 2, 2, 2, 'Pendiente', 'Habitaciï¿½n doble con vista a la ciudad');
    agregarReservacion(3, 3, 3, 3, 3, 3, 3, 'Confirmado', 'Habitaciï¿½n familiar con cama matrimonial y 2 individuales');
    agregarReservacion(4, 4, 4, 4, 4, 4, 4, 'Cancelado', 'Reserva cancelada antes del check-in');
    agregarReservacion(5, 5, 5, 5, 5, 5, 5, 'Confirmado', 'Habitaciï¿½n con acceso directo a la playa');
    */
    agregarReservacion(6, 1, 1, 1, 1, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 
    TO_DATE('2024-03-05', 'YYYY-MM-DD'), 'Confirmada', 'Comentarios de ejemplo');
END;

-- ================= Reservacion ========================

CREATE OR REPLACE PROCEDURE agregarFactura(
    v_id_factura IN NUMBER,
    v_fk_reservacion IN NUMBER,
    v_fecha_emision IN DATE,
    v_descuento IN INT,
    v_metodo_pago IN VARCHAR2,
    v_monto IN FLOAT,
    v_estado IN VARCHAR2
)
AS
BEGIN
    
    INSERT INTO Factura (Id_Factura, FK_Reservacion, Fecha_Emision, Descuento, Metodo_Pago, Monto, Estado)
    VALUES (v_id_factura, v_fk_reservacion, v_fecha_emision, v_descuento, v_metodo_pago, v_monto, v_estado);
    
COMMIT;
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;  
END;

BEGIN

agregarFactura(1, 1, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 10, 'Tarjeta de crï¿½dito', 50000, 'Pagado');
agregarFactura(2, 2, TO_DATE('2024-03-02', 'YYYY-MM-DD'), 5, 'Efectivo', 60000, 'Pendiente');
agregarFactura(3, 3, TO_DATE('2024-03-03', 'YYYY-MM-DD'), 0, 'Tarjeta de crï¿½dito', 80000, 'Pagado');
agregarFactura(4, 4, TO_DATE('2024-03-04', 'YYYY-MM-DD'), 15, 'Efectivo', 55000, 'Cancelado');
agregarFactura(5, 5, TO_DATE('2024-03-05', 'YYYY-MM-DD'), 20, 'Transferencia bancaria', 72000, 'Pagado');
agregarFactura(6, 5, TO_DATE('2024-03-05', 'YYYY-MM-DD'), 20, 'Prueba CRUDS', 72000, 'Pagado');
END;

-- =============================================================================
--                      Otras funciones del CRUD
-- Comentario: Implementacion de algunos cursores
-- =============================================================================


-- =============================== Hoteles =================================

-- ===================== Ver ============================
CREATE OR REPLACE PROCEDURE ver_hotel_por_id (
    hotelid IN NUMBER
) AS
    v_nombre            VARCHAR2(50);
    v_ciudad            VARCHAR2(50);
    v_canton            VARCHAR2(50);
    v_distrito          VARCHAR2(50);
    v_detalle_direccion VARCHAR2(50);
    v_telefono          VARCHAR2(30);
    v_numero_pisos      NUMBER;
BEGIN

    SELECT 
        Nombre, 
        Ciudad, 
        Canton, 
        Distrito, 
        Detalle_Direccion, 
        Telefono, 
        Numero_pisos
    INTO 
        v_nombre, 
        v_ciudad, 
        v_canton, 
        v_distrito, 
        v_detalle_direccion, 
        v_telefono, 
        v_numero_pisos
    FROM 
        Hotel
    WHERE 
        Id_Hotel = hotelid;

    dbms_output.put_line('Id_Hotel: ' || hotelid);
    dbms_output.put_line('Nombrehotel: ' || v_nombre);
    dbms_output.put_line('Ciudad: ' || v_ciudad);
    dbms_output.put_line('Cantï¿½n: ' || v_canton);
    dbms_output.put_line('Distrito: ' || v_distrito);
    dbms_output.put_line('Detalle Direcciï¿½n: ' || v_detalle_direccion);
    dbms_output.put_line('Telï¿½fono: ' || v_telefono);
    dbms_output.put_line('Nï¿½mero de Pisos: ' || v_numero_pisos);

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Hotel con Id_Hotel ' || hotelid || ' no encontrado.');
    WHEN OTHERS THEN
        dbms_output.put_line('Error: ' || SQLERRM);
END;


SET SERVEROUTPUT ON;

BEGIN
    ver_hotel_por_id(1);
END;


-- =================== Actualizar hoteles ======================

CREATE OR REPLACE PROCEDURE actualizar_hotel (
    p_hotelid            IN NUMBER,
    p_nombre             IN VARCHAR2,
    p_ciudad             IN VARCHAR2,
    p_canton             IN VARCHAR2,
    p_distrito           IN VARCHAR2,
    p_detalle_direccion  IN VARCHAR2,
    p_telefono           IN VARCHAR2,
    p_numero_pisos       IN NUMBER
) AS
BEGIN
    UPDATE Hotel
    SET
        Nombre = p_nombre,
        Ciudad = p_ciudad,
        Canton = p_canton,
        Distrito = p_distrito,
        Detalle_Direccion = p_detalle_direccion,
        Telefono = p_telefono,
        Numero_pisos = p_numero_pisos
    WHERE
        Id_Hotel = p_hotelid;
end;


BEGIN
    actualizar_hotel(
        1,
        'Hotel nuevo',
        'San Josï¿½',
        'Central',
        'Carmen',
        'Av. 10, Calle 5',
        '2251-1618',
        4
    );
END;


-- ========================= Eliminar =========================

CREATE OR REPLACE PROCEDURE eliminar_hotel (
    p_hotelid IN NUMBER
) AS
BEGIN
    DELETE FROM Hotel
    WHERE Id_Hotel = p_hotelid;

END;


BEGIN
    eliminar_hotel(6);
END;



-- =================== Provedor ==============================================

-- =================VER =====================================

CREATE OR REPLACE PROCEDURE ver_proveedor_por_id (
    proveedorid IN NUMBER
) AS
    v_nombre         VARCHAR2(30);
    v_contacto       VARCHAR2(30);
    v_telefono       NUMBER;
    v_email          VARCHAR2(30);
    v_ciudad         VARCHAR2(30);
    v_tipo           VARCHAR2(30);
    v_fecha_registro DATE;
BEGIN

    SELECT 
        Nombre, 
        Contacto, 
        Telefono, 
        Email, 
        Ciudad, 
        Tipo, 
        Fecha_registro
    INTO 
        v_nombre, 
        v_contacto, 
        v_telefono, 
        v_email, 
        v_ciudad, 
        v_tipo, 
        v_fecha_registro
    FROM 
        Proveedor
    WHERE 
        Id_Proveedor = proveedorid;

    dbms_output.put_line('Id_Proveedor: ' || proveedorid);
    dbms_output.put_line('Nombre: ' || v_nombre);
    dbms_output.put_line('Contacto: ' || v_contacto);
    dbms_output.put_line('Telï¿½fono: ' || v_telefono);
    dbms_output.put_line('Email: ' || v_email);
    dbms_output.put_line('Ciudad: ' || v_ciudad);
    dbms_output.put_line('Tipo: ' || v_tipo);
    dbms_output.put_line('Fecha de Registro: ' || TO_CHAR(v_fecha_registro, 'DD-MON-YYYY'));

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Proveedor con Id_Proveedor ' || proveedorid || ' no encontrado.');
    WHEN OTHERS THEN
        dbms_output.put_line('Error: ' || SQLERRM);
END;


BEGIN
    ver_proveedor_por_id(1);
END;


-- ====================== Actualizar proveedor =============================

CREATE OR REPLACE PROCEDURE actualizar_proveedor (
    p_proveedorid    IN NUMBER,
    p_nombre         IN VARCHAR2,
    p_contacto       IN VARCHAR2,
    p_telefono       IN NUMBER,
    p_email          IN VARCHAR2,
    p_ciudad         IN VARCHAR2,
    p_tipo           IN VARCHAR2,
    p_fecha_registro IN DATE
) AS
BEGIN
    UPDATE Proveedor
    SET
        Nombre = p_nombre,
        Contacto = p_contacto,
        Telefono = p_telefono,
        Email = p_email,
        Ciudad = p_ciudad,
        Tipo = p_tipo,
        Fecha_registro = p_fecha_registro
    WHERE
        Id_Proveedor = p_proveedorid;

END;


BEGIN
    actualizar_proveedor(
        1,
        'Nuevos suministos',
        'Juan Pï¿½rez',
        88885555,
        'Nuevos@suministos.com',
        'San Josï¿½',
        'Limpieza',
        TO_DATE('2023-01-15', 'YYYY-MM-DD')
    );
END;


-- ================== Eliminar ===================

CREATE OR REPLACE PROCEDURE eliminar_proveedor (
    p_proveedorid IN NUMBER
) AS
BEGIN
    DELETE FROM Proveedor
    WHERE Id_Proveedor = p_proveedorid;

END;





-- ====================== Suministros ==============================

-- ======================= Ver ============================

CREATE OR REPLACE PROCEDURE ver_suministro_por_id (
    suministroid IN NUMBER
) AS
    v_fk_proveedor NUMBER;
    v_fk_hotel     NUMBER;
    v_nombre       VARCHAR2(30);
    v_descripcion  VARCHAR2(50);
    v_cantidad     NUMBER;
    v_costo        FLOAT;
BEGIN

    SELECT 
        FK_Proveedor, 
        FK_Hotel, 
        Nombre, 
        Descripcion, 
        Cantidad, 
        Costo
    INTO 
        v_fk_proveedor, 
        v_fk_hotel, 
        v_nombre, 
        v_descripcion, 
        v_cantidad, 
        v_costo
    FROM 
        Suministro
    WHERE 
        Id_Suministro = suministroid;

    dbms_output.put_line('Id_Suministro: ' || suministroid);
    dbms_output.put_line('Id_Proveedor: ' || v_fk_proveedor);
    dbms_output.put_line('Id_Hotel: ' || v_fk_hotel);
    dbms_output.put_line('Nombre: ' || v_nombre);
    dbms_output.put_line('Descripciï¿½n: ' || v_descripcion);
    dbms_output.put_line('Cantidad: ' || v_cantidad);
    dbms_output.put_line('Costo: ' || v_costo);

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Suministro con Id_Suministro ' || suministroid || ' no encontrado.');
    WHEN OTHERS THEN
        dbms_output.put_line('Error: ' || SQLERRM);
END;


BEGIN
    ver_suministro_por_id(1);
END;


-- ========================== Actualizar suministros =================

CREATE OR REPLACE PROCEDURE actualizar_suministro (
    p_suministroid   IN NUMBER,
    p_fk_proveedor   IN NUMBER,
    p_fk_hotel       IN NUMBER,
    p_nombre         IN VARCHAR2,
    p_descripcion    IN VARCHAR2,
    p_cantidad       IN NUMBER,
    p_costo          IN FLOAT
) AS
BEGIN
    UPDATE Suministro
    SET
        FK_Proveedor = p_fk_proveedor,
        FK_Hotel = p_fk_hotel,
        Nombre = p_nombre,
        Descripcion = p_descripcion,
        Cantidad = p_cantidad,
        Costo = p_costo
    WHERE
        Id_Suministro = p_suministroid;

END;


BEGIN
    actualizar_suministro(
        1,
        1,
        1,
        'Nuevo suministro',
        'Jabï¿½n antibacterial 500ml',
        100,
        20000
    );
END;


-- ================== Eliminar =================

CREATE OR REPLACE PROCEDURE eliminar_suministro (
    p_suministroid IN NUMBER
) AS
BEGIN
    DELETE FROM Suministro
    WHERE Id_Suministro = p_suministroid;

END;



-- ===================   Promocion ==================================

-- ================== Ver =============================================

CREATE OR REPLACE PROCEDURE ver_promocion_por_id (
    promocionid IN NUMBER
) AS
    v_fk_hotel    NUMBER;
    v_descripcion VARCHAR2(30);
    v_fecha_inicio DATE;
    v_fecha_fin   DATE;
BEGIN

    SELECT 
        FK_Hotel, 
        Descripcion, 
        Fecha_Inicio, 
        Fecha_Fin
    INTO 
        v_fk_hotel, 
        v_descripcion, 
        v_fecha_inicio, 
        v_fecha_fin
    FROM 
        Promocion
    WHERE 
        Id_Promocion = promocionid;

    dbms_output.put_line('Id_Promocion: ' || promocionid);
    dbms_output.put_line('Id_Hotel: ' || v_fk_hotel);
    dbms_output.put_line('Descripciï¿½n: ' || v_descripcion);
    dbms_output.put_line('Fecha de Inicio: ' || TO_CHAR(v_fecha_inicio, 'DD-MON-YYYY'));
    dbms_output.put_line('Fecha de Fin: ' || TO_CHAR(v_fecha_fin, 'DD-MON-YYYY'));

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Promociï¿½n con Id_Promocion ' || promocionid || ' no encontrada.');
    WHEN OTHERS THEN
        dbms_output.put_line('Error: ' || SQLERRM);
END;


BEGIN
    ver_promocion_por_id(1);
END;


-- ========================== Actualizar promocion =================

CREATE OR REPLACE PROCEDURE actualizar_promocion (
    p_promocionid  IN NUMBER,
    p_fk_hotel     IN NUMBER,
    p_descripcion  IN VARCHAR2,
    p_fecha_inicio IN DATE,
    p_fecha_fin    IN DATE
) AS
BEGIN
    UPDATE Promocion
    SET
        FK_Hotel = p_fk_hotel,
        Descripcion = p_descripcion,
        Fecha_Inicio = p_fecha_inicio,
        Fecha_Fin = p_fecha_fin
    WHERE
        Id_Promocion = p_promocionid;

END;


BEGIN
    actualizar_promocion(
        1,
        1,
        'Nuevo descuento',
        TO_DATE('2025-06-01', 'YYYY-MM-DD'),
        TO_DATE('2025-06-30', 'YYYY-MM-DD')
    );
END;


-- ================== Eliminar =======================

CREATE OR REPLACE PROCEDURE eliminar_promocion (
    p_promocionid IN NUMBER
) AS
BEGIN
    DELETE FROM Promocion
    WHERE Id_Promocion = p_promocionid;

END;



-- ================ Tipo_Promocion ===========================

-- ================== Ver =======================

CREATE OR REPLACE PROCEDURE ver_tipo_promocion_por_id (
    tipo_promocionid IN NUMBER
) AS
    v_nombre  VARCHAR2(30);
    v_detalle VARCHAR2(300);
BEGIN

    SELECT 
        Nombre, 
        Detalle
    INTO 
        v_nombre, 
        v_detalle
    FROM 
        Tipo_Promocion
    WHERE 
        Id_Tipo_Promocion = tipo_promocionid;

    dbms_output.put_line('Id_Tipo_Promocion: ' || tipo_promocionid);
    dbms_output.put_line('Nombre: ' || v_nombre);
    dbms_output.put_line('Detalle: ' || v_detalle);

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Tipo de promociï¿½n con Id_Tipo_Promocion ' || tipo_promocionid || ' no encontrado.');
    WHEN OTHERS THEN
        dbms_output.put_line('Error: ' || SQLERRM);
END;


BEGIN
    ver_tipo_promocion_por_id(1);
END;


-- ================ Actualizar tipo promocion ======================

CREATE OR REPLACE PROCEDURE actualizar_tipo_promocion (
    p_tipo_promocionid IN NUMBER,
    p_nombre           IN VARCHAR2,
    p_detalle          IN VARCHAR2
) AS
BEGIN
    UPDATE Tipo_Promocion
    SET
        Nombre = p_nombre,
        Detalle = p_detalle
    WHERE
        Id_Tipo_Promocion = p_tipo_promocionid;
END;


BEGIN
    actualizar_tipo_promocion(
        1,
        'Nuevo',
        'Se aplica un descuento sobre el precio total de la reserva'
    );
END;


-- ============== Eliminar tipo promocion ===================

CREATE OR REPLACE PROCEDURE eliminar_tipo_promocion (
    p_tipo_promocionid IN NUMBER
) AS
BEGIN
    DELETE FROM Tipo_Promocion
    WHERE Id_Tipo_Promocion = p_tipo_promocionid;

END;



-- ================ Vehiculo ====================

-- ================== Ver vehiculo ==============

CREATE OR REPLACE PROCEDURE ver_vehiculo_por_id (
    vehiculoid IN NUMBER
) AS

    v_tipo     VARCHAR2(30);
    v_marca    VARCHAR2(30);
    v_modelo   VARCHAR2(50);
    v_anio     NUMBER;
    v_placa    VARCHAR2(8);
    v_fk_hotel NUMBER;
BEGIN
    SELECT
        tipo,
        marca,
        modelo,
        aï¿½o,
        placa,
        fk_hotel
    INTO
        v_tipo,
        v_marca,
        v_modelo,
        v_anio,
        v_placa,
        v_fk_hotel
    FROM
        vehiculo
    WHERE
        id_vehiculo = vehiculoid;

    dbms_output.put_line('Id_Vehiculo: ' || vehiculoid);
    dbms_output.put_line('Id_Hotel: ' || v_fk_hotel);
    dbms_output.put_line('Tipo: ' || v_tipo);
    dbms_output.put_line('Marca: ' || v_marca);
    dbms_output.put_line('Modelo: ' || v_modelo);
    dbms_output.put_line('Aï¿½o: ' || v_anio);
    dbms_output.put_line('Placa: ' || v_placa);
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Vehï¿½culo con Id_Vehiculo '
                             || vehiculoid
                             || ' no encontrado.');
END;
    
     /* SET SERVEROUTPUT ON;
    BEGIN
        VER_VEHICULOPORID(1);
    END;*/

-- =================== Actualizar vehiculo =====================

CREATE OR REPLACE PROCEDURE actualizar_vehiculo (
    p_vehiculoid IN NUMBER,
    p_hotelid    IN NUMBER,
    p_tipo       IN VARCHAR2,
    p_marca      IN VARCHAR2,
    p_modelo     IN VARCHAR2,
    p_anio       IN NUMBER,
    p_placa      IN VARCHAR2
) AS
BEGIN
    UPDATE vehiculo
    SET
        fk_hotel = p_hotelid,
        tipo = p_tipo,
        marca = p_marca,
        modelo = p_modelo,
        aï¿½o = p_anio,
        placa = p_placa
    WHERE
        id_vehiculo = p_vehiculoid;

END;

-- ============ Eliminar vehiculo =======================

CREATE OR REPLACE PROCEDURE eliminar_vehiculo (
    p_vehiculoid IN NUMBER
) AS
BEGIN
    DELETE FROM vehiculo
    WHERE
        id_vehiculo = p_vehiculoid;

END;
    
    
-- ================= Inventario =====================

-- ================== Ver inventatio ================
CREATE OR REPLACE PROCEDURE ver_inventario_por_id (
    inventarioid IN NUMBER
) AS

    v_fk_hotel       NUMBER;
    v_nombre         VARCHAR2(30);
    v_tipo           VARCHAR2(30);
    v_marca          VARCHAR2(50);
    v_modelo         VARCHAR2(50);
    v_serie          VARCHAR2(20);
    v_fecha_registro DATE;
    v_cantidad       NUMBER;
BEGIN
    SELECT
        fk_hotel,
        nombre,
        tipo,
        marca,
        modelo,
        serie,
        fecha_registro,
        cantidad
    INTO
        v_fk_hotel,
        v_nombre,
        v_tipo,
        v_marca,
        v_modelo,
        v_serie,
        v_fecha_registro,
        v_cantidad
    FROM
        inventario
    WHERE
        id_inventario = inventarioid;

    dbms_output.put_line('Id_Inventario: ' || inventarioid);
    dbms_output.put_line('IDHotel: ' || v_fk_hotel);
    dbms_output.put_line('Nombre: ' || v_nombre);
    dbms_output.put_line('Tipo: ' || v_tipo);
    dbms_output.put_line('Marca: ' || v_marca);
    dbms_output.put_line('Modelo: ' || v_modelo);
    dbms_output.put_line('Serie: ' || v_serie);
    dbms_output.put_line('Fecha_Registro: ' || to_char(v_fecha_registro, 'YYYY-MM-DD'));
    dbms_output.put_line('Cantidad: ' || v_cantidad);
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Inventario con Id_Inventario '
                             || inventarioid
                             || ' no encontrado.');
END;
    
  /*SET SERVEROUTPUT ON;
    BEGIN
        VER_INVENTARIO_POR_ID(1);
    END;*/


-- ============ Actualuzar invetario ==============

CREATE OR REPLACE PROCEDURE actualizar_inventario (
    p_inventarioid  IN NUMBER,
    p_hotelid       IN NUMBER,
    p_nombre        IN VARCHAR2,
    p_tipo          IN VARCHAR2,
    p_marca         IN VARCHAR2,
    p_modelo        IN VARCHAR2,
    p_serie         IN VARCHAR2,
    p_fecharegistro IN DATE,
    p_cantidad      IN NUMBER
) AS
BEGIN
    UPDATE inventario
    SET
        fk_hotel = p_hotelid,
        nombre = p_nombre,
        tipo = p_tipo,
        marca = p_marca,
        modelo = p_modelo,
        serie = p_serie,
        fecha_registro = p_fecharegistro,
        cantidad = p_cantidad
    WHERE
        id_inventario = p_inventarioid;

END;
    
   /* BEGIN
        ACTUALIZAR_INVENTARIO(
            1,
            2,
            'Nuevo Nombre',
            'Nuevo Tipo',
            'Nueva Marca',
            'Nuevo Modelo',
            'Nueva Serie',
            TO_DATE('2023-11-01', 'YYYY-MM-DD'),
            20
        );
    END;
    
     SET SERVEROUTPUT ON;
    BEGIN
        VER_INVENTARIO_POR_ID(1);
    END;*/

-- ===================== Eliminar inventario ====================

CREATE OR REPLACE PROCEDURE eliminar_inventario (
    p_inventarioid IN NUMBER
) AS
BEGIN
    DELETE FROM inventario
    WHERE
        id_inventario = p_inventarioid;

END;
    
-- ================== Puestos ============== 

-- ================= Ver puestos =====================

CREATE OR REPLACE PROCEDURE ver_puesto_por_id (
    puestoid IN NUMBER
) AS
    v_nombre  VARCHAR2(30);
    v_salario NUMBER;
BEGIN
    SELECT
        nombre,
        salario
    INTO
        v_nombre,
        v_salario
    FROM
        puesto
    WHERE
        id_puesto = puestoid;

    dbms_output.put_line('Id_Puesto: ' || puestoid);
    dbms_output.put_line('Nombre: ' || v_nombre);
    dbms_output.put_line('Salario: ' || v_salario);
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Puesto con Id_Puesto '
                             || puestoid
                             || ' no encontrado.');
END;

-- ==================== Actualizar puestos ===================

CREATE OR REPLACE PROCEDURE actualizar_puesto (
    p_puestoid IN NUMBER,
    p_nombre   IN VARCHAR2,
    p_salario  IN NUMBER
) AS
BEGIN
    UPDATE puesto
    SET
        nombre = p_nombre,
        salario = p_salario
    WHERE
        id_puesto = p_puestoid;

END;


-- ================= Eliminar puesto ================

CREATE OR REPLACE PROCEDURE eliminar_puesto (
    p_puestoid IN NUMBER
) AS
BEGIN
    DELETE FROM puesto
    WHERE
        id_puesto = p_puestoid;

END;
    
-- ================== Empleados ==============

-- ================ Ver empleados ============

CREATE OR REPLACE PROCEDURE ver_empleado_por_id (
    empleadoid IN NUMBER
) AS

    v_fk_hotel      NUMBER;
    v_fk_puesto     NUMBER;
    v_nombre        VARCHAR2(30);
    v_cedula        NUMBER;
    v_correo        VARCHAR2(50);
    v_telefono      NUMBER;
    v_fecha_ingreso DATE;
BEGIN
    SELECT
        fk_hotel,
        fk_puesto,
        nombre,
        cedula,
        correo,
        telefono,
        fecha_ingreso
    INTO
        v_fk_hotel,
        v_fk_puesto,
        v_nombre,
        v_cedula,
        v_correo,
        v_telefono,
        v_fecha_ingreso
    FROM
        empleado
    WHERE
        id_empleado = empleadoid;

    dbms_output.put_line('Id_Empleado: ' || empleadoid);
    dbms_output.put_line('Id_Hotel: ' || v_fk_hotel);
    dbms_output.put_line('Id_Puesto: ' || v_fk_puesto);
    dbms_output.put_line('Nombre: ' || v_nombre);
    dbms_output.put_line('Cedula: ' || v_cedula);
    dbms_output.put_line('Correo: ' || v_correo);
    dbms_output.put_line('Telefono: ' || v_telefono);
    dbms_output.put_line('Fecha_Ingreso: ' || to_char(v_fecha_ingreso, 'YYYY-MM-DD'));
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Empleado con Id_Empleado '
                             || empleadoid
                             || ' no encontrado.');
END;


-- =============== Actualizar empleado =====================

CREATE OR REPLACE PROCEDURE actualizar_empleado (
    p_empleadoid   IN NUMBER,
    p_hotelid      IN NUMBER,
    p_puestoid     IN NUMBER,
    p_nombre       IN VARCHAR2,
    p_cedula       IN NUMBER,
    p_correo       IN VARCHAR2,
    p_telefono     IN NUMBER,
    p_fechaingreso IN DATE
) AS
BEGIN
    UPDATE empleado
    SET
        fk_hotel = p_hotelid,
        fk_puesto = p_puestoid,
        nombre = p_nombre,
        cedula = p_cedula,
        correo = p_correo,
        telefono = p_telefono,
        fecha_ingreso = p_fechaingreso
    WHERE
        id_empleado = p_empleadoid;

END;

-- ===================== Eliminar empleado ===================

CREATE OR REPLACE PROCEDURE eliminar_empleado (
    p_empleadoid IN NUMBER
) AS
BEGIN
    DELETE FROM empleado
    WHERE
        id_empleado = p_empleadoid;

END;
    
-- ======================= Eventos =====================

-- ==================== Ver eventos ========================

CREATE OR REPLACE PROCEDURE ver_evento_por_id (
    eventoid IN NUMBER
) AS

    v_fk_hotel     NUMBER;
    v_nombre       VARCHAR2(30);
    v_capacidad    VARCHAR2(30);
    v_fecha_inicio DATE;
    v_fecha_fin    DATE;
BEGIN
    SELECT
        fk_hotel,
        nombre,
        capacidad,
        fecha_inicio,
        fecha_fin
    INTO
        v_fk_hotel,
        v_nombre,
        v_capacidad,
        v_fecha_inicio,
        v_fecha_fin
    FROM
        evento
    WHERE
        id_evento = eventoid;

    dbms_output.put_line('Id_Evento: ' || eventoid);
    dbms_output.put_line('Id_Hotel: ' || v_fk_hotel);
    dbms_output.put_line('Nombre: ' || v_nombre);
    dbms_output.put_line('Capacidad: ' || v_capacidad);
    dbms_output.put_line('Fecha_Inicio: ' || to_char(v_fecha_inicio, 'YYYY-MM-DD '));
    dbms_output.put_line('Fecha_Fin: ' || to_char(v_fecha_fin, 'YYYY-MM-DD '));
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Evento con Id_Evento '
                             || eventoid
                             || ' no encontrado.');
END;

/*
SET SERVEROUTPUT ON;

BEGIN
    ver_evento_por_id(1);
END;*/

-- ===================== Actualizar evento =========================

CREATE OR REPLACE PROCEDURE actualizar_evento (
    p_eventoid    IN NUMBER,
    p_hotelid     IN NUMBER,
    p_nombre      IN VARCHAR2,
    p_capacidad   IN VARCHAR2,
    p_fechainicio IN DATE,
    p_fechafin    IN DATE
) AS
BEGIN
    UPDATE evento
    SET
        fk_hotel = p_hotelid,
        nombre = p_nombre,
        capacidad = p_capacidad,
        fecha_inicio = p_fechainicio,
        fecha_fin = p_fechafin
    WHERE
        id_evento = p_eventoid;

END;

-- ==================== Eliminar evento =================

CREATE OR REPLACE PROCEDURE eliminar_evento (
    p_eventoid IN NUMBER
) AS
BEGIN
    DELETE FROM evento
    WHERE
        id_evento = p_eventoid;

END;

--HUESPED

CREATE OR REPLACE PROCEDURE HUESPED_OBETENER_SP (
    p_id_huesped IN huesped.id_huesped%TYPE DEFAULT NULL
) IS

    CURSOR c_huesped (
        p_id huesped.id_huesped%TYPE
    ) IS
    SELECT
        id_huesped,
        nombre,
        cedula,
        apellido1,
        apellido2,
        correo,
        telefono,
        fecha_nacimiento,
        fecha_registro
    FROM
        huesped
    WHERE
        id_huesped = p_id
        OR p_id IS NULL;

    v_id_huesped       huesped.id_huesped%TYPE;
    v_nombre           huesped.nombre%TYPE;
    v_cedula           huesped.cedula%TYPE;
    v_apellido1        huesped.apellido1%TYPE;
    v_apellido2        huesped.apellido2%TYPE;
    v_correo           huesped.correo%TYPE;
    v_telefono         huesped.telefono%TYPE;
    v_fecha_nacimiento huesped.fecha_nacimiento%TYPE;
    v_fecha_registro   huesped.fecha_registro%TYPE;
BEGIN
OPEN c_huesped(p_id_huesped);
LOOP
FETCH C_HUESPED INTO V_ID_HUESPED , V_NOMBRE , V_CEDULA , V_APELLIDO1 , V_APELLIDO2 , V_CORREO , V_TELEFONO , V_FECHA_NACIMIENTO, V_FECHA_REGISTRO ;
EXIT WHEN c_Huesped%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(
'ID: ' || v_Id_Huesped || ', ' ||
'Nombre: ' || v_Nombre || ' ' || v_Apellido1 || ' ' || v_Apellido2 || ', ' ||
'Cï¿½dula: ' || v_Cedula || ', ' ||
'Correo: ' || v_Correo || ', ' ||
'Telï¿½fono: ' || v_Telefono || ', ' ||
'Fecha Nacimiento: ' || TO_CHAR(v_Fecha_Nacimiento, 'YYYY-MM-DD') || ', ' ||
'Fecha Registro: ' || TO_CHAR(v_Fecha_Registro, 'YYYY-MM-DD')
);
END LOOP;
CLOSE c_Huesped;
END;


--modificar

CREATE OR REPLACE PROCEDURE HUESPED_MODIFICAR_SP(
    p_Id_Huesped IN Huesped.Id_Huesped%TYPE, 
    p_Nombre IN Huesped.Nombre%TYPE DEFAULT NULL, 
    p_Cedula IN Huesped.Cedula%TYPE DEFAULT NULL, 
    p_Apellido1 IN Huesped.Apellido1%TYPE DEFAULT NULL, 
    p_Apellido2 IN Huesped.Apellido2%TYPE DEFAULT NULL, 
    p_Correo IN Huesped.Correo%TYPE DEFAULT NULL, 
    p_Telefono IN Huesped.Telefono%TYPE DEFAULT NULL,
    p_Fecha_Nacimiento IN Huesped.Fecha_Nacimiento%TYPE DEFAULT NULL,
    p_Fecha_Registro IN Huesped.Fecha_Registro%TYPE DEFAULT NULL 
) IS
BEGIN

    UPDATE Huesped
    SET
        Nombre = NVL(p_Nombre, Nombre), 
        Cedula = NVL(p_Cedula, Cedula),
        Apellido1 = NVL(p_Apellido1, Apellido1),
        Apellido2 = NVL(p_Apellido2, Apellido2),
        Correo = NVL(p_Correo, Correo),
        Telefono = NVL(p_Telefono, Telefono),
        Fecha_Nacimiento = NVL(p_Fecha_Nacimiento, Fecha_Nacimiento),
        Fecha_Registro = NVL(p_Fecha_Registro, Fecha_Registro)
    WHERE Id_Huesped = p_Id_Huesped;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontrï¿½ ningï¿½n huï¿½sped con el ID ' || p_Id_Huesped);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Huï¿½sped con ID ' || p_Id_Huesped || ' modificado correctamente.');
    END IF;
END;

--borrar

CREATE OR REPLACE PROCEDURE HUESPED_BORRAR_SP(
    p_Id_Huesped IN Huesped.Id_Huesped%TYPE
) IS
BEGIN

    DELETE FROM Huesped
    WHERE Id_Huesped = p_Id_Huesped;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontrï¿½ ningï¿½n huï¿½sped con el ID ' || p_Id_Huesped);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Huï¿½sped con ID ' || p_Id_Huesped || ' borrado correctamente.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al borrar el huï¿½sped: ' || SQLERRM);
END;

--TIPOHABITACION

CREATE OR REPLACE PROCEDURE TIPOHABITACION_OBTENER_SP(
    p_Id_TipoHabitacion IN TipoHabitacion.Id_TipoHabitacion%TYPE DEFAULT NULL
) IS
    CURSOR c_TipoHabitacion(p_Id TipoHabitacion.Id_TipoHabitacion%TYPE) IS
        SELECT Id_TipoHabitacion, Nombre, Capacidad, Numero_Camas, Vista, Precio_PorNoche, Estado
        FROM TipoHabitacion
        WHERE Id_TipoHabitacion = p_Id OR p_Id IS NULL; 

    v_Id_TipoHabitacion TipoHabitacion.Id_TipoHabitacion%TYPE;
    v_Nombre TipoHabitacion.Nombre%TYPE;
    v_Capacidad TipoHabitacion.Capacidad%TYPE;
    v_Numero_Camas TipoHabitacion.Numero_Camas%TYPE;
    v_Vista TipoHabitacion.Vista%TYPE;
    v_Precio_PorNoche TipoHabitacion.Precio_PorNoche%TYPE;
    v_Estado TipoHabitacion.Estado%TYPE;

BEGIN
OPEN c_TipoHabitacion(p_Id_TipoHabitacion);
LOOP
FETCH c_TipoHabitacion INTO v_Id_TipoHabitacion, v_Nombre, v_Capacidad, v_Numero_Camas, v_Vista, v_Precio_PorNoche, v_Estado;
EXIT WHEN c_TipoHabitacion%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(
            'ID: ' || v_Id_TipoHabitacion || ', ' ||
            'Nombre: ' || v_Nombre || ', ' ||
            'Capacidad: ' || v_Capacidad || ', ' ||
            'Nï¿½mero de Camas: ' || v_Numero_Camas || ', ' ||
            'Vista: ' || v_Vista || ', ' ||
            'Precio por Noche: ' || TO_CHAR(v_Precio_PorNoche, '999999.99') || ', ' ||
            'Estado: ' || v_Estado
        );
END LOOP;
CLOSE c_TipoHabitacion;
END;

BEGIN
TIPOHABITACION_OBTENER_SP(1);
END;

--modificar

CREATE OR REPLACE PROCEDURE TIPOHABITACION_MODIFICAR_SP(
    p_Id_TipoHabitacion IN TipoHabitacion.Id_TipoHabitacion%TYPE,
    p_Nombre IN TipoHabitacion.Nombre%TYPE DEFAULT NULL,
    p_Capacidad IN TipoHabitacion.Capacidad%TYPE DEFAULT NULL,
    p_Numero_Camas IN TipoHabitacion.Numero_Camas%TYPE DEFAULT NULL,
    p_Vista IN TipoHabitacion.Vista%TYPE DEFAULT NULL,
    p_Precio_PorNoche IN TipoHabitacion.Precio_PorNoche%TYPE DEFAULT NULL,
    p_Estado IN TipoHabitacion.Estado%TYPE DEFAULT NULL
) IS
BEGIN

    UPDATE TipoHabitacion
    SET
        Nombre = NVL(p_Nombre, Nombre),
        Capacidad = NVL(p_Capacidad, Capacidad),
        Numero_Camas = NVL(p_Numero_Camas, Numero_Camas),
        Vista = NVL(p_Vista, Vista),
        Precio_PorNoche = NVL(p_Precio_PorNoche, Precio_PorNoche),
        Estado = NVL(p_Estado, Estado)
    WHERE Id_TipoHabitacion = p_Id_TipoHabitacion;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontrï¿½ ningï¿½n tipo de habitaciï¿½n con el ID ' || p_Id_TipoHabitacion);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Tipo de habitaciï¿½n con ID ' || p_Id_TipoHabitacion || ' modificado correctamente.');
    END IF;
END;

--borrar

CREATE OR REPLACE PROCEDURE TIPOHABITACION_BORRAR_SP(
    p_Id_TipoHabitacion IN TipoHabitacion.Id_TipoHabitacion%TYPE
) IS
BEGIN

    DELETE FROM TipoHabitacion
    WHERE Id_TipoHabitacion = p_Id_TipoHabitacion;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontrï¿½ ningï¿½n tipo de habitaciï¿½n con el ID ' || p_Id_TipoHabitacion);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Tipo de habitaciï¿½n con ID ' || p_Id_TipoHabitacion || ' borrado correctamente.');
    END IF;
END;

--HABITACION

CREATE OR REPLACE PROCEDURE HABITACION_OBTENER_SP(
    p_Id_Habitacion IN Habitacion.Id_Habitacion%TYPE DEFAULT NULL
) IS
    CURSOR c_Habitacion(p_Id Habitacion.Id_Habitacion%TYPE) IS
        SELECT Id_Habitacion, FK_TipoHabitacion, Numero_Habitacion, Descripcion, Estado
        FROM Habitacion
        WHERE Id_Habitacion = p_Id OR p_Id IS NULL;

    v_Id_Habitacion Habitacion.Id_Habitacion%TYPE;
    v_FK_TipoHabitacion Habitacion.FK_TipoHabitacion%TYPE;
    v_Numero_Habitacion Habitacion.Numero_Habitacion%TYPE;
    v_Descripcion Habitacion.Descripcion%TYPE;
    v_Estado Habitacion.Estado%TYPE;

BEGIN
OPEN c_Habitacion(p_Id_Habitacion);
LOOP
FETCH c_Habitacion INTO v_Id_Habitacion, v_FK_TipoHabitacion, v_Numero_Habitacion, v_Descripcion, v_Estado;
EXIT WHEN c_Habitacion%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(
            'ID: ' || v_Id_Habitacion || ', ' ||
            'FK_TipoHabitacion: ' || v_FK_TipoHabitacion || ', ' ||
            'Nï¿½mero de Habitaciï¿½n: ' || v_Numero_Habitacion || ', ' ||
            'Descripciï¿½n: ' || v_Descripcion || ', ' ||
            'Estado: ' || v_Estado
        );
    END LOOP;

    CLOSE c_Habitacion;
END;

--modificar

CREATE OR REPLACE PROCEDURE HABITACION_MODIFICAR_SP(
    p_Id_Habitacion IN Habitacion.Id_Habitacion%TYPE,
    p_FK_TipoHabitacion IN Habitacion.FK_TipoHabitacion%TYPE DEFAULT NULL,
    p_Numero_Habitacion IN Habitacion.Numero_Habitacion%TYPE DEFAULT NULL,
    p_Descripcion IN Habitacion.Descripcion%TYPE DEFAULT NULL,
    p_Estado IN Habitacion.Estado%TYPE DEFAULT NULL
) IS
BEGIN

    UPDATE Habitacion
    SET
        FK_TipoHabitacion = NVL(p_FK_TipoHabitacion, FK_TipoHabitacion),
        Numero_Habitacion = NVL(p_Numero_Habitacion, Numero_Habitacion),
        Descripcion = NVL(p_Descripcion, Descripcion),
        Estado = NVL(p_Estado, Estado)
    WHERE Id_Habitacion = p_Id_Habitacion;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontrï¿½ ninguna habitaciï¿½n con el ID ' || p_Id_Habitacion);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Habitaciï¿½n con ID ' || p_Id_Habitacion || ' modificada correctamente.');
    END IF;
END;


--borrar

CREATE OR REPLACE PROCEDURE HABITACION_BORRAR_SP(
    p_Id_Habitacion IN Habitacion.Id_Habitacion%TYPE
) IS
BEGIN
    DELETE FROM Habitacion
    WHERE Id_Habitacion = p_Id_Habitacion;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontrï¿½ ninguna habitaciï¿½n con el ID ' || p_Id_Habitacion);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Habitaciï¿½n con ID ' || p_Id_Habitacion || ' borrada correctamente.');
    END IF;
END;


--MANTENIMIENTO

CREATE OR REPLACE PROCEDURE MANTENIMIENTO_OBTENER_SP(
    p_Id_Mantenimiento IN Mantenimiento.Id_Mantenimiento%TYPE DEFAULT NULL
) IS

    CURSOR c_Mantenimiento(p_Id Mantenimiento.Id_Mantenimiento%TYPE) IS
        SELECT Id_Mantenimiento, FK_Habitacion, FK_Proveedor, Descripcion, Fecha_Inicio
        FROM Mantenimiento
        WHERE Id_Mantenimiento = p_Id OR p_Id IS NULL;
        
    v_Id_Mantenimiento Mantenimiento.Id_Mantenimiento%TYPE;
    v_FK_Habitacion Mantenimiento.FK_Habitacion%TYPE;
    v_FK_Proveedor Mantenimiento.FK_Proveedor%TYPE;
    v_Descripcion Mantenimiento.Descripcion%TYPE;
    v_Fecha_Inicio Mantenimiento.Fecha_Inicio%TYPE;

BEGIN
OPEN c_Mantenimiento(p_Id_Mantenimiento);
LOOP
FETCH c_Mantenimiento INTO v_Id_Mantenimiento, v_FK_Habitacion, v_FK_Proveedor, v_Descripcion, v_Fecha_Inicio;
 EXIT WHEN c_Mantenimiento%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(
            'ID: ' || v_Id_Mantenimiento || ', ' ||
            'FK_Habitacion: ' || v_FK_Habitacion || ', ' ||
            'FK_Proveedor: ' || v_FK_Proveedor || ', ' ||
            'Descripciï¿½n: ' || v_Descripcion || ', ' ||
            'Fecha de Inicio: ' || TO_CHAR(v_Fecha_Inicio, 'YYYY-MM-DD')
        );
END LOOP;
CLOSE c_Mantenimiento;
END;

--modificar

CREATE OR REPLACE PROCEDURE MANTENIMIENTO_MODIFICAR_SP(
    p_Id_Mantenimiento IN Mantenimiento.Id_Mantenimiento%TYPE, -- ID del mantenimiento a modificar
    p_FK_Habitacion IN Mantenimiento.FK_Habitacion%TYPE DEFAULT NULL,
    p_FK_Proveedor IN Mantenimiento.FK_Proveedor%TYPE DEFAULT NULL,
    p_Descripcion IN Mantenimiento.Descripcion%TYPE DEFAULT NULL,
    p_Fecha_Inicio IN Mantenimiento.Fecha_Inicio%TYPE DEFAULT NULL
) IS
BEGIN

    UPDATE Mantenimiento
    SET
        FK_Habitacion = NVL(p_FK_Habitacion, FK_Habitacion),
        FK_Proveedor = NVL(p_FK_Proveedor, FK_Proveedor),
        Descripcion = NVL(p_Descripcion, Descripcion),
        Fecha_Inicio = NVL(p_Fecha_Inicio, Fecha_Inicio)
    WHERE Id_Mantenimiento = p_Id_Mantenimiento;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontrï¿½ ningï¿½n mantenimiento con el ID ' || p_Id_Mantenimiento);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Mantenimiento con ID ' || p_Id_Mantenimiento || ' modificado correctamente.');
    END IF;
END;


CREATE OR REPLACE PROCEDURE MANTENIMIENTO_BORRAR_SP(
    p_Id_Mantenimiento IN Mantenimiento.Id_Mantenimiento%TYPE
) IS
BEGIN
DELETE FROM Mantenimiento
WHERE Id_Mantenimiento = p_Id_Mantenimiento;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontrï¿½ ningï¿½n mantenimiento con el ID ' || p_Id_Mantenimiento);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Mantenimiento con ID ' || p_Id_Mantenimiento || ' borrado correctamente.');
    END IF;
END;

--RESTAURANTE

CREATE OR REPLACE PROCEDURE RESTAURANTE_OBETENER_SP(
    p_Id_Restaurante IN Restaurante.Id_Restaurante%TYPE DEFAULT NULL
) IS
CURSOR c_Restaurante(p_Id Restaurante.Id_Restaurante%TYPE) IS
        SELECT Id_Restaurante, FK_Hotel, Nombre, Num_Mesas, Capacidad
        FROM Restaurante
        WHERE Id_Restaurante = p_Id OR p_Id IS NULL;

    v_Id_Restaurante Restaurante.Id_Restaurante%TYPE;
    v_FK_Hotel Restaurante.FK_Hotel%TYPE;
    v_Nombre Restaurante.Nombre%TYPE;
    v_Num_Mesas Restaurante.Num_Mesas%TYPE;
    v_Capacidad Restaurante.Capacidad%TYPE;

BEGIN
OPEN c_Restaurante(p_Id_Restaurante);
LOOP
FETCH c_Restaurante INTO v_Id_Restaurante, v_FK_Hotel, v_Nombre, v_Num_Mesas, v_Capacidad;
EXIT WHEN c_Restaurante%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(
            'ID: ' || v_Id_Restaurante || ', ' ||
            'FK_Hotel: ' || v_FK_Hotel || ', ' ||
            'Nombre: ' || v_Nombre || ', ' ||
            'Nï¿½mero de Mesas: ' || v_Num_Mesas || ', ' ||
            'Capacidad: ' || v_Capacidad
        );
END LOOP;
CLOSE c_Restaurante;
END;

--modificar

CREATE OR REPLACE PROCEDURE RESTAURANTE_MODIFICAR_SP(
    p_Id_Restaurante IN Restaurante.Id_Restaurante%TYPE, -- ID del restaurante a modificar
    p_FK_Hotel IN Restaurante.FK_Hotel%TYPE DEFAULT NULL,
    p_Nombre IN Restaurante.Nombre%TYPE DEFAULT NULL,
    p_Num_Mesas IN Restaurante.Num_Mesas%TYPE DEFAULT NULL,
    p_Capacidad IN Restaurante.Capacidad%TYPE DEFAULT NULL
) IS
BEGIN

    UPDATE Restaurante
    SET
        FK_Hotel = NVL(p_FK_Hotel, FK_Hotel),
        Nombre = NVL(p_Nombre, Nombre),
        Num_Mesas = NVL(p_Num_Mesas, Num_Mesas),
        Capacidad = NVL(p_Capacidad, Capacidad)
    WHERE Id_Restaurante = p_Id_Restaurante;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontrï¿½ ningï¿½n restaurante con el ID ' || p_Id_Restaurante);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Restaurante con ID ' || p_Id_Restaurante || ' modificado correctamente.');
    END IF;
END;


--borrar

CREATE OR REPLACE PROCEDURE RESTAURANTE_BORRAR_SP(
    p_Id_Restaurante IN Restaurante.Id_Restaurante%TYPE
) IS
BEGIN
    DELETE FROM Restaurante
    WHERE Id_Restaurante = p_Id_Restaurante;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontrï¿½ ningï¿½n restaurante con el ID ' || p_Id_Restaurante);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Restaurante con ID ' || p_Id_Restaurante || ' borrado correctamente.');
    END IF;
END;


-- ======================== Ver Reservacion restaurante ======================

CREATE OR REPLACE PROCEDURE ver_reservacion_restaurante_por_id (
    p_id_reservacion IN NUMBER
) AS
    v_fk_huesped     NUMBER;
    v_fk_hotel       NUMBER;
    v_fk_restaurante NUMBER;
    v_fecha_reserva  DATE;
    v_cantidad       NUMBER;
BEGIN

    SELECT 
        FK_Huesped,
        FK_Hotel,
        FK_Restaurante,
        Fecha_Reservacion,
        Cantidad
    INTO 
        v_fk_huesped,
        v_fk_hotel,
        v_fk_restaurante,
        v_fecha_reserva,
        v_cantidad
    FROM 
        ReservacionRestaurante
    WHERE 
        Id_ReservacionRestaurante = p_id_reservacion;

    dbms_output.put_line('ID Reservaciï¿½n Restaurante: ' || p_id_reservacion);
    dbms_output.put_line('FK Huesped: ' || v_fk_huesped);
    dbms_output.put_line('FK Hotel: ' || v_fk_hotel);
    dbms_output.put_line('FK Restaurante: ' || v_fk_restaurante);
    dbms_output.put_line('Fecha de Reservaciï¿½n: ' || TO_CHAR(v_fecha_reserva, 'YYYY-MM-DD'));
    dbms_output.put_line('Cantidad de Personas: ' || v_cantidad);

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('No se encontrï¿½ la reservaciï¿½n con ID ' || p_id_reservacion);
    WHEN OTHERS THEN
        dbms_output.put_line('Error: ' || SQLERRM);
END;


BEGIN
    ver_reservacion_restaurante_por_id(1);
END;



-- =============================================================================
--                      Actualizar reservacion restaurante 
-- =============================================================================
CREATE OR REPLACE PROCEDURE actualizar_reservacion_restaurante (
    p_id_reservacion         IN NUMBER,
    p_fk_huesped             IN NUMBER,
    p_fk_hotel               IN NUMBER,
    p_fk_restaurante         IN NUMBER,
    p_fecha_reservacion      IN DATE,
    p_cantidad               IN NUMBER
) AS
BEGIN
    UPDATE ReservacionRestaurante
    SET
        FK_Huesped = p_fk_huesped,
        FK_Hotel = p_fk_hotel,
        FK_Restaurante = p_fk_restaurante,
        Fecha_Reservacion = p_fecha_reservacion,
        Cantidad = p_cantidad
    WHERE
        Id_ReservacionRestaurante = p_id_reservacion;
END;

BEGIN
    actualizar_reservacion_restaurante( 1, 1, 1, 1, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 2);
    actualizar_reservacion_restaurante( 2, 2, 2, 2, TO_DATE('2024-03-02', 'YYYY-MM-DD'), 4);
    actualizar_reservacion_restaurante( 3, 3, 3, 3, TO_DATE('2024-03-03', 'YYYY-MM-DD'), 3);
    actualizar_reservacion_restaurante( 4, 4, 4, 4, TO_DATE('2024-04-03', 'YYYY-MM-DD'), 1);
    actualizar_reservacion_restaurante( 5, 5, 5, 5, TO_DATE('2024-05-03', 'YYYY-MM-DD'), 5);
    
END;


-- ========================= Eliminar Reservacion restaurante ==================
CREATE OR REPLACE PROCEDURE eliminar_reservacion_restaurante (
    p_id_reservacion IN NUMBER
) AS
BEGIN
    DELETE FROM ReservacionRestaurante
    WHERE Id_ReservacionRestaurante = p_id_reservacion;
END;
/


BEGIN
    eliminar_reservacion_restaurante(6);
END;


-- ==============================Ver Servicio===================================
CREATE OR REPLACE PROCEDURE ver_servicio_por_id (
    p_id_servicio IN NUMBER
) AS
    v_nombre   VARCHAR2(50);
    v_precio   FLOAT;
    v_tipo     VARCHAR2(50);
BEGIN
    SELECT 
        Nombre,
        Precio,
        Tipo
    INTO 
        v_nombre,
        v_precio,
        v_tipo
    FROM 
        Servicio
    WHERE 
        Id_Servicio = p_id_servicio;

    dbms_output.put_line('Id_Servicio: ' || p_id_servicio);
    dbms_output.put_line('Nombre: ' || v_nombre);
    dbms_output.put_line('Precio: ' || v_precio);
    dbms_output.put_line('Tipo: ' || v_tipo);

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Servicio con Id_Servicio ' || p_id_servicio || ' no encontrado.');
    WHEN OTHERS THEN
        dbms_output.put_line('Error: ' || SQLERRM);
END;


BEGIN
    ver_servicio_por_id(1);
END;


-- =========================== Actualizar Servicio =============================
CREATE OR REPLACE PROCEDURE actualizar_servicio (
    p_id_servicio IN NUMBER,
    p_nombre      IN VARCHAR2,
    p_precio      IN FLOAT,
    p_tipo        IN VARCHAR2
) AS
BEGIN
    UPDATE Servicio
    SET
        Nombre = p_nombre,
        Precio = p_precio,
        Tipo   = p_tipo
    WHERE
        Id_Servicio = p_id_servicio;
END;


BEGIN
    actualizar_servicio(
        6,
        'Prueba 2',
        7000,
        'Limpieza'
    );
END;



-- ======================== Eliminar servicio ==================================
CREATE OR REPLACE PROCEDURE eliminar_servicio (
    p_id_servicio IN NUMBER
) AS
BEGIN
    DELETE FROM Servicio
    WHERE Id_Servicio = p_id_servicio;
END;


BEGIN
    eliminar_servicio(6);
END;



-- ======================== Ver reservaciones =================================
CREATE OR REPLACE PROCEDURE ver_reservacion_por_id (
    p_id_reservacion IN NUMBER
) AS
    v_fk_huesped     NUMBER;
    v_fk_hotel       NUMBER;
    v_fk_habitacion  NUMBER;
    v_fk_promocion   NUMBER;
    v_estado         VARCHAR2(30);
    v_comentarios    VARCHAR2(255);
    v_fecha_checkin  DATE;
    v_fecha_checkout DATE;
BEGIN
    SELECT
        FK_Huesped,
        FK_Hotel,
        FK_Habitacion,
        FK_Promocion,
        Estado,
        Comentarios,
        Fecha_CheckIn,
        Fecha_CheckOut
    INTO
        v_fk_huesped,
        v_fk_hotel,
        v_fk_habitacion,
        v_fk_promocion,
        v_estado,
        v_comentarios,
        v_fecha_checkin,
        v_fecha_checkout
    FROM
        Reservacion
    WHERE
        Id_Reservacion = p_id_reservacion;

    dbms_output.put_line('ID Reservaciï¿½n: ' || p_id_reservacion);
    dbms_output.put_line('FK Huesped: ' || v_fk_huesped);
    dbms_output.put_line('FK Hotel: ' || v_fk_hotel);
    dbms_output.put_line('FK Habitaciï¿½n: ' || v_fk_habitacion);
    dbms_output.put_line('FK Promociï¿½n: ' || v_fk_promocion);
    dbms_output.put_line('Estado: ' || v_estado);
    dbms_output.put_line('Comentarios: ' || v_comentarios);
    dbms_output.put_line('Fecha Check-In: ' || TO_CHAR(v_fecha_checkin, 'YYYY-MM-DD'));
    dbms_output.put_line('Fecha Check-Out: ' || TO_CHAR(v_fecha_checkout, 'YYYY-MM-DD'));

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No se encontrï¿½ una reservaciï¿½n con el ID: ' || p_id_reservacion);
    WHEN OTHERS THEN
        dbms_output.put_line('Error: ' || SQLERRM);
END;


BEGIN
    ver_reservacion_por_id(1);
END;



-- ================== Actualizar Reservacion ==================================
CREATE OR REPLACE PROCEDURE actualizarReservacion (
    v_id_reservacion    IN NUMBER,
    v_fk_huesped        IN NUMBER,
    v_fk_hotel          IN NUMBER,
    v_fk_habitacion     IN NUMBER,
    v_fk_promocion      IN NUMBER,
    v_estado            IN VARCHAR2,
    v_comentarios       IN VARCHAR2,
    v_fecha_checkin     IN DATE,
    v_fecha_checkout    IN DATE
)
AS
BEGIN
    UPDATE Reservacion
    SET
        FK_Huesped      = v_fk_huesped,
        FK_Hotel        = v_fk_hotel,
        FK_Habitacion   = v_fk_habitacion,
        FK_Promocion    = v_fk_promocion,
        Estado          = v_estado,
        Comentarios     = v_comentarios,
        Fecha_CheckIn   = v_fecha_checkin,
        Fecha_CheckOut  = v_fecha_checkout
    WHERE Id_Reservacion = v_id_reservacion;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error: ' || SQLERRM);
END;


BEGIN
    actualizarReservacion(1, 1, 1, 1, 1, 'Confirmado', 'Reservaciï¿½n para una noche en habitaciï¿½n con jacuzzi',
        TO_DATE('2024-03-10', 'YYYY-MM-DD'), TO_DATE('2024-03-10', 'YYYY-MM-DD'));

    actualizarReservacion(2, 2, 2, 2, 2, 'Pendiente', 'Habitaciï¿½n doble con vista a la ciudad',
        TO_DATE('2024-03-11', 'YYYY-MM-DD'), TO_DATE('2024-03-11', 'YYYY-MM-DD'));

    actualizarReservacion(3, 3, 3, 3, 3, 'Confirmado', 'Habitaciï¿½n familiar con cama matrimonial y 2 individuales',
        TO_DATE('2024-03-12', 'YYYY-MM-DD'), TO_DATE('2024-03-12', 'YYYY-MM-DD'));

    actualizarReservacion(4, 4, 4, 4, 4, 'Cancelado', 'Reserva cancelada antes del check-in',
        TO_DATE('2024-03-13', 'YYYY-MM-DD'), TO_DATE('2024-03-13', 'YYYY-MM-DD'));

    actualizarReservacion(5, 5, 5, 5, 5, 'Confirmado', 'Habitaciï¿½n con acceso directo a la playa',
        TO_DATE('2024-03-14', 'YYYY-MM-DD'), TO_DATE('2024-03-14', 'YYYY-MM-DD'));
        
    actualizarReservacion(6, 5, 5, 5, 5, 'Confirmado', 'Ejemplo actualizacion',
        TO_DATE('2024-03-01', 'YYYY-MM-DD'), TO_DATE('2024-03-05', 'YYYY-MM-DD'));
END;


-- ========================= Eliminar ==========================================
CREATE OR REPLACE PROCEDURE eliminar_reservacion (
    p_id_reservacion IN NUMBER
) AS
BEGIN
    DELETE FROM Reservacion
    WHERE Id_Reservacion = p_id_reservacion;
END;


BEGIN
    eliminar_reservacion(6);
END;



-- ==========================Ver factura =======================================
CREATE OR REPLACE PROCEDURE ver_factura_por_id (
    p_id_factura IN NUMBER
) AS
    v_fk_reservacion  NUMBER;
    v_fecha_emision   DATE;
    v_descuento       INT;
    v_metodo_pago     VARCHAR2(30);
    v_monto           FLOAT;
    v_estado          VARCHAR2(30);
BEGIN
    SELECT FK_Reservacion, Fecha_Emision, Descuento, Metodo_Pago, Monto, Estado
    INTO v_fk_reservacion, v_fecha_emision, v_descuento, v_metodo_pago, v_monto, v_estado
    FROM Factura
    WHERE Id_Factura = p_id_factura;

    dbms_output.put_line('ID Factura: ' || p_id_factura);
    dbms_output.put_line('FK Reservaciï¿½n: ' || v_fk_reservacion);
    dbms_output.put_line('Fecha Emisiï¿½n: ' || TO_CHAR(v_fecha_emision, 'YYYY-MM-DD'));
    dbms_output.put_line('Descuento: ' || v_descuento || '%');
    dbms_output.put_line('Mï¿½todo de Pago: ' || v_metodo_pago);
    dbms_output.put_line('Monto: ' || v_monto);
    dbms_output.put_line('Estado: ' || v_estado);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No se encontrï¿½ factura con ID ' || p_id_factura);
    WHEN OTHERS THEN
        dbms_output.put_line('Error al consultar factura: ' || SQLERRM);
END;


BEGIN
    ver_factura_por_id(1);
END;


-- ===================== Actualizar Factura ====================================
CREATE OR REPLACE PROCEDURE actualizar_factura (
    p_id_factura      IN NUMBER,
    p_fk_reservacion  IN NUMBER,
    p_fecha_emision   IN DATE,
    p_descuento       IN INT,
    p_metodo_pago     IN VARCHAR2,
    p_monto           IN FLOAT,
    p_estado          IN VARCHAR2
) AS
BEGIN
    UPDATE Factura
    SET 
        FK_Reservacion = p_fk_reservacion,
        Fecha_Emision  = p_fecha_emision,
        Descuento      = p_descuento,
        Metodo_Pago    = p_metodo_pago,
        Monto          = p_monto,
        Estado         = p_estado
    WHERE Id_Factura = p_id_factura;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error al actualizar factura: ' || SQLERRM);
END;


BEGIN
    actualizar_factura(6, 5, TO_DATE('2024-03-05', 'YYYY-MM-DD'), 20, 'Prueba update', 72000, 'Pagado');
END;



-- ========================== Eliminarfactura =================================
CREATE OR REPLACE PROCEDURE eliminar_factura (
    p_id_factura IN NUMBER
) AS
BEGIN
    DELETE FROM Factura
    WHERE Id_Factura = p_id_factura;
END;


BEGIN
    eliminar_factura(6);
END;



-- =============================================================================
--                                      Vistas
-- =============================================================================


-- Vista seleccion todos los datos
CREATE OR REPLACE VIEW vistaHoteles as
SELECT h.Id_Hotel, h.Nombre, h.Ciudad, h.Canton,h.Distrito,h.Detalle_Direccion,h.Telefono,h.Numero_pisos
FROM Hotel h

-- Vistas con join (proveedor, hotel, suministro) 

CREATE OR REPLACE VIEW vistaSuministros AS
SELECT 
    p.Nombre AS Nombre_Proveedor, 
    h.Nombre AS Nombre_Hotel, 
    s.Nombre AS Nombre_Suministro, 
    s.Descripcion, 
    s.Cantidad, 
    s.Costo
FROM Suministro s
JOIN Proveedor p ON s.FK_Proveedor = p.Id_Proveedor
JOIN Hotel h ON s.FK_Hotel = h.Id_Hotel;

-- Vista join promocion (hotel y promocion)

CREATE OR REPLACE VIEW vistaPromocion AS
SELECT 
    h.Nombre AS Nombre_Hotel, 
    p.Id_Promocion,
    p.Descripcion,
    p.Fecha_Inicio,
    p.Fecha_Fin
    
FROM Promocion p
JOIN hotel h ON p.FK_hotel = h.Id_Hotel;

-- Mostrar vehiculos mas recientes 

CREATE OR REPLACE VIEW vistaAï¿½oVehiculo AS
SELECT Id_Vehiculo, Tipo, Marca, Modelo,Aï¿½o,Placa
FROM Vehiculo
WHERE Aï¿½o >= 2022

--  Vista mostrar empleados con salarios mayores 750000

CREATE OR REPLACE VIEW vistaSalarioPuesto AS
SELECT Nombre, salario
FROM Puesto
WHERE Salario >= 750000

-- Reservacion restaurante con nombre del cliente, hotel y restaurante

CREATE OR REPLACE VIEW vistaReservacionRestaurante AS
SELECT 
    h.Nombre AS Nombre_Huesped, 
    t.Nombre AS Nombre_Hotel, 
    R.Nombre_Rest,
    R.Fecha_Reservacion,
    R.Cantidad
    
FROM ReservacionRestaurante  R
JOIN Huesped h ON R.FK_Huesped = h.Id_Huesped
JOIN hotel t ON R.FK_hotel = t.Id_Hotel;

-- Vista para evento mostrando el hotel

CREATE OR REPLACE VIEW vistaEvento AS
SELECT 
    t.Nombre AS Nombre_Hotel, 
    E.Nombre,
    E.Capacidad,
    E.Fecha_Inicio,
    E.Fecha_Fin
    
FROM Evento  E
JOIN hotel t ON E.FK_hotel = t.Id_Hotel;

-- Ver tipos de habitacion con cierta cantidad de casmas

CREATE OR REPLACE VIEW vistaTipoHabitacionCantidadCamas AS
SELECT Nombre, Numero_Camas, Precio_PorNoche, Estado
FROM TipoHabitacion
WHERE Numero_Camas >= 3

DECLARE

    v_Camas NUMBER := 3;
BEGIN

    FOR i IN (
        SELECT Nombre, Numero_Camas, Precio_PorNoche, Estado
        FROM vistaTipoHabitacionCantidadCamas
        WHERE Numero_Camas >= v_Camas
    ) LOOP

        DBMS_OUTPUT.PUT_LINE('Nombre: ' || i.Nombre || ', Numero de Camas: ' || i.Numero_Camas || 
                             ', Precio: ' || i.Precio_PorNoche || ', Estado: ' || i.Estado);
    END LOOP;
END;


-- Vista restaurante con capacidad 

CREATE OR REPLACE VIEW vistaRestauranteCapacidad AS
SELECT 
    t.Nombre AS Nombre_Hotel, 
    R.Nombre,
    R.Num_Mesas,
    R.Capacidad
    
FROM Restaurante  R
JOIN hotel t ON R.FK_hotel = t.Id_Hotel
where R.Capacidad >= 80;

DECLARE

    v_Capacidad NUMBER := 80;
BEGIN

    FOR i IN (
        SELECT Nombre_Hotel, Nombre, Num_Mesas, Capacidad
        FROM vistaRestauranteCapacidad
        WHERE Capacidad >= v_Capacidad
    ) LOOP

        DBMS_OUTPUT.PUT_LINE('Nombre Hotel: ' || i.Nombre_Hotel || 
                             ', Nombre Restaurante: ' || i.Nombre || 
                             ', Nï¿½mero de Mesas: ' || i.Num_Mesas || 
                             ', Capacidad: ' || i.Capacidad);
    END LOOP;
END;


/*
Vista basada en la tabla de mantenimiento para ver las habiataciones en mantenimiento
*/

CREATE OR REPLACE VIEW vistaMantenimiento AS
SELECT 
    H.Descripcion AS Descripcion_habitacion, 
    P.nombre AS Nombre_Proveedor,
    M.Descripcion,
    M.Fecha_Inicio
FROM Mantenimiento M
JOIN Habitacion H ON M.FK_Habitacion = H.Id_Habitacion
JOIN Proveedor P ON M.FK_proveedor = P.Id_Proveedor;


-- =============================================================================
--                              Funciones
-- =============================================================================


-- Funcion para contar total de Huesped

CREATE OR REPLACE FUNCTION total_huespedes return number is
    v_huespedes number;
begin
    select count(*) into v_huespedes from Huesped;
    return v_huespedes;
end;


declare
valor number;
begin
    valor := total_huespedes;
    dbms_output.put_line('Total huespedes: ' || valor);
end;



-- Funcion para buscar el costo de un cuarto especifico por parametro

CREATE OR REPLACE FUNCTION costo_Habitacion (p_Id_TipoHabitacion NUMBER) RETURN NUMBER IS
    v_Precio NUMBER;
BEGIN
    SELECT Precio_PorNoche INTO v_Precio
    FROM TipoHabitacion
    WHERE Id_TipoHabitacion = p_Id_TipoHabitacion;

    RETURN v_Precio;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END;

-- Funcion para buscar cuantos suministros hay por una cantidad especifica en la tabla

CREATE OR REPLACE FUNCTION suministros_Cantidad (p_Cantidad NUMBER) RETURN NUMBER IS
    v_Cantidad NUMBER;
BEGIN

    SELECT COUNT(*)
    INTO v_Cantidad
    FROM Suministro
    WHERE Cantidad = p_Cantidad;

    RETURN v_Cantidad;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END;

SELECT suministros_Cantidad(10) FROM dual;

/* Funcion para ver la cantidad de empleados que ingresaron a partir de una
fecha especifica*/

CREATE OR REPLACE FUNCTION empleados_Fecha_Ingreso (p_Fecha_Ingreso DATE) RETURN NUMBER IS
    v_Numero_empleados NUMBER;
BEGIN

    SELECT COUNT(*)
    INTO v_Numero_empleados
    FROM Empleado
    WHERE Fecha_Ingreso >= p_Fecha_Ingreso;

    RETURN v_Numero_empleados;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END;

SELECT empleados_Fecha_Ingreso (TO_DATE('01/10/2022')) FROM dual;


-- Busqueda de hoteles con una cantidad mayor o igual de pisos por parametro

CREATE OR REPLACE FUNCTION pisos_hotel (p_Numero_pisos NUMBER) RETURN NUMBER IS
    v_Numero_hoteles NUMBER;
BEGIN

    SELECT COUNT(*)
    INTO v_Numero_hoteles
    FROM Hotel
    WHERE Numero_pisos >= p_Numero_pisos;

    RETURN v_Numero_hoteles;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END;

-- Funcion para obtener el numero de eventos de un hotel

CREATE OR REPLACE FUNCTION obtener_eventos_hotel(p_id_hotel NUMBER)
RETURN NUMBER
IS
  v_cantidad_eventos NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_cantidad_eventos
  FROM Evento
  WHERE FK_Hotel = p_id_hotel;
  RETURN v_cantidad_eventos;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 0;
END;


DECLARE
  v_cantidad_eventos NUMBER;
  v_id_hotel NUMBER := 3; 
BEGIN
  v_cantidad_eventos := obtener_eventos_hotel(v_id_hotel);
  dbms_output.put_line('El hotel con ID ' || v_id_hotel || ' tiene ' || v_cantidad_eventos || ' eventos programados.');
END;


-- Funcion para saber cantidad de reservaciones de un huesped

CREATE OR REPLACE FUNCTION obtener_reservaciones_huesped(p_id_huesped NUMBER)
RETURN NUMBER
IS
  v_cantidad_reservaciones NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_cantidad_reservaciones
  FROM ReservacionRestaurante
  WHERE FK_Huesped = p_id_huesped;
  RETURN v_cantidad_reservaciones;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 0;
END;

DECLARE
  v_cantidad_reservaciones NUMBER;
  v_id_huesped NUMBER := 2;
BEGIN
  v_cantidad_reservaciones := obtener_reservaciones_huesped(v_id_huesped);
  dbms_output.put_line('El huï¿½sped con ID ' || v_id_huesped || ' tiene ' || v_cantidad_reservaciones || ' reservaciones de restaurante.');
END;


-- Funcion para obtener funciones disponibles

CREATE OR REPLACE FUNCTION obtener_habitaciones_disponibles(p_id_tipo_habitacion NUMBER)
RETURN NUMBER
IS
  v_cantidad_disponibles NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_cantidad_disponibles
  FROM Habitacion
  WHERE FK_TipoHabitacion = p_id_tipo_habitacion AND Estado = 'Disponible';
  RETURN v_cantidad_disponibles;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 0;
END;


DECLARE
  v_cantidad_disponibles NUMBER;
  v_id_tipo_habitacion NUMBER := 4; 
BEGIN
  v_cantidad_disponibles := obtener_habitaciones_disponibles(v_id_tipo_habitacion);
  dbms_output.put_line('Hay ' || v_cantidad_disponibles || ' habitaciones disponibles del tipo con ID ' || v_id_tipo_habitacion || '.');
END;

--


-- =============================================================================
--                              PKG
-- =============================================================================

CREATE OR REPLACE NONEDITIONABLE PACKAGE pkg_crud_vehiculos AS
PROCEDURE agregarVehiculo(
    v_id_vehiculo IN NUMBER,
    v_fk_hotel IN NUMBER,
    v_tipo IN VARCHAR2,
    v_marca IN VARCHAR2,
    v_modelo IN VARCHAR2,
    v_ano IN INT,
    v_placa IN CHAR
);

PROCEDURE ver_vehiculo_por_id (
    vehiculoid IN NUMBER
);

PROCEDURE actualizar_vehiculo (
    p_vehiculoid IN NUMBER,
    p_hotelid    IN NUMBER,
    p_tipo       IN VARCHAR2,
    p_marca      IN VARCHAR2,
    p_modelo     IN VARCHAR2,
    p_anio       IN NUMBER,
    p_placa      IN VARCHAR2
);

PROCEDURE eliminar_vehiculo (
    p_vehiculoid IN NUMBER
);

END pkg_crud_vehiculos;

CREATE OR REPLACE PACKAGE BODY pkg_crud_vehiculos as
PROCEDURE agregarVehiculo(
    v_id_vehiculo IN NUMBER,
    v_fk_hotel IN NUMBER,
    v_tipo IN VARCHAR2,
    v_marca IN VARCHAR2,
    v_modelo IN VARCHAR2,
    v_ano IN INT,
    v_placa IN CHAR
)
AS
BEGIN

    INSERT INTO Vehiculo (Id_Vehiculo, FK_Hotel, Tipo, Marca, Modelo, AÃ±o, Placa)
    VALUES (v_id_vehiculo, v_fk_hotel, v_tipo, v_marca, v_modelo, v_ano, v_placa);
    
COMMIT;  
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;  
END;

PROCEDURE ver_vehiculo_por_id (
    vehiculoid IN NUMBER
) AS

    v_tipo     VARCHAR2(30);
    v_marca    VARCHAR2(30);
    v_modelo   VARCHAR2(50);
    v_anio     NUMBER;
    v_placa    VARCHAR2(8);
    v_fk_hotel NUMBER;
BEGIN
    SELECT
        tipo,
        marca,
        modelo,
        aÃ±o,
        placa,
        fk_hotel
    INTO
        v_tipo,
        v_marca,
        v_modelo,
        v_anio,
        v_placa,
        v_fk_hotel
    FROM
        vehiculo
    WHERE
        id_vehiculo = vehiculoid;

    dbms_output.put_line('Id_Vehiculo: ' || vehiculoid);
    dbms_output.put_line('Id_Hotel: ' || v_fk_hotel);
    dbms_output.put_line('Tipo: ' || v_tipo);
    dbms_output.put_line('Marca: ' || v_marca);
    dbms_output.put_line('Modelo: ' || v_modelo);
    dbms_output.put_line('AÃ±o: ' || v_anio);
    dbms_output.put_line('Placa: ' || v_placa);
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('VehÃ­culo con Id_Vehiculo '
                             || vehiculoid
                             || ' no encontrado.');
END;
    
     

PROCEDURE actualizar_vehiculo (
    p_vehiculoid IN NUMBER,
    p_hotelid    IN NUMBER,
    p_tipo       IN VARCHAR2,
    p_marca      IN VARCHAR2,
    p_modelo     IN VARCHAR2,
    p_anio       IN NUMBER,
    p_placa      IN VARCHAR2
) AS
BEGIN
    UPDATE vehiculo
    SET
        fk_hotel = p_hotelid,
        tipo = p_tipo,
        marca = p_marca,
        modelo = p_modelo,
        aÃ±o = p_anio,
        placa = p_placa
    WHERE
        id_vehiculo = p_vehiculoid;

END;

PROCEDURE eliminar_vehiculo (
    p_vehiculoid IN NUMBER
) AS
BEGIN
    DELETE FROM vehiculo
    WHERE
        id_vehiculo = p_vehiculoid;

END;

END pkg_crud_vehiculos;

CREATE OR REPLACE NONEDITIONABLE PACKAGE pkg_crud_inventarios AS
PROCEDURE agregarInventario(
    v_id_inventario IN NUMBER,
    v_fk_hotel IN NUMBER,
    v_nombre IN VARCHAR2,
    v_tipo IN VARCHAR2,
    v_marca IN VARCHAR2,
    v_modelo IN VARCHAR2,
    v_serie IN VARCHAR2,
    v_fecha_registro IN DATE,
    v_cantidad IN INT
);

PROCEDURE ver_inventario_por_id (
    inventarioid IN NUMBER
);

PROCEDURE actualizar_inventario (
    p_inventarioid  IN NUMBER,
    p_hotelid       IN NUMBER,
    p_nombre        IN VARCHAR2,
    p_tipo          IN VARCHAR2,
    p_marca         IN VARCHAR2,
    p_modelo        IN VARCHAR2,
    p_serie         IN VARCHAR2,
    p_fecharegistro IN DATE,
    p_cantidad      IN NUMBER
);
    


PROCEDURE eliminar_inventario (
    p_inventarioid IN NUMBER
);
    

END pkg_crud_inventarios; 

CREATE OR REPLACE PACKAGE BODY pkg_crud_inventarios AS 

PROCEDURE agregarInventario(
    v_id_inventario IN NUMBER,
    v_fk_hotel IN NUMBER,
    v_nombre IN VARCHAR2,
    v_tipo IN VARCHAR2,
    v_marca IN VARCHAR2,
    v_modelo IN VARCHAR2,
    v_serie IN VARCHAR2,
    v_fecha_registro IN DATE,
    v_cantidad IN INT
)
AS
BEGIN

    INSERT INTO Inventario (Id_Inventario, FK_Hotel, Nombre, Tipo, Marca, Modelo, Serie, Fecha_Registro, Cantidad)
    VALUES (v_id_inventario, v_fk_hotel, v_nombre, v_tipo, v_marca, v_modelo, v_serie, v_fecha_registro, v_cantidad);
    
COMMIT;  
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;  
END;


PROCEDURE ver_inventario_por_id (
    inventarioid IN NUMBER
) AS

    v_fk_hotel       NUMBER;
    v_nombre         VARCHAR2(30);
    v_tipo           VARCHAR2(30);
    v_marca          VARCHAR2(50);
    v_modelo         VARCHAR2(50);
    v_serie          VARCHAR2(20);
    v_fecha_registro DATE;
    v_cantidad       NUMBER;
BEGIN
    SELECT
        fk_hotel,
        nombre,
        tipo,
        marca,
        modelo,
        serie,
        fecha_registro,
        cantidad
    INTO
        v_fk_hotel,
        v_nombre,
        v_tipo,
        v_marca,
        v_modelo,
        v_serie,
        v_fecha_registro,
        v_cantidad
    FROM
        inventario
    WHERE
        id_inventario = inventarioid;

    dbms_output.put_line('Id_Inventario: ' || inventarioid);
    dbms_output.put_line('IDHotel: ' || v_fk_hotel);
    dbms_output.put_line('Nombre: ' || v_nombre);
    dbms_output.put_line('Tipo: ' || v_tipo);
    dbms_output.put_line('Marca: ' || v_marca);
    dbms_output.put_line('Modelo: ' || v_modelo);
    dbms_output.put_line('Serie: ' || v_serie);
    dbms_output.put_line('Fecha_Registro: ' || to_char(v_fecha_registro, 'YYYY-MM-DD'));
    dbms_output.put_line('Cantidad: ' || v_cantidad);
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Inventario con Id_Inventario '
                             || inventarioid
                             || ' no encontrado.');
END;
    
  

PROCEDURE actualizar_inventario (
    p_inventarioid  IN NUMBER,
    p_hotelid       IN NUMBER,
    p_nombre        IN VARCHAR2,
    p_tipo          IN VARCHAR2,
    p_marca         IN VARCHAR2,
    p_modelo        IN VARCHAR2,
    p_serie         IN VARCHAR2,
    p_fecharegistro IN DATE,
    p_cantidad      IN NUMBER
) AS
BEGIN
    UPDATE inventario
    SET
        fk_hotel = p_hotelid,
        nombre = p_nombre,
        tipo = p_tipo,
        marca = p_marca,
        modelo = p_modelo,
        serie = p_serie,
        fecha_registro = p_fecharegistro,
        cantidad = p_cantidad
    WHERE
        id_inventario = p_inventarioid;

END;
    


PROCEDURE eliminar_inventario (
    p_inventarioid IN NUMBER
) AS
BEGIN
    DELETE FROM inventario
    WHERE
        id_inventario = p_inventarioid;

END;


END pkg_crud_inventarios;


CREATE OR REPLACE NONEDITIONABLE PACKAGE pkg_crud_puestos AS 

PROCEDURE agregarPuesto(
    v_id_puesto IN NUMBER,
    v_nombre IN VARCHAR2,
    v_salario IN INT
);

PROCEDURE ver_puesto_por_id (
    puestoid IN NUMBER
);

PROCEDURE actualizar_puesto (
    p_puestoid IN NUMBER,
    p_nombre   IN VARCHAR2,
    p_salario  IN NUMBER
);

PROCEDURE eliminar_puesto (
    p_puestoid IN NUMBER
);

END pkg_crud_puestos;

CREATE OR REPLACE PACKAGE BODY pkg_crud_puestos AS

PROCEDURE agregarPuesto(
    v_id_puesto IN NUMBER,
    v_nombre IN VARCHAR2,
    v_salario IN INT
)
AS
BEGIN
    
    INSERT INTO Puesto (Id_Puesto, Nombre, Salario)
    VALUES (v_id_puesto, v_nombre, v_salario);
    
COMMIT;
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;  
END;

PROCEDURE ver_puesto_por_id (
    puestoid IN NUMBER
) AS
    v_nombre  VARCHAR2(30);
    v_salario NUMBER;
BEGIN
    SELECT
        nombre,
        salario
    INTO
        v_nombre,
        v_salario
    FROM
        puesto
    WHERE
        id_puesto = puestoid;

    dbms_output.put_line('Id_Puesto: ' || puestoid);
    dbms_output.put_line('Nombre: ' || v_nombre);
    dbms_output.put_line('Salario: ' || v_salario);
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Puesto con Id_Puesto '
                             || puestoid
                             || ' no encontrado.');
END;

PROCEDURE actualizar_puesto (
    p_puestoid IN NUMBER,
    p_nombre   IN VARCHAR2,
    p_salario  IN NUMBER
) AS
BEGIN
    UPDATE puesto
    SET
        nombre = p_nombre,
        salario = p_salario
    WHERE
        id_puesto = p_puestoid;

END;

PROCEDURE eliminar_puesto (
    p_puestoid IN NUMBER
) AS
BEGIN
    DELETE FROM puesto
    WHERE
        id_puesto = p_puestoid;

END;

END pkg_crud_puestos;


--==============================================================================
-- Aqui estan los empleados
-- =============================================================================

ALTER SEQUENCE EMPLEADO_SEQ INCREMENT BY 6;

SELECT EMPLEADO_SEQ.NEXTVAL FROM DUAL;
 

CREATE OR REPLACE PACKAGE EMPLEADO_PKG AS
  TYPE EMPLEADO_CURSOR IS REF CURSOR;

  PROCEDURE INSERTAR_EMPLEADO_SP(
    P_FK_HOTEL       IN EMPLEADO.FK_Hotel%TYPE,
    P_FK_PUESTO      IN EMPLEADO.FK_Puesto%TYPE,
    P_NOMBRE         IN EMPLEADO.Nombre%TYPE,
    P_CEDULA         IN EMPLEADO.Cedula%TYPE,
    P_CORREO         IN EMPLEADO.Correo%TYPE,
    P_TELEFONO       IN EMPLEADO.Telefono%TYPE,
    P_FECHA_INGRESO  IN EMPLEADO.Fecha_Ingreso%TYPE
  );

  PROCEDURE LISTAR_EMPLEADOS_SP(P_CURSOR OUT EMPLEADO_CURSOR);
  
   PROCEDURE ACTUALIZAR_EMPLEADO_SP(
    P_ID_EMPLEADO     IN EMPLEADO.ID_EMPLEADO%TYPE,
    P_FK_HOTEL        IN EMPLEADO.FK_HOTEL%TYPE,
    P_FK_PUESTO       IN EMPLEADO.FK_PUESTO%TYPE,
    P_NOMBRE          IN EMPLEADO.NOMBRE%TYPE,
    P_CEDULA          IN EMPLEADO.CEDULA%TYPE,
    P_CORREO          IN EMPLEADO.CORREO%TYPE,
    P_TELEFONO        IN EMPLEADO.TELEFONO%TYPE,
    P_FECHA_INGRESO   IN EMPLEADO.FECHA_INGRESO%TYPE
  );
  
   PROCEDURE OBTENER_EMPLEADO_POR_ID_SP(P_ID_EMPLEADO IN EMPLEADO.ID_EMPLEADO%TYPE, P_CURSOR OUT SYS_REFCURSOR);
   
   PROCEDURE ELIMINAR_EMPLEADO_SP(
    P_ID_EMPLEADO IN EMPLEADO.ID_EMPLEADO%TYPE
  );

    
END EMPLEADO_PKG;
/

CREATE OR REPLACE PACKAGE BODY EMPLEADO_PKG AS

  PROCEDURE INSERTAR_EMPLEADO_SP(
    P_FK_HOTEL       IN EMPLEADO.FK_Hotel%TYPE,
    P_FK_PUESTO      IN EMPLEADO.FK_Puesto%TYPE,
    P_NOMBRE         IN EMPLEADO.Nombre%TYPE,
    P_CEDULA         IN EMPLEADO.Cedula%TYPE,
    P_CORREO         IN EMPLEADO.Correo%TYPE,
    P_TELEFONO       IN EMPLEADO.Telefono%TYPE,
    P_FECHA_INGRESO  IN EMPLEADO.Fecha_Ingreso%TYPE
  ) IS
  BEGIN
    INSERT INTO EMPLEADO (
      Id_Empleado,
      FK_Hotel,
      FK_Puesto,
      Nombre,
      Cedula,
      Correo,
      Telefono,
      Fecha_Ingreso
    )
    VALUES (
      EMPLEADO_SEQ.NEXTVAL,
      P_FK_HOTEL,
      P_FK_PUESTO,
      P_NOMBRE,
      P_CEDULA,
      P_CORREO,
      P_TELEFONO,
      P_FECHA_INGRESO
    );
  END;

  PROCEDURE LISTAR_EMPLEADOS_SP(P_CURSOR OUT EMPLEADO_CURSOR) IS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT
  E.Id_Empleado,
  E.Nombre,
  E.Cedula,
  E.Correo,
  E.Telefono,
  E.Fecha_Ingreso,
  H.Nombre AS Nombre_Hotel,
  P.Nombre AS Nombre_Puesto
FROM Empleado E
JOIN Hotel H ON E.FK_Hotel = H.Id_Hotel
JOIN Puesto P ON E.FK_Puesto = P.Id_Puesto;

  END;
  
PROCEDURE ACTUALIZAR_EMPLEADO_SP(
    P_ID_EMPLEADO     IN EMPLEADO.ID_EMPLEADO%TYPE,
    P_FK_HOTEL        IN EMPLEADO.FK_HOTEL%TYPE,
    P_FK_PUESTO       IN EMPLEADO.FK_PUESTO%TYPE,
    P_NOMBRE          IN EMPLEADO.NOMBRE%TYPE,
    P_CEDULA          IN EMPLEADO.CEDULA%TYPE,
    P_CORREO          IN EMPLEADO.CORREO%TYPE,
    P_TELEFONO        IN EMPLEADO.TELEFONO%TYPE,
    P_FECHA_INGRESO   IN EMPLEADO.FECHA_INGRESO%TYPE
  ) IS
  BEGIN
    UPDATE EMPLEADO
    SET
      FK_HOTEL      = P_FK_HOTEL,
      FK_PUESTO     = P_FK_PUESTO,
      NOMBRE        = P_NOMBRE,
      CEDULA        = P_CEDULA,
      CORREO        = P_CORREO,
      TELEFONO      = P_TELEFONO,
      FECHA_INGRESO = P_FECHA_INGRESO
    WHERE ID_EMPLEADO = P_ID_EMPLEADO;
  END;
  
  PROCEDURE OBTENER_EMPLEADO_POR_ID_SP(P_ID_EMPLEADO IN EMPLEADO.ID_EMPLEADO%TYPE, P_CURSOR OUT SYS_REFCURSOR) IS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT
        E.ID_EMPLEADO,
        E.NOMBRE,
        E.CEDULA,
        E.CORREO,
        E.TELEFONO,
        E.FECHA_INGRESO,
        E.FK_HOTEL,
        E.FK_PUESTO
      FROM EMPLEADO E
      WHERE E.ID_EMPLEADO = P_ID_EMPLEADO;
  END;

  PROCEDURE ELIMINAR_EMPLEADO_SP(
    P_ID_EMPLEADO IN EMPLEADO.ID_EMPLEADO%TYPE
  ) IS
  BEGIN
    DELETE FROM EMPLEADO
    WHERE ID_EMPLEADO = P_ID_EMPLEADO;
  END ELIMINAR_EMPLEADO_SP;



END EMPLEADO_PKG;
/
-- FINAL EMPLEADOS

CREATE OR REPLACE NONEDITIONABLE PACKAGE pkg_crud_eventos AS 

PROCEDURE agregarEvento(
    v_id_evento IN NUMBER,
    v_fk_hotel IN NUMBER,
    v_nombre IN VARCHAR2,
    v_capacidad IN VARCHAR2,
    v_fecha_inicio IN DATE,
    v_fecha_fin IN DATE
);

PROCEDURE ver_evento_por_id (
    eventoid IN NUMBER
);

PROCEDURE actualizar_evento (
    p_eventoid    IN NUMBER,
    p_hotelid     IN NUMBER,
    p_nombre      IN VARCHAR2,
    p_capacidad   IN VARCHAR2,
    p_fechainicio IN DATE,
    p_fechafin    IN DATE
);

PROCEDURE eliminar_evento (
    p_eventoid IN NUMBER
);

END pkg_crud_eventos;

CREATE OR REPLACE PACKAGE BODY pkg_crud_eventos AS

PROCEDURE agregarEvento(
    v_id_evento IN NUMBER,
    v_fk_hotel IN NUMBER,
    v_nombre IN VARCHAR2,
    v_capacidad IN VARCHAR2,
    v_fecha_inicio IN DATE,
    v_fecha_fin IN DATE
)
AS
BEGIN

    INSERT INTO Evento (Id_Evento, FK_Hotel, Nombre, Capacidad, Fecha_Inicio, Fecha_Fin)
    VALUES (v_id_evento, v_fk_hotel, v_nombre, v_capacidad, v_fecha_inicio, v_fecha_fin);
    
COMMIT;
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;
END;

PROCEDURE ver_evento_por_id (
    eventoid IN NUMBER
) AS

    v_fk_hotel     NUMBER;
    v_nombre       VARCHAR2(30);
    v_capacidad    VARCHAR2(30);
    v_fecha_inicio DATE;
    v_fecha_fin    DATE;
BEGIN
    SELECT
        fk_hotel,
        nombre,
        capacidad,
        fecha_inicio,
        fecha_fin
    INTO
        v_fk_hotel,
        v_nombre,
        v_capacidad,
        v_fecha_inicio,
        v_fecha_fin
    FROM
        evento
    WHERE
        id_evento = eventoid;

    dbms_output.put_line('Id_Evento: ' || eventoid);
    dbms_output.put_line('Id_Hotel: ' || v_fk_hotel);
    dbms_output.put_line('Nombre: ' || v_nombre);
    dbms_output.put_line('Capacidad: ' || v_capacidad);
    dbms_output.put_line('Fecha_Inicio: ' || to_char(v_fecha_inicio, 'YYYY-MM-DD '));
    dbms_output.put_line('Fecha_Fin: ' || to_char(v_fecha_fin, 'YYYY-MM-DD '));
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Evento con Id_Evento '
                             || eventoid
                             || ' no encontrado.');
END;



PROCEDURE actualizar_evento (
    p_eventoid    IN NUMBER,
    p_hotelid     IN NUMBER,
    p_nombre      IN VARCHAR2,
    p_capacidad   IN VARCHAR2,
    p_fechainicio IN DATE,
    p_fechafin    IN DATE
) AS
BEGIN
    UPDATE evento
    SET
        fk_hotel = p_hotelid,
        nombre = p_nombre,
        capacidad = p_capacidad,
        fecha_inicio = p_fechainicio,
        fecha_fin = p_fechafin
    WHERE
        id_evento = p_eventoid;

END;

PROCEDURE eliminar_evento (
    p_eventoid IN NUMBER
) AS
BEGIN
    DELETE FROM evento
    WHERE
        id_evento = p_eventoid;

END;


END pkg_crud_eventos;

CREATE OR REPLACE NONEDITIONABLE PACKAGE pkg_crud_hoteles AS

PROCEDURE agregarHoteles(
    v_id_hotel IN NUMBER,
    v_nombre IN VARCHAR2,
    v_ciudad IN VARCHAR2,
    v_canton IN VARCHAR2,
    v_distrito IN VARCHAR2,
    v_detalle_direccion IN VARCHAR2,
    v_telefono IN VARCHAR2,
    v_numero_pisos IN INT
);

PROCEDURE ver_hotel_por_id (
    hotelid IN NUMBER
);

PROCEDURE actualizar_hotel (
    p_hotelid            IN NUMBER,
    p_nombre             IN VARCHAR2,
    p_ciudad             IN VARCHAR2,
    p_canton             IN VARCHAR2,
    p_distrito           IN VARCHAR2,
    p_detalle_direccion  IN VARCHAR2,
    p_telefono           IN VARCHAR2,
    p_numero_pisos       IN NUMBER
);

PROCEDURE eliminar_hotel (
    p_hotelid IN NUMBER
);

END pkg_crud_hoteles;

CREATE OR REPLACE PACKAGE BODY pkg_crud_hoteles AS
PROCEDURE agregarHoteles(
    v_id_hotel IN NUMBER,
    v_nombre IN VARCHAR2,
    v_ciudad IN VARCHAR2,
    v_canton IN VARCHAR2,
    v_distrito IN VARCHAR2,
    v_detalle_direccion IN VARCHAR2,
    v_telefono IN VARCHAR2,
    v_numero_pisos IN INT
)
AS
BEGIN
    INSERT INTO Hotel (Id_Hotel, Nombre, Ciudad, Canton, Distrito, Detalle_Direccion, Telefono, Numero_pisos)
    VALUES (v_id_hotel, v_nombre, v_ciudad, v_canton, v_distrito, v_detalle_direccion, v_telefono, v_numero_pisos);
    
commit;
Exception
when others then 
rollback;

END;

PROCEDURE ver_hotel_por_id (
    hotelid IN NUMBER
) AS
    v_nombre            VARCHAR2(50);
    v_ciudad            VARCHAR2(50);
    v_canton            VARCHAR2(50);
    v_distrito          VARCHAR2(50);
    v_detalle_direccion VARCHAR2(50);
    v_telefono          VARCHAR2(30);
    v_numero_pisos      NUMBER;
BEGIN

    SELECT 
        Nombre, 
        Ciudad, 
        Canton, 
        Distrito, 
        Detalle_Direccion, 
        Telefono, 
        Numero_pisos
    INTO 
        v_nombre, 
        v_ciudad, 
        v_canton, 
        v_distrito, 
        v_detalle_direccion, 
        v_telefono, 
        v_numero_pisos
    FROM 
        Hotel
    WHERE 
        Id_Hotel = hotelid;

    dbms_output.put_line('Id_Hotel: ' || hotelid);
    dbms_output.put_line('Nombrehotel: ' || v_nombre);
    dbms_output.put_line('Ciudad: ' || v_ciudad);
    dbms_output.put_line('Cantï¿½n: ' || v_canton);
    dbms_output.put_line('Distrito: ' || v_distrito);
    dbms_output.put_line('Detalle Direcciï¿½n: ' || v_detalle_direccion);
    dbms_output.put_line('Telï¿½fono: ' || v_telefono);
    dbms_output.put_line('Nï¿½mero de Pisos: ' || v_numero_pisos);

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Hotel con Id_Hotel ' || hotelid || ' no encontrado.');
    WHEN OTHERS THEN
        dbms_output.put_line('Error: ' || SQLERRM);
END;


PROCEDURE actualizar_hotel (
    p_hotelid            IN NUMBER,
    p_nombre             IN VARCHAR2,
    p_ciudad             IN VARCHAR2,
    p_canton             IN VARCHAR2,
    p_distrito           IN VARCHAR2,
    p_detalle_direccion  IN VARCHAR2,
    p_telefono           IN VARCHAR2,
    p_numero_pisos       IN NUMBER
) AS
BEGIN
    UPDATE Hotel
    SET
        Nombre = p_nombre,
        Ciudad = p_ciudad,
        Canton = p_canton,
        Distrito = p_distrito,
        Detalle_Direccion = p_detalle_direccion,
        Telefono = p_telefono,
        Numero_pisos = p_numero_pisos
    WHERE
        Id_Hotel = p_hotelid;
end;



PROCEDURE eliminar_hotel (
    p_hotelid IN NUMBER
) AS
BEGIN
    DELETE FROM Hotel
    WHERE Id_Hotel = p_hotelid;

END;


END pkg_crud_hoteles;

-- =============================================================================
-- HUESPEDES
-- =============================================================================

CREATE OR REPLACE NONEDITIONABLE PACKAGE pkg_crud_huespedes AS
PROCEDURE agregarHuesped(
    v_id_huesped IN NUMBER,
    v_nombre IN VARCHAR2,
    v_cedula IN INT,
    v_apellido1 IN VARCHAR2,
    v_apellido2 IN VARCHAR2,
    v_correo IN VARCHAR2,
    v_telefono IN INT,
    v_fecha_nacimiento IN DATE,
    v_fecha_registro IN DATE
);

PROCEDURE HUESPED_OBETENER_SP (
    p_id_huesped IN huesped.id_huesped%TYPE DEFAULT NULL
);

PROCEDURE HUESPED_MODIFICAR_SP(
    p_Id_Huesped IN Huesped.Id_Huesped%TYPE, 
    p_Nombre IN Huesped.Nombre%TYPE DEFAULT NULL, 
    p_Cedula IN Huesped.Cedula%TYPE DEFAULT NULL, 
    p_Apellido1 IN Huesped.Apellido1%TYPE DEFAULT NULL, 
    p_Apellido2 IN Huesped.Apellido2%TYPE DEFAULT NULL, 
    p_Correo IN Huesped.Correo%TYPE DEFAULT NULL, 
    p_Telefono IN Huesped.Telefono%TYPE DEFAULT NULL,
    p_Fecha_Nacimiento IN Huesped.Fecha_Nacimiento%TYPE DEFAULT NULL,
    p_Fecha_Registro IN Huesped.Fecha_Registro%TYPE DEFAULT NULL 
);

PROCEDURE HUESPED_BORRAR_SP(
    p_Id_Huesped IN Huesped.Id_Huesped%TYPE
);

END pkg_crud_huespedes;

CREATE OR REPLACE PACKAGE BODY pkg_crud_huespedes AS

PROCEDURE agregarHuesped(
    v_id_huesped IN NUMBER,
    v_nombre IN VARCHAR2,
    v_cedula IN INT,
    v_apellido1 IN VARCHAR2,
    v_apellido2 IN VARCHAR2,
    v_correo IN VARCHAR2,
    v_telefono IN INT,
    v_fecha_nacimiento IN DATE,
    v_fecha_registro IN DATE
)
AS
BEGIN

    INSERT INTO Huesped (Id_Huesped, Nombre, Cedula, Apellido1, Apellido2, Correo, Telefono, Fecha_Nacimiento, Fecha_Registro)
    VALUES (v_id_huesped, v_nombre, v_cedula, v_apellido1, v_apellido2, v_correo, v_telefono, v_fecha_nacimiento, v_fecha_registro);
    
COMMIT;  
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;
END;


PROCEDURE HUESPED_OBETENER_SP (
    p_id_huesped IN huesped.id_huesped%TYPE DEFAULT NULL
) IS

    CURSOR c_huesped IS
    SELECT
        id_huesped,
        nombre,
        cedula,
        apellido1,
        apellido2,
        correo,
        telefono,
        fecha_nacimiento,
        fecha_registro
    FROM
        huesped
    WHERE
        p_id_huesped IS NULL OR id_huesped = p_id_huesped;

    v_id_huesped       huesped.id_huesped%TYPE;
    v_nombre           huesped.nombre%TYPE;
    v_cedula           huesped.cedula%TYPE;
    v_apellido1        huesped.apellido1%TYPE;
    v_apellido2        huesped.apellido2%TYPE;
    v_correo           huesped.correo%TYPE;
    v_telefono         huesped.telefono%TYPE;
    v_fecha_nacimiento huesped.fecha_nacimiento%TYPE;
    v_fecha_registro   huesped.fecha_registro%TYPE;

BEGIN
    OPEN c_huesped;
    LOOP
        FETCH c_huesped INTO v_id_huesped, v_nombre, v_cedula, v_apellido1, v_apellido2, v_correo, v_telefono, v_fecha_nacimiento, v_fecha_registro;
        EXIT WHEN c_huesped%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            'ID: ' || v_id_huesped || ', ' ||
            'Nombre: ' || v_nombre || ' ' || v_apellido1 || ' ' || v_apellido2 || ', ' ||
            'Cédula: ' || v_cedula || ', ' ||
            'Correo: ' || v_correo || ', ' ||
            'Teléfono: ' || v_telefono || ', ' ||
            'Fecha Nacimiento: ' || TO_CHAR(v_fecha_nacimiento, 'YYYY-MM-DD') || ', ' ||
            'Fecha Registro: ' || TO_CHAR(v_fecha_registro, 'YYYY-MM-DD')
        );
    END LOOP;
    CLOSE c_huesped;
END;

PROCEDURE HUESPED_MODIFICAR_SP(
    p_Id_Huesped IN Huesped.Id_Huesped%TYPE, 
    p_Nombre IN Huesped.Nombre%TYPE DEFAULT NULL, 
    p_Cedula IN Huesped.Cedula%TYPE DEFAULT NULL, 
    p_Apellido1 IN Huesped.Apellido1%TYPE DEFAULT NULL, 
    p_Apellido2 IN Huesped.Apellido2%TYPE DEFAULT NULL, 
    p_Correo IN Huesped.Correo%TYPE DEFAULT NULL, 
    p_Telefono IN Huesped.Telefono%TYPE DEFAULT NULL,
    p_Fecha_Nacimiento IN Huesped.Fecha_Nacimiento%TYPE DEFAULT NULL,
    p_Fecha_Registro IN Huesped.Fecha_Registro%TYPE DEFAULT NULL 
) IS
BEGIN

    UPDATE Huesped
    SET
        Nombre = NVL(p_Nombre, Nombre), 
        Cedula = NVL(p_Cedula, Cedula),
        Apellido1 = NVL(p_Apellido1, Apellido1),
        Apellido2 = NVL(p_Apellido2, Apellido2),
        Correo = NVL(p_Correo, Correo),
        Telefono = NVL(p_Telefono, Telefono),
        Fecha_Nacimiento = NVL(p_Fecha_Nacimiento, Fecha_Nacimiento),
        Fecha_Registro = NVL(p_Fecha_Registro, Fecha_Registro)
    WHERE Id_Huesped = p_Id_Huesped;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontrï¿½ ningï¿½n huï¿½sped con el ID ' || p_Id_Huesped);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Huï¿½sped con ID ' || p_Id_Huesped || ' modificado correctamente.');
    END IF;
END;

PROCEDURE HUESPED_BORRAR_SP(
    p_Id_Huesped IN Huesped.Id_Huesped%TYPE
) IS
BEGIN

    DELETE FROM Huesped
    WHERE Id_Huesped = p_Id_Huesped;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontrï¿½ ningï¿½n huï¿½sped con el ID ' || p_Id_Huesped);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Huï¿½sped con ID ' || p_Id_Huesped || ' borrado correctamente.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al borrar el huï¿½sped: ' || SQLERRM);
END;

END pkg_crud_huespedes;




----FALTA PROCEDIMIENTOS DE FATURACION MOSTRAR,ACTUALIZAR Y ELIMINAR.---------
CREATE OR REPLACE NONEDITIONABLE PACKAGE pkg_crud_facturas AS

PROCEDURE agregarFactura(
    v_id_factura IN NUMBER,
    v_fk_reservacion IN NUMBER,
    v_fecha_emision IN DATE,
    v_descuento IN INT,
    v_metodo_pago IN VARCHAR2,
    v_monto IN FLOAT,
    v_estado IN VARCHAR2
);

END pkg_crud_facturas;


CREATE OR REPLACE PACKAGE BODY pkg_crud_facturas AS

PROCEDURE agregarFactura(
    v_id_factura IN NUMBER,
    v_fk_reservacion IN NUMBER,
    v_fecha_emision IN DATE,
    v_descuento IN INT,
    v_metodo_pago IN VARCHAR2,
    v_monto IN FLOAT,
    v_estado IN VARCHAR2
)
AS
BEGIN
    
    INSERT INTO Factura (Id_Factura, FK_Reservacion, Fecha_Emision, Descuento, Metodo_Pago, Monto, Estado)
    VALUES (v_id_factura, v_fk_reservacion, v_fecha_emision, v_descuento, v_metodo_pago, v_monto, v_estado);
    
COMMIT;
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;  
END;



END pkg_crud_facturas;

-----------------------
--RESERVACION
-----------------------

CREATE SEQUENCE RESERVACION_SEQ
  START WITH 1
  INCREMENT BY 1
  NOCACHE;

CREATE OR REPLACE PACKAGE pkg_crud_reservaciones AS
  TYPE cursor_reservaciones IS REF CURSOR;

  PROCEDURE agregar_reservacion(
    p_fk_huesped     IN NUMBER,
    p_fk_hotel       IN NUMBER,
    p_fk_habitacion  IN NUMBER,
    p_fk_promocion   IN NUMBER,
    p_fecha_checkin  IN DATE,
    p_fecha_checkout IN DATE,
    p_estado         IN VARCHAR2,
    p_comentarios    IN VARCHAR2
  );

  PROCEDURE listar_reservaciones(p_cursor OUT cursor_reservaciones);

  PROCEDURE obtener_reservacion_por_id(
    p_id_reservacion IN NUMBER,
    p_cursor         OUT cursor_reservaciones
  );

  PROCEDURE actualizar_reservacion(
    p_id_reservacion IN NUMBER,
    p_fk_huesped     IN NUMBER,
    p_fk_hotel       IN NUMBER,
    p_fk_habitacion  IN NUMBER,
    p_fk_promocion   IN NUMBER,
    p_fecha_checkin  IN DATE,
    p_fecha_checkout IN DATE,
    p_estado         IN VARCHAR2,
    p_comentarios    IN VARCHAR2
  );

  PROCEDURE eliminar_reservacion(p_id_reservacion IN NUMBER);
END pkg_crud_reservaciones;
/


CREATE OR REPLACE PACKAGE BODY pkg_crud_reservaciones AS

  PROCEDURE agregar_reservacion(
    p_fk_huesped     IN NUMBER,
    p_fk_hotel       IN NUMBER,
    p_fk_habitacion  IN NUMBER,
    p_fk_promocion   IN NUMBER,
    p_fecha_checkin  IN DATE,
    p_fecha_checkout IN DATE,
    p_estado         IN VARCHAR2,
    p_comentarios    IN VARCHAR2
  ) IS
  BEGIN
    INSERT INTO Reservacion (
      Id_Reservacion,
      FK_Huesped,
      FK_Hotel,
      FK_Habitacion,
      FK_Promocion,
      Fecha_CheckIn,
      Fecha_CheckOut,
      Estado,
      Comentarios
    ) VALUES (
      RESERVACION_SEQ.NEXTVAL,
      p_fk_huesped,
      p_fk_hotel,
      p_fk_habitacion,
      p_fk_promocion,
      p_fecha_checkin,
      p_fecha_checkout,
      p_estado,
      p_comentarios
    );
  END agregar_reservacion;

  PROCEDURE listar_reservaciones(p_cursor OUT cursor_reservaciones) IS
  BEGIN
    OPEN p_cursor FOR
      SELECT
        r.Id_Reservacion,
        r.FK_Huesped,
        r.FK_Hotel,
        r.FK_Habitacion,
        r.FK_Promocion,
        r.Fecha_CheckIn,
        r.Fecha_CheckOut,
        r.Estado,
        r.Comentarios
      FROM Reservacion r;
  END listar_reservaciones;

  PROCEDURE obtener_reservacion_por_id(
    p_id_reservacion IN NUMBER,
    p_cursor         OUT cursor_reservaciones
  ) IS
  BEGIN
    OPEN p_cursor FOR
      SELECT
        r.Id_Reservacion,
        r.FK_Huesped,
        r.FK_Hotel,
        r.FK_Habitacion,
        r.FK_Promocion,
        r.Fecha_CheckIn,
        r.Fecha_CheckOut,
        r.Estado,
        r.Comentarios
      FROM Reservacion r
      WHERE r.Id_Reservacion = p_id_reservacion;
  END obtener_reservacion_por_id;

  PROCEDURE actualizar_reservacion(
    p_id_reservacion IN NUMBER,
    p_fk_huesped     IN NUMBER,
    p_fk_hotel       IN NUMBER,
    p_fk_habitacion  IN NUMBER,
    p_fk_promocion   IN NUMBER,
    p_fecha_checkin  IN DATE,
    p_fecha_checkout IN DATE,
    p_estado         IN VARCHAR2,
    p_comentarios    IN VARCHAR2
  ) IS
  BEGIN
    UPDATE Reservacion
    SET
      FK_Huesped     = p_fk_huesped,
      FK_Hotel       = p_fk_hotel,
      FK_Habitacion  = p_fk_habitacion,
      FK_Promocion   = p_fk_promocion,
      Fecha_CheckIn  = p_fecha_checkin,
      Fecha_CheckOut = p_fecha_checkout,
      Estado         = p_estado,
      Comentarios    = p_comentarios
    WHERE Id_Reservacion = p_id_reservacion;
  END actualizar_reservacion;

  PROCEDURE eliminar_reservacion(p_id_reservacion IN NUMBER) IS
  BEGIN
    DELETE FROM Reservacion
    WHERE Id_Reservacion = p_id_reservacion;
  END eliminar_reservacion;

END pkg_crud_reservaciones;


-- Eliminar procedimientos fuera del paquete----

DROP PROCEDURE agregarReservacion;
DROP PROCEDURE ver_reservacion_por_id;
DROP PROCEDURE actualizarReservacion;
DROP PROCEDURE eliminar_reservacion;


DROP PROCEDURE agregarVehiculo;
DROP PROCEDURE ver_vehiculoporid;
DROP PROCEDURE actualizar_vehiculo;
DROP PROCEDURE eliminar_vehiculo;


DROP PROCEDURE agregarInventario;
DROP PROCEDURE ver_inventario_por_id;
DROP PROCEDURE actualizar_inventario;
DROP PROCEDURE eliminar_inventario;


DROP PROCEDURE agregarPuesto;
DROP PROCEDURE ver_puesto_por_id;
DROP PROCEDURE actualizar_puesto;
DROP PROCEDURE eliminar_puesto;


DROP PROCEDURE agregarEmpleado;
DROP PROCEDURE ver_empleado_por_id;
DROP PROCEDURE actualizar_empleado;
DROP PROCEDURE eliminar_empleado;


DROP PROCEDURE agregarEvento;
DROP PROCEDURE ver_evento_por_id;
DROP PROCEDURE actualizar_evento;
DROP PROCEDURE eliminar_evento;


DROP PROCEDURE agregarHoteles;
DROP PROCEDURE ver_hotel_por_id;
DROP PROCEDURE actualizar_hotel;
DROP PROCEDURE eliminar_hotel;


DROP PROCEDURE agregarHuesped;
DROP PROCEDURE HUESPED_OBETENER_SP;
DROP PROCEDURE HUESPED_MODIFICAR_SP;
DROP PROCEDURE HUESPED_BORRAR_SP;
-- =============================================================================
--                              Creacion de triggers
-- ============================================================================

--PARA EVITAR QUE SE APLIQUE UN DESCUENTO MAYOR AL 50%

CREATE OR REPLACE TRIGGER trg_descuento_factura
BEFORE UPDATE OF Descuento ON Factura
FOR EACH ROW
BEGIN
  IF :new.Descuento > 50 THEN
    RAISE_APPLICATION_ERROR(-20002, 'Descuento no puede ser mayor al 50%');
  END IF;
END;

DECLARE
  ex_descuento_factura EXCEPTION;
  PRAGMA EXCEPTION_INIT(ex_descuento_factura, -20002);
BEGIN
  UPDATE Factura
  SET Descuento = 70
  WHERE Id_Factura = 1;
EXCEPTION
  WHEN ex_descuento_factura THEN
    DBMS_OUTPUT.PUT_LINE('Error de Trigger: Descuento mayor al 50% no permitido');
END;


--VA A IMPEDIR CAMBIAR EL ESTADO DE UNA RESERVACIÃN A CANCELADO LUEGO DEL CHECK-IN

CREATE OR REPLACE TRIGGER trg_estado_reservacion
BEFORE UPDATE OF Estado ON Reservacion
FOR EACH ROW
BEGIN
  IF :new.Estado = 'Cancelado' AND :old.FK_CheckIn IS NOT NULL THEN
    RAISE_APPLICATION_ERROR(-20003, 'No se puede cancelar una reservaciÃ³n con check-in registrado');
  END IF;
END;


DECLARE
  ex_estado_reservacion EXCEPTION;
  PRAGMA EXCEPTION_INIT(ex_estado_reservacion, -20003);
BEGIN
  UPDATE Reservacion
  SET Estado = 'Cancelado'
  WHERE Id_Reservacion = 1;
EXCEPTION
  WHEN ex_estado_reservacion THEN
    DBMS_OUTPUT.PUT_LINE('Error de Trigger: No se puede cancelar reservaciÃ³n con Check-In');
END;


--- VALIDAR EL COSTO EN SUMINISTROS

CREATE OR REPLACE TRIGGER trg_costo_suministro
BEFORE INSERT OR UPDATE OF Costo ON Suministro
FOR EACH ROW
BEGIN
  IF :new.Costo > 10000 THEN
    RAISE_APPLICATION_ERROR(-20004, 'Costo de suministro excede el lÃ­mite permitido');
  END IF;
END;


DECLARE
  ex_costo_suministro EXCEPTION;
  PRAGMA EXCEPTION_INIT(ex_costo_suministro, -20004);
BEGIN
  INSERT INTO Suministro (Id_Suministro, FK_Proveedor, FK_Hotel, Nombre, Descripcion, Cantidad, Costo)
  VALUES (1, 1, 1, 'Producto X', 'DescripciÃ³n', 10, 15000);
EXCEPTION
  WHEN ex_costo_suministro THEN
    DBMS_OUTPUT.PUT_LINE('Error de Trigger: Costo de suministro muy alto');
END;


---NO VA A PERMITIR ACTUALIZAR LA CAPACIDAD A MENOS DE 10 PERSONAS

CREATE OR REPLACE TRIGGER trg_capacidad_evento
BEFORE UPDATE OF Capacidad ON Evento
FOR EACH ROW
BEGIN
  IF TO_NUMBER(:new.Capacidad) < 10 THEN
    RAISE_APPLICATION_ERROR(-20005, 'La capacidad mÃ­nima de un evento debe ser de al menos 10 personas');
  END IF;
END;

DECLARE
  ex_capacidad_evento EXCEPTION;
  PRAGMA EXCEPTION_INIT(ex_capacidad_evento, -20005);
BEGIN
  UPDATE Evento
  SET Capacidad = '5'
  WHERE Id_Evento = 1;
EXCEPTION
  WHEN ex_capacidad_evento THEN
    DBMS_OUTPUT.PUT_LINE('Error de Trigger: Capacidad mÃ­nima no permitida');
END;


--VA A IMPEDIR ESTABLECER UN PRECIO NEGATIVO A UN SERVICIO

CREATE OR REPLACE TRIGGER trg_precio_servicio
BEFORE INSERT OR UPDATE OF Precio ON Servicio
FOR EACH ROW
BEGIN
  IF :new.Precio <= 0 THEN
    RAISE_APPLICATION_ERROR(-20006, 'El precio del servicio debe ser mayor a cero');
  END IF;
END;

DECLARE
  ex_precio_servicio EXCEPTION;
  PRAGMA EXCEPTION_INIT(ex_precio_servicio, -20006);
BEGIN
  UPDATE Servicio
  SET Precio = 0
  WHERE Id_Servicio = 1;
EXCEPTION
  WHEN ex_precio_servicio THEN
    DBMS_OUTPUT.PUT_LINE('Error de Trigger: Precio debe ser mayor a cero');
END;


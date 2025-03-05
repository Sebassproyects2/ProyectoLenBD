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
Año INT NOT NULL,
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

CREATE TABLE Servicio (
Id_Servicio NUMBER PRIMARY KEY not null, -- llave primaria
Nombre VARCHAR(50)NOT NULL,
Precio FLOAT NOT NULL,
Tipo VARCHAR(50) NOT  NULL
);

CREATE TABLE CheckIn (
Id_CheckIn NUMBER PRIMARY KEY not null, -- llave primaria
--FK_Reservacion NUMBER NOT NULL,
Fecha_CheckIn DATE NOT NULL,
Estado VARCHAR(30) NOT NULL
--CONSTRAINT FK_idReservacionCheckIn FOREIGN KEY (FK_Reservacion) REFERENCES Reservacion (Id_Reservacion)
);
-- ============================================================================================================
-- Con estos bloque se agregan la FK de la reservacion, ejecutar despues de crear la tabla reservacion
-- ============================================================================================================
ALTER TABLE CheckIn
ADD FK_Reservacion NUMBER NOT NULL;

ALTER TABLE CheckIn
ADD CONSTRAINT FK_idReservacionCheckIn FOREIGN KEY (FK_Reservacion) REFERENCES Reservacion (Id_Reservacion);
--===========================================================================

CREATE TABLE CheckOut (
Id_CheckOut NUMBER PRIMARY KEY not null, -- llave primaria
-- FK_Reservacion NUMBER NOT NULL,
Fecha_CheckOut DATE NOT NULL,
Estado VARCHAR(30) NOT NULL,
Mensaje VARCHAR(30) NOT NULL
-- CONSTRAINT FK_idReservacionCheckout FOREIGN KEY (FK_Reservacion) REFERENCES Reservacion (Id_Reservacion)
);

-- ============================================================================================================
-- Con estos bloque se agregan la FK de la reservacion, ejecutar despues de crear la tabla reservacion
-- ============================================================================================================
ALTER TABLE CheckOut
ADD FK_Reservacion NUMBER NOT NULL;

ALTER TABLE CheckOut
add CONSTRAINT FK_idReservacionCheckout FOREIGN KEY (FK_Reservacion) REFERENCES Reservacion (Id_Reservacion);
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

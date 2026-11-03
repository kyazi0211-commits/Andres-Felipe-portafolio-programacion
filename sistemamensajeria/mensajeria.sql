CREATE DATABASE mensajeria;

USE mensajeria;

CREATE TABLE envios(

id INT AUTO_INCREMENT PRIMARY KEY,

remitente VARCHAR(100),

destinatario VARCHAR(100),

telefonoRemitente VARCHAR(20),

telefonoDestinatario VARCHAR(20),

ciudadOrigen VARCHAR(100),

ciudadDestino VARCHAR(100),

direccion VARCHAR(150),

tipoPaquete VARCHAR(50),

peso DECIMAL(5,2),

descripcion TEXT,

fecha DATE

);
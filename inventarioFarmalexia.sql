---inventario

--base de datos

--hola david ggggg
---segundo commit
DROP DATABASE IF EXISTS farmalexia;
CREATE DATABASE IF NOT EXISTS farmalexia;
USE farmalexia;


CREATE TABLE persona(
idpersona INT AUTO_INCREMENT PRIMARY KEY,
ci INT NOT NULL UNIQUE,
primerNombre VARCHAR(25) NOT NULL,
seguntoNombre VARCHAR(25) NULL,
apellidoPaterno VARCHAR(25) NOT NULL, 
apellidoMaterno VARCHAR(25) NULL,
sexo ENUM ('M','F'),
fechaNacimiento DATE
)ENGINE=InnoDB;


CREATE TABLE rol(
idrol INT AUTO_INCREMENT PRIMARY KEY,
tipoPersona VARCHAR(25) UNIQUE NOT NULL
)ENGINE=InnoDB;


CREATE TABLE cliente(
idcliente INT AUTO_INCREMENT PRIMARY KEY,
primerNombre VARCHAR(25) NOT NULL,
seguntoNombre VARCHAR(25) NULL,
apellidoPaterno VARCHAR(25) NOT NULL,
apellidoMaterno VARCHAR(25) NULL
)ENGINE=InnoDB;


CREATE TABLE rolCliente(
idRolCliente INT AUTO_INCREMENT PRIMARY KEY,
tipoCliente VARCHAR(25) NOT NULL
)ENGINE=InnoDB;


CREATE TABLE medicamentos(
idMedicamento INT AUTO_INCREMENT PRIMARY KEY,
nombreMedicamento VARCHAR(50),
composicionMedicamento VARCHAR(50) NULL,
tipoMedicamento VARCHAR(25) NOT NULL,
presentacionMedicamento VARCHAR(25) NOT NULL,
precioDeVenta DECIMAL(8,2)
)ENGINE=InnoDB;

CREATE TABLE proveedores(
idprovedor INT UNIQUE AUTO_INCREMENT PRIMARY KEY,
nombreProveedor VARCHAR(25)
)ENGINE=InnoDB;



CREATE TABLE identidad(
idIdentidad INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
contrasenha VARCHAR(25) UNIQUE NOT NULL,
activo bool NOT NULL,
idpersona INT NOT NULL
idrol INT NOT,
FOREIGN KEY(idpersona) REFERENCES persona(idpersona) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY(idrol) REFERENCES rol(idrol) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=InnoDB;



--tablas relacionales
CREATE TABLE registroFarmaco(
idRegistro INT AUTO_INCREMENT PRIMARY KEY NOT null,
fechaRegistro DATETIME,
cantidadRegistrada INT NOT null,
fechaVencimiento DATE NOT NULL,
idMedicamento INT NOT NULL,
idprovedor INT NOT NULL,
FOREIGN KEY(idMedicamento) REFERENCES medicamentos(idMedicamento) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY(idprovedor) REFERENCES proveedores(idprovedor) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=InnoDB;

CREATE TABLE salidaMedicamentos(
idSalidaMedicamentos INT AUTO_INCREMENT PRIMARY KEY NOT null,
fechaHoraVenta DATETIME NOT null,
cantidaSalidaMendicamentos INT NOT NULL,
idRegistro INT NOT NULL,
ididentidad INT NOT NULL,
FOREIGN KEY(idRegistro) REFERENCES registroFarmaco(idRegistro) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY(ididentidad) REFERENCES identidad(ididentidad) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=InnoDB;




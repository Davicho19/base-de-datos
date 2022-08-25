DROP DATABASE IF EXISTS farmalexia;
CREATE DATABASE IF NOT EXISTS farmalexia;
USE farmalexia;


CREATE TABLE usuario(
idusuario INT PRIMARY KEY,
ci INT NOT NULL UNIQUE,
primerNombre VARCHAR(25) NOT NULL,
seguntoNombre VARCHAR(25) NULL,
apellidoPaterno VARCHAR(25) NOT NULL, 
apellidoMaterno VARCHAR(25) NULL,
sexo ENUM ('M','F'),
fechaNacimiento DATE,
celular INT,
direccion TEXT
)ENGINE=InnoDB;

CREATE TABLE rol(
idrol INT PRIMARY KEY,
tipoPersona VARCHAR(25) UNIQUE NOT NULL
)ENGINE=InnoDB;


CREATE TABLE identidad(
idIdentidad INT AUTO_INCREMENT PRIMARY KEY,
contrasenha VARCHAR(25) UNIQUE NOT NULL,
activo bool NOT NULL,
idusuario INT NOT NULL,
idrol INT NOT NULL,
FOREIGN KEY(idusuario) REFERENCES usuario(idusuario) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY(idrol) REFERENCES rol(idrol) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=InnoDB;

CREATE TABLE cliente(
idcliente INT PRIMARY KEY NULL,
primerNombre VARCHAR(25) NULL,
seguntoNombre VARCHAR(25) NULL,
apellidoPaterno VARCHAR(25) NULL,
apellidoMaterno VARCHAR(25) NULL,
nit INT
)ENGINE=InnoDB;


CREATE TABLE miembroClinica(
idMiembroClinica INT AUTO_INCREMENT PRIMARY KEY,
primerNombre VARCHAR(25) NOT NULL,
seguntoNombre VARCHAR(25) NULL,
apellidoPaterno VARCHAR(25) NOT NULL,
apellidoMaterno VARCHAR(25) NULL
)ENGINE=InnoDB;


CREATE TABLE rolMiembroClinica(
idRolMiembroClinica INT AUTO_INCREMENT PRIMARY KEY NULL,
tipoCliente VARCHAR(25) NOT NULL    
)ENGINE=InnoDB;


CREATE TABLE registroMiembroClinica(
idRegistroCliente INT AUTO_INCREMENT PRIMARY KEY,
idMiembroClinica INT NOT NULL,
idRolMiembroClinica INT NULL, 
FOREIGN KEY(idMiembroClinica) REFERENCES miembroClinica(idMiembroClinica) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY(idRolMiembroClinica) REFERENCES rolMiembroClinica(idRolMiembroClinica) ON UPDATE CASCADE ON DELETE CASCADE
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


--tablas relacionales
CREATE TABLE registroFarmaco(
idRegistroMedicamento INT AUTO_INCREMENT PRIMARY KEY,
fechaRegistro DATETIME,
cantidadRegistrada INT NOT null,
fechaVencimiento DATE NOT NULL,
idMedicamento INT NOT NULL,
idprovedor INT NOT NULL,
FOREIGN KEY(idMedicamento) REFERENCES medicamentos(idMedicamento) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY(idprovedor) REFERENCES proveedores(idprovedor) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=InnoDB;

CREATE TABLE ventaMedicamento(
idVentaMedicamento INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
fechaHoraVenta DATETIME NOT null,
cantidadVendida INT NOT NULL,
idRegistroMedicamento INT NOT NULL,
ididentidad INT NOT NULL,
idRegistroCliente INT NULL,
FOREIGN KEY(idRegistroMedicamento) REFERENCES registroFarmaco(idRegistroMedicamento) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY(ididentidad) REFERENCES identidad(ididentidad) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY(idRegistroCliente) REFERENCES registroMiembroClinica(idRegistroCliente) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=InnoDB;


CREATE TABLE consumoInterno(
idConsumoInterno INT AUTO_INCREMENT PRIMARY KEY,
cantidadConsumoInterno INT NOT NULL,
idRegistroMedicamento INT NOT NULL,
idRolMiembroClinica INT NOT NULL,
idIdentidad INT NOT NULL,
FOREIGN KEY(idRegistroMedicamento) REFERENCES registroFarmaco(idRegistroMedicamento) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY(idRolMiembroClinica) REFERENCES rolMiembroClinica(idRolMiembroClinica) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY(idIdentidad) REFERENCES identidad(idIdentidad) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=InnoDB;



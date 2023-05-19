CREATE DATABASE sprintm3;

CREATE USER 'sprinter'@'localhost' IDENTIFIED BY 'P4ssw0rd_2023';

GRANT ALL PRIVILEGES ON 'sprintm3' TO 'sprinter'@'localhost';

CREATE TABLE IF NOT EXISTS clientes (
  id INT PRIMARY KEY,
  nombre VARCHAR(100),
  direccion VARCHAR(200),
 );
 
CREATE  TABLE IF NOT EXISTS proveedores (

	id integer PRIMARY KEY AUTO_INCREMENT,
    rep_legal varchar(100) not null,
    nom_corporativo varchar(100) not null,
    email varchar(60) not null,
    categoria varchar(60)
    
);


CREATE TABLE IF NOT EXISTS contacto_proveedor(
	fk_proveedor integer ,
    numero integer,
    encargado varchar(60),
    
    CONSTRAINT pk_key_contacto primary key(fk_proveedor , numero),
    CONSTRAINT fk_contacto_proveedor foreign key (fk_proveedor) references proveedores(id) 

);


INSERT INTO clientes (nombre, apellido, direccion)
VALUES ('Juan', 'Pérez', 'Calle 123, La Serena'),
       ('María', 'García', 'Avenida Principal 456, Santiago'),
       ('Pedro', 'Rodríguez', 'Calle Secundaria 789, Antofagasta'),
       ('Ana', 'López', 'Calle Principal 321, Puerto Montt'),
       ('Luis', 'Martínez', 'Avenida Central 654, Iquique');
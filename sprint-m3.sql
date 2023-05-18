CREATE DATABASE sprintm3;

CREATE USER 'sprinter'@'localhost' IDENTIFIED BY 'P4ssw0rd_2023';

GRANT ALL PRIVILEGES ON 'sprintm3' TO 'sprinter'@'localhost';

CREATE TABLE IF NOT EXISTS clientes (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100),
  apellido VARCHAR(100),
  direccion VARCHAR(200)
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

CREATE TABLE IF NOT EXISTS productos(
	id integer PRIMARY KEY AUTO_INCREMENT,
    nombre varchar(60) not null,
    categoria varchar(60) ,
    precio integer default 0 ,
    color varchar(60) ,
    stock_local integer default 0
);

CREATE TABLE IF NOT EXISTS producto_proveedor( -- producto -  proveedor ( proveedor avisa su stock reservado disponible para telovendo)
	fk_producto integer ,
    fk_proveedor integer ,
    stock_proveedor integer default 0,
    
    CONSTRAINT pk_key_prod_proveedor primary key( fk_producto , fk_proveedor) ,
    constraint fk_proveedor foreign key (fk_proveedor) references proveedores(id) ,
    constraint fk_producto foreign key (fk_producto) references productos(id) 

);

CREATE TABLE IF NOT EXISTS cliente_producto( -- cliente compra producto
	fk_producto integer ,
    fk_cliente integer ,
    cantidad integer default 1 , 
    fecha_hora timestamp default now(),
    
    CONSTRAINT pk_keycompra primary key( fk_producto , fk_cliente , fecha_hora) ,
    constraint fk_cliente foreign key (fk_cliente) references clientes(id) ,
    constraint fk_producto foreign key (fk_producto) references productos(id) 

);



INSERT INTO clientes (nombre, apellido, direccion)
VALUES ('Juan', 'Pérez', 'Calle 123, La Serena'),
       ('María', 'García', 'Avenida Principal 456, Santiago'),
       ('Pedro', 'Rodríguez', 'Calle Secundaria 789, Antofagasta'),
       ('Ana', 'López', 'Calle Principal 321, Puerto Montt'),
       ('Luis', 'Martínez', 'Avenida Central 654, Iquique');
       
INSERT INTO proveedores (rep_legal, nom_corporativo, email, categoria) 
VALUES
    ('Juan Pérez', 'Celulares Pérez', 'juan.perez@celularezperez.cl', 'Celulares'),
    ('Mei Yuan Xi', 'Todo China', 'maria.rodriguez@36984.com', 'Accesorios'),
    ('Pedro Gómez', 'MiCompu.cl', 'p.gomez@micompu.cl', 'Computadores'),
    ('Luisa López', 'Yo lo Tengo', 'llopez@yolotengo.com', 'Piezas de PC'),
    ('Carlos Fernández', 'Camaras Carlos Fernandez EIRL', 'carlos.fernandez@gmail.com', 'Cámaras');

INSERT INTO productos (nombre, categoria, precio, color, stock_local)
VALUES ('Iphone 13', 'Celulares', '700000', 'Blanco', '10'),
       ('Samsung Galaxy Z Flip 4', 'Celulares', '680000', 'Negro', '8'),
       ('Xiaomi Black Shark 5 Pro', 'Celulares', '600000', 'Negro', '6'),
       ('Huawei Nova 10', 'Celulares', '500000', 'Blanco', '7'),
       ('Notebook Lenovo', 'Notebook', '350000', 'Negro', '4'),
       ('Notebook HP', 'Notebook', '550000', 'Negro', '6'),
       ('Notebook Asus', 'Notebook', '480000', 'Negro', '3'),
       ('Macbook Lenovo', 'Notebook', '800000', 'Negro', '4'),
       ('Cámara EOS Rebel T100', 'Cámara', '450000', 'Negro', '2'),
       ('Bolso Cámara EOS Rebel', 'Accesorio', '20000', 'Negro', '5'),
-- Creación de base de daatos
CREATE DATABASE sprintm3;

--Creación de usuario
CREATE USER 'sprinter'@'localhost' IDENTIFIED BY 'P4ssw0rd_2023';

-- Dar priviliegio a usuario creado
GRANT ALL PRIVILEGES ON sprintm3.* TO 'sprinter'@'localhost';

-- Creación de tabla clientes
CREATE TABLE IF NOT EXISTS clientes (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100),
  apellido VARCHAR(100),
  direccion VARCHAR(200)
 );

--Creación de tabla proveedores
CREATE  TABLE IF NOT EXISTS proveedores (

	id integer PRIMARY KEY AUTO_INCREMENT,
    rep_legal varchar(100) not null,
    nom_corporativo varchar(100) not null,
    email varchar(60) not null,
    categoria varchar(60)
);

--Creación de tabla de contactos
CREATE TABLE IF NOT EXISTS contacto_proveedor(
	fk_proveedor integer ,
    numero integer,
    encargado varchar(60),
    
    CONSTRAINT pk_key_contacto primary key(fk_proveedor , numero),
    CONSTRAINT fk_contacto_proveedor foreign key (fk_proveedor) references proveedores(id) 
);

--Creación de tabla productos
CREATE TABLE IF NOT EXISTS productos(
	id integer PRIMARY KEY AUTO_INCREMENT,
    nombre varchar(60) not null,
    categoria varchar(60) ,
    precio integer default 0 ,
    color varchar(60) ,
    stock_local integer default 0
);

-- Creación de tabla intermedia Producto_Poveedor
CREATE TABLE IF NOT EXISTS producto_proveedor( -- producto -  proveedor ( proveedor avisa su stock reservado disponible para telovendo)
	fk_producto integer ,
    fk_proveedor integer ,
    stock_proveedor integer default 0,
    
    CONSTRAINT pk_key_prod_proveedor primary key( fk_producto , fk_proveedor) ,
    constraint fk_proveedor foreign key (fk_proveedor) references proveedores(id) ,
    constraint fk_producto foreign key (fk_producto) references productos(id) 

);

-- Creación de tabla intermedia cliente_producto
CREATE TABLE IF NOT EXISTS cliente_producto( -- cliente compra producto
	fk_producto integer ,
    fk_cliente integer ,
    cantidad integer default 1 , 
    fecha_hora timestamp default now(),
    
    CONSTRAINT pk_keycompra primary key( fk_producto , fk_cliente , fecha_hora) ,
    constraint fk_cliente2 foreign key (fk_cliente) references clientes(id) ,
    constraint fk_producto2 foreign key (fk_producto) references productos(id) 
);

-- Carga de información de Clientes
INSERT INTO clientes (nombre, apellido, direccion)
VALUES ('Juan', 'Pérez', 'Calle 123, La Serena'),
       ('María', 'García', 'Avenida Principal 456, Santiago'),
       ('Pedro', 'Rodríguez', 'Calle Secundaria 789, Antofagasta'),
       ('Ana', 'López', 'Calle Principal 321, Puerto Montt'),
       ('Luis', 'Martínez', 'Avenida Central 654, Iquique');

-- Carga de información de proveedores 
INSERT INTO proveedores (rep_legal, nom_corporativo, email, categoria) 
VALUES
    ('Juan Pérez', 'Celulares Pérez', 'juan.perez@celularezperez.cl', 'Celulares'),
    ('Mei Yuan Xi', 'Todo China', 'maria.rodriguez@36984.com', 'Accesorios'),
    ('Pedro Gómez', 'MiCompu.cl', 'p.gomez@micompu.cl', 'Computadores'),
    ('Luisa López', 'Yo lo Tengo', 'llopez@yolotengo.com', 'Celulares'),
    ('Carlos Fernández', 'Camaras Carlos Fernandez EIRL', 'carlos.fernandez@gmail.com', 'Cámaras');

-- Carga de información de productos
INSERT INTO productos (nombre, categoria, precio, color, stock_local)
VALUES ('Iphone 13', 'Celulares', '700000', 'Blanco', '10'),
       ('Samsung Galaxy Z Flip 4', 'Celulares', '680000', 'Negro', '8'),
       ('Xiaomi Black Shark 5 Pro', 'Celulares', '600000', 'Negro', '6'),
       ('Huawei Nova 10', 'Celulares', '500000', 'Blanco', '7'),
       ('Notebook Lenovo', 'Notebook', '350000', 'Negro', '4'),
       ('Notebook HP', 'Notebook', '550000', 'Negro', '6'),
       ('Notebook Asus', 'Notebook', '480000', 'Negro', '3'),
       ('Macbook Apple', 'Notebook', '800000', 'Space Gray', '4'),
       ('Cámara EOS Rebel T100', 'Cámara', '450000', 'Negro', '2'),
       ('Bolso Cámara EOS Rebel', 'Accesorio', '20000', 'Negro', '5');

-- Carga de datos de las ventas realizadas
INSERT INTO cliente_producto (fk_producto, fk_cliente, cantidad)
VALUES
(5, 2, 2),
(8 ,3, 3),
(1, 1, 2),
(10, 4, 1),
(6, 2, 5);
-- carga de tabla relacion producto_proveedor 
INSERT INTO producto_proveedor (`fk_producto`, `fk_proveedor`, `stock_proveedor`) VALUES ('1', '1', '15');
INSERT INTO producto_proveedor (`fk_producto`, `fk_proveedor`, `stock_proveedor`) VALUES ('10', '2', '30');
INSERT INTO producto_proveedor (`fk_producto`, `fk_proveedor`, `stock_proveedor`) VALUES ('7', '3', '18');
INSERT INTO producto_proveedor (`fk_producto`, `fk_proveedor`, `stock_proveedor`) VALUES ('2', '4', '22');
INSERT INTO producto_proveedor (`fk_producto`, `fk_proveedor`, `stock_proveedor`) VALUES ('3', '2', '35');
INSERT INTO producto_proveedor (`fk_producto`, `fk_proveedor`, `stock_proveedor`) VALUES ('5', '3', '15');
INSERT INTO producto_proveedor (`fk_producto`, `fk_proveedor`, `stock_proveedor`) VALUES ('3', '5', '29');
INSERT INTO producto_proveedor (`fk_producto`, `fk_proveedor`, `stock_proveedor`) VALUES ('4', '4', '10');
INSERT INTO producto_proveedor (`fk_producto`, `fk_proveedor`, `stock_proveedor`) VALUES ('1', '5', '24');
INSERT INTO producto_proveedor (`fk_producto`, `fk_proveedor`, `stock_proveedor`) VALUES ('8', '3', '8');
INSERT INTO producto_proveedor (`fk_producto`, `fk_proveedor`, `stock_proveedor`) VALUES ('3', '1', '18');
INSERT INTO producto_proveedor (`fk_producto`, `fk_proveedor`, `stock_proveedor`) VALUES ('4', '1', '7');
INSERT INTO producto_proveedor (`fk_producto`, `fk_proveedor`, `stock_proveedor`) VALUES ('9', '5', '10');



-- Cuál es la categoría de productos que más se repite.
SELECT  categoria, COUNT(*) AS total_productos
FROM productos
GROUP BY categoria
HAVING COUNT(*) = (
    SELECT MAX(total_productos)
    FROM (
        SELECT categoria, COUNT(*) AS total_productos
        FROM productos
        GROUP BY categoria
    ) AS subquery
);

-- Cuales son los productos con mayor stock 
SELECT  nombre, stock_local
FROM productos
HAVING stock_local = (
    SELECT MAX(stock_local)
        FROM productos
);

-- Qué color de producto es más común en nuestra tienda.
SELECT color
FROM productos
GROUP BY color
HAVING COUNT(*) = (
    SELECT MAX(total_productos)
    FROM (
        SELECT color, COUNT(*) AS total_productos
        FROM productos
        GROUP BY color
    ) AS subquery
);

-- Cambien la categoría de productos más popular por ‘Electrónica y computación’.
UPDATE `sprintm3`.`productos` SET `categoria` = 'Electronica y Computación' WHERE (`id` = '5');
UPDATE `sprintm3`.`productos` SET `categoria` = 'Electronica y Computación' WHERE (`id` = '6');
UPDATE `sprintm3`.`productos` SET `categoria` = 'Electronica y Computación' WHERE (`id` = '7');
UPDATE `sprintm3`.`productos` SET `categoria` = 'Electronica y Computación' WHERE (`id` = '8');

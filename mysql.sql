CREATE DATABASE IF NOT EXISTS campus_pizza;
USE campus_pizza;

-- 1. Clientes
CREATE TABLE clientes (
id_cliente INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
telefono VARCHAR(20),
email VARCHAR(100),
direccion VARCHAR(150)
);

-- 2. Categorías (Pizzas, Panzerotis, Bebidas, Postres)
CREATE TABLE categorias (
id_categoria INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL
);

-- 3. Productos
CREATE TABLE productos (
id_producto INT AUTO_INCREMENT PRIMARY KEY,  
nombre VARCHAR(100) NOT NULL,
descripcion TEXT,
precio DECIMAL(10,2) NOT NULL,
id_categoria INT,
FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

-- 4. Ingredientes
CREATE TABLE ingredientes (
id_ingrediente INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
stock INT DEFAULT 0
);

-- 5. Relación Productos - Ingredientes (Recetas)
CREATE TABLE producto_ingrediente (
id_producto INT,
id_ingrediente INT,
cantidad VARCHAR(50),
PRIMARY KEY (id_producto, id_ingrediente),
FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
FOREIGN KEY (id_ingrediente) REFERENCES ingredientes(id_ingrediente)
);

-- 6. Adiciones (Extra queso, salsas, etc.)
CREATE TABLE adiciones (
id_adicion INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
precio DECIMAL(10,2) NOT NULL
);

-- 7. Combos
CREATE TABLE combos (
id_combo INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
precio DECIMAL(10,2) NOT NULL
);

-- 8. Productos por Combo
CREATE TABLE combo_producto (
id_combo INT,
id_producto INT,
cantidad INT DEFAULT 1,
PRIMARY KEY (id_combo, id_producto),
FOREIGN KEY (id_combo) REFERENCES combos(id_combo),
FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- 9. Pedidos
CREATE TABLE pedidos (
id_pedido INT AUTO_INCREMENT PRIMARY KEY,
id_cliente INT,
fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
tipo_pedido VARCHAR(50), -- 'En el lugar' o 'Para recoger'
total DECIMAL(10,2),
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- 10. Detalle del Pedido (Productos o Combos pedidos)
CREATE TABLE detalle_pedido (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_producto INT NULL,
    id_combo INT NULL,
    cantidad INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_combo) REFERENCES combos(id_combo)
);

-- 11. Adiciones agregadas a los productos del pedido
CREATE TABLE detalle_adiciones (
    id_detalle INT,
    id_adicion INT,
    cantidad INT,
    PRIMARY KEY (id_detalle, id_adicion),
    FOREIGN KEY (id_detalle) REFERENCES detalle_pedido(id_detalle),
    FOREIGN KEY (id_adicion) REFERENCES adiciones(id_adicion)
);


INSERT INTO categorias (nombre) values
('pizzas'),
('panzeroti'),
('bebidas'),
('postres');

select * from clientes;

INSERT INTO clientes (nombre,telefono,email,direccion) values
('David', '3138061906', 'daviidsierra1422@gmail.com','callle 1'),
('Santiago', '3188061906', 'santiago1422@gmail.com','callle 2'),
('Joel', '3118061906', 'joel1422@gmail.com','callle 3'),
('Lopera', '3108061906', 'lopera1422@gmail.com','callle 4'),
('Sergio', '3128061906', 'sergio1422@gmail.com','callle 5'),
('Edison', '3148061906', 'edison1422@gmail.com','callle 6'),
('Carolina', '3158061906', 'caro1422@gmail.com','callle 7'),
('Danna', '3168061906', 'danna1422@gmail.com','callle 8'),
('Didier', '317061906', 'didier1422@gmail.com','callle 9'),
('Karen', '3198061906', 'karem1422@gmail.com','callle 10');


INSERT INTO productos (nombre,descripcion,precio,id_categoria) values
('pizza peperoni','pizza estandar con rodajas de peperonni y borde corcante relleno de bocadillo', 25000, 1),
('pizza mexicana','pizza estandar con porciones de carne y chiles con un pequeño toque de salsa de aji y borde corcante relleno de bocadillo', 25000, 1),
('pizza hawaina','pizza estandar con pequeños cuadros de piña y una salsa de piña debajo del queso junto con la del tomate y borde corcante relleno de bocadillo', 25000, 1),
('pizza de carnes','pizza estandar con porciones de carnes rojas y blancas y unas pociones de embutidos como salchicas o chorizos y borde corcante relleno de bocadillo', 25000, 1),
('panzzeroti de carne','pazzeroti relleno de carne molida con sazon de la casa y y buen relleno de queso derretido', 10000, 2),
('panzzeroti de pollo','pazzeroti relleno de pollo desmechado con sazon de la casa y y buen relleno de queso derretido', 10000, 2),
('panzzeroti mixto','pazzeroti relleno de carne molida y pollo desmechado con sazon de la casa y y buen relleno de queso derretido', 10000, 2),
('coca-cola personal','coca-cola 450ml', 5000 , 3),
('coca-cola 1.5','coca-cola 1.5L', 8500 , 3),
('coca-cola MEGA','coca-cola 3.2L', 15000 , 3),
('vaso agua','vaso agua 450ml', 2500 , 3),
('jarra limonada','Limonada casera de la casa 1.5L', 5000 , 3),
('jarra jugo natural','jarra de jugo sabor(mango,mora,lulo) 1.5L', 7000 , 3),
('Tiramisú','Bizcochos empapados en café, intercalados con una suave crema de queso mascarpone y un toque de cacao en polvo', 5000, 4),
('Panna Cotta','Un postre frío de origen italiano hecho con crema de leche cocida, que suele acompañarse con salsa de frutos rojos, maracuyá o chocolate', 3500, 4),
('Cheesecake (Torta de queso)',' Pastel cremoso de queso sobre una base crujiente de galleta, a menudo cubierto con mermelada o glaseado de frutos amarillos o rojos', 4500, 4);

INSERT INTO ingredientes (nombre, stock) VALUES
('Queso Mozzarella', 100),
('Peperoni', 50),
('Carne Molida', 40),
('Pollo Desmechado', 40),
('Piña en trozos', 30),
('Masa de la casa', 80);

INSERT INTO producto_ingrediente (id_producto, id_ingrediente, cantidad) VALUES
(1, 1, '200g'), -- Pizza peperoni -> Queso
(1, 2, '100g'), -- Pizza peperoni -> Peperoni
(2, 1, '200g'), -- Pizza mexicana -> Queso
(2, 3, '150g'), -- Pizza mexicana -> Carne
(3, 1, '200g'), -- Pizza hawaina -> Queso
(3, 5, '120g'), -- Pizza hawaina -> Piña
(5, 1, '100g'), -- Panzzeroti carne -> Queso
(5, 3, '100g'), -- Panzzeroti carne -> Carne
(6, 1, '100g'), -- Panzzeroti pollo -> Queso
(6, 4, '100g'); -- Panzzeroti pollo -> Pollo

INSERT INTO adiciones (nombre, precio) VALUES
('Extra queso', 3000.00),
('Salsa de ajo', 1500.00),
('Tocineta extra', 4000.00),
('Jalapeños', 2000.00),
('Champiñones', 2500.00);

INSERT INTO combos (nombre, precio) VALUES
('Combo Pareja', 32000.00),
('Combo Familiar', 55000.00),
('Combo Panzzeroti', 14000.00),
('Combo Personal', 28000.00),
('Combo Mega Fiesta', 80000.00);

INSERT INTO combo_producto (id_combo, id_producto, cantidad) VALUES
(1, 1, 1), -- Combo Pareja: 1 Pizza Peperoni
(1, 8, 2), -- Combo Pareja: 2 Coca-Cola personal
(2, 4, 2), -- Combo Familiar: 2 Pizzas de Carnes
(2, 9, 1), -- Combo Familiar: 1 Coca-Cola 1.5L
(3, 5, 1); -- Combo Panzzeroti: 1 Panzzeroti de Carne


INSERT INTO pedidos (id_cliente, fecha, tipo_pedido, total) VALUES
(1, '2026-10-01 12:30:00', 'En el lugar', 30000.00),
(2, '2026-10-02 19:00:00', 'Para recoger', 32000.00),
(1, '2026-10-03 13:15:00', 'En el lugar', 25000.00),
(3, '2026-10-04 20:00:00', 'Para recoger', 15000.00),
(1, '2026-10-05 14:00:00', 'En el lugar', 10000.00),
(1, '2026-10-05 18:30:00', 'Para recoger', 55000.00),
(2, '2026-10-02 21:00:00', 'Para recoger', 13000.00),
(3, '2026-10-03 12:00:00', 'En el lugar', 28000.00);


INSERT INTO detalle_pedido (id_pedido, id_producto, id_combo, cantidad, subtotal) VALUES
(1, 1, NULL, 1, 25000.00),    -- Pedido 1: Pizza peperoni
(1, 8, NULL, 1, 5000.00),     -- Pedido 1: Coca-cola personal
(2, NULL, 1, 1, 32000.00),    -- Pedido 2: Combo Pareja
(3, 2, NULL, 1, 25000.00),    -- Pedido 3: Pizza mexicana
(4, 5, NULL, 1, 10000.00),    -- Pedido 4: Panzzeroti carne
(4, 8, NULL, 1, 5000.00),     -- Pedido 4: Coca-cola personal
(5, 6, NULL, 1, 10000.00),    -- Pedido 5: Panzzeroti pollo
(6, NULL, 2, 1, 55000.00);    -- Pedido 6: Combo Familiar




-- 1. Productos más vendidos
SELECT p.nombre, SUM(dp.cantidad) AS total_vendido
FROM detalle_pedido dp
JOIN productos p ON dp.id_producto = p.id_producto
GROUP BY p.id_producto, p.nombre
ORDER BY total_vendido DESC;

-- 2. Total de ingresos generados por cada combo
SELECT c.nombre, SUM(dp.subtotal) AS total_ingresos
FROM detalle_pedido dp
JOIN combos c ON dp.id_combo = c.id_combo
GROUP BY c.id_combo, c.nombre;

-- 3. Pedidos realizados para recoger vs. comer en la pizzería
SELECT tipo_pedido, COUNT(*) AS cantidad_pedidos
FROM pedidos
GROUP BY tipo_pedido;

-- 4. Adiciones más solicitadas en pedidos personalizados
SELECT a.nombre, SUM(da.cantidad) AS total_solicitado
FROM detalle_adiciones da
JOIN adiciones a ON da.id_adicion = a.id_adicion
GROUP BY a.id_adicion, a.nombre
ORDER BY total_solicitado DESC;

-- 5. Cantidad total de productos vendidos por categoría
SELECT c.nombre AS categoria, SUM(dp.cantidad) AS total_vendido
FROM detalle_pedido dp
JOIN productos p ON dp.id_producto = p.id_producto
JOIN categorias c ON p.id_categoria = c.id_categoria
GROUP BY c.id_categoria, c.nombre;

-- 6. Promedio de pizzas pedidas por cliente
SELECT AVG(pizzas_por_cliente) AS promedio_pizzas
FROM (
    SELECT p.id_cliente, SUM(dp.cantidad) AS pizzas_por_cliente
    FROM pedidos p
    JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
    JOIN productos pr ON dp.id_producto = pr.id_producto
    JOIN categorias c ON pr.id_categoria = c.id_categoria
    WHERE c.nombre = 'Pizzas'
    GROUP BY p.id_cliente
) AS subconsulta;

-- 7. Total de ventas por día de la semana
SELECT DAYNAME(fecha) AS dia, SUM(total) AS total_ventas
FROM pedidos
GROUP BY DAYNAME(fecha);

-- 8. Cantidad de panzarottis vendidos con extra queso
SELECT SUM(dp.cantidad) AS total_panzarottis
FROM detalle_pedido dp
JOIN productos p ON dp.id_producto = p.id_producto
JOIN categorias c ON p.id_categoria = c.id_categoria
JOIN detalle_adiciones da ON dp.id_detalle = da.id_detalle
JOIN adiciones a ON da.id_adicion = a.id_adicion
WHERE c.nombre = 'Panzarottis' AND a.nombre = 'Extra queso';

-- 9. Pedidos que incluyen bebidas como parte de un combo
SELECT DISTINCT dp.id_pedido
FROM detalle_pedido dp
JOIN combo_producto cp ON dp.id_combo = cp.id_combo
JOIN productos p ON cp.id_producto = p.id_producto
JOIN categorias c ON p.id_categoria = c.id_categoria
WHERE c.nombre = 'Bebidas';
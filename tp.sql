--Ejercicio 1 – Crear Base de Datos 
--Crear una base de datos llamada veterinaria_patitas_felices.
CREATE DATABASE veterinaria_patitas_felices;

--Ejercicio 2 – Crear tabla duenos
--Crear la tabla duenos con las siguientes columnas:

CREATE TABLE duenos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion VARCHAR(100)
)

--Ejercicio 3 – Crear tabla mascotas
--Crear la tabla mascotas con las siguientes columnas:
CREATE TABLE mascotas(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    especie VARCHAR(30) NOT NULL,
    fecha_nacimiento DATE,
    id_dueno INT,
    FOREIGN KEY (id_dueno) REFERENCES duenos(id)
)

--Ejercicio 4 – Crear tabla veterinarios
--Crear la tabla veterinarios con las siguientes columnas:

CREATE TABLE veterinarios(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    matricula VARCHAR(20) UNIQUE NOT NULL,
    especialidad VARCHAR(50) NOT NULL
)

--Ejercicio 5 – Crear tabla historial_clinico
--Crear la tabla historial_clinico con las siguientes columnas:

CREATE TABLE historial_clinico(
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_mascotas INT,
    FOREIGN KEY (id_mascotas) REFERENCES mascotas(id) ON DELETE CASCADE,
    id_veterinario INT,
    FOREIGN KEY (id_veterinario) REFERENCES veterinarios(id),
    fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    descripcion VARCHAR(250) NOT NULL
)

--Ejercicio 6 – Insertar registros
--3 dueños con información completa
INSERT INTO duenos (nombre, apellido, telefono, direccion)
VALUES
('Ana', 'García', '1123456789','Avenida Rivadavia 5890 Caballito'),
('Roberto', 'Martínez', '1198765432','Calle Juncal 1345	Recoleta'),
('Sofía', 'López', '1150050050','Pasaje Lanín 321 La Boca');
('Ignacio', 'López Rodriguez', '1161804354','Lobos 848');

--3 mascotas, cada una asociada a un dueño
INSERT INTO mascotas (nombre, especie, fecha_nacimiento, id_dueno)
VALUES
('Max', 'Perro', '2022-05-15', 1),
('Luna', 'Gato', '2023-01-20', 2),
('tyson','perro','2012-01-10',3);

--2 veterinarios con especialidades distintas
INSERT INTO veterinarios (nombre, apellido, matricula, especialidad)
VALUES
('Juan', 'Pablo', '20514236', 'Cirugía'),
('Georgina', 'Del Barba', '20415162', 'Cardiología');

--3 registros de historial clínico
INSERT INTO historial_clinico (id_mascotas,id_veterinario,fecha_registro,descripcion)
VALUES
('1','1','2025-11-15','se ha recuperado bien de la cirugía. Le hicimos una laparotomía exploratoria porque tenía una obstrucción intestinal. Logramos identificar y retirar un juguete que estaba causando el bloqueo'),
('2','2','2025-11-25','Se observa cardiomegalia global (tamaño cardíaco aumentado)')




--Ejercicio 7 – Actualizar registros
--1. Cambiar la dirección de un dueño (por ID o nombre).
UPDATE duenos
SET direccion = 'suipacha 1122'
WHERE id = 1

--2. Actualizar la especialidad de un veterinario (por ID o matrícula).
UPDATE veterinarios
SET especialidad = 'Cirugia Ortopedia'
WHERE id = 1

--3. Editar la descripción de un historial clínico (por ID).
UPDATE historial_clinico
SET descripcion = 'Se observa cardiomegalia global, La tráquea y bronquios principales se ven normales'
WHERE id = 2




--Ejercicio 8 – Eliminar registros
--1. Eliminar una mascota (por ID o nombre).
DELETE FROM mascotas WHERE id = 1
--2. Verificar que se eliminen automáticamente los registros del historial clínico asociados
--(ON DELETE CASCADE).

-- NO SE SI ESTA BIEN PERO PERO TUVE QUE HACER DE NUEVO LA TABLA 
-- ELIMINARLA Y CREARLA CON EL ON DELETE CASCADE Y CUANDO EJECUTO DELETE FROM mascotas WHERE id = 1 YA SE BORRA DE LA TABLA historial_clinico


--Ejercicio 9 – JOIN simple
--Consulta que muestre:
--● Nombre de la mascota
--● Especie
--● Nombre completo del dueño (nombre + apellido)

SELECT 
    m.nombre AS nombre_mascota, 
    m.especie, 
    CONCAT(d.nombre, ' ', d.apellido) AS nombre_completo_dueno
FROM mascotas m
INNER JOIN duenos d ON m.id_dueno = d.id;


--Ejercicio 10 – JOIN múltiple con historial
--Consulta que muestre todas las entradas del historial clínico con:
--● Nombre y especie de la mascota
--● Nombre completo del dueño
--● Nombre completo del veterinario
--● Fecha de registro
--● Descripción
--Ordenados por fecha de registro descendente (DESC).
SELECT 

    h.fecha_registro,
    h.descripcion,
    
    CONCAT(d.nombre, ' ', d.apellido) AS nombre_completo_dueno,
    CONCAT(v.nombre, ' ', v.apellido) AS nombre_completo_veterinario,
    
    m.nombre AS nombre_mascota,
    m.especie

FROM historial_clinico h

INNER JOIN mascotas m ON m.id = h.id_mascotas
INNER JOIN duenos d ON d.id = m.id_dueno
INNER JOIN veterinarios v ON h.id_veterinario = v.id

ORDER BY h.fecha_registro DESC;
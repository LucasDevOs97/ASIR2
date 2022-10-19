MySQL y Postrgesql

1ª Evaluación  
- Copias de Seguridad
- Usuarios
- Permisos y roles
- Procedimientos almacenados (Stored Procedures)

2ª Evaluación
- Vistas
- Triggers
- MongoDB (NoSQL)

Método de evaluación:
- Controle: 30%
- Práctica: 20%
- Final: 50%

# Copias de Seguridad

- Comando básico:
    - mysqldump --user=USUARIO --password=CONTRASEÑA BASE_DE_DATOS > copia_seguridad.sql

- --skip-opt: nos sirve para hacer copias de seguridad en sistemas más antiguos.

Ruta para poder acceder a MySQL a través del cmd: C:\Program Files\MySQL\MySQL Server 8.0\bin; después ya podríamos ejecutar el comando mysql -u root -p

## EJEMPLO DE COPIA DE SEGURIRDAD CON FECHA Y HORA

mysqldump -u root -p sakila > copiaSakila_%date:~-4,4%-%date:~-7,2%-%date:~-10,2%_%time:~0,2%-%time:~3,2%-%time:~6,2%.sql

Una transacción garantiza que se realicen todas las operaciones

Tabla film_actor (id pelicula, idActor)
Hacer copia de seguridad: mysqldump -u root -p sakila film_actor > tablafilmactor.sql
DELETE FROM film_actor: DELETE FROM film_actor;
Recuperar datos: mysql -u root -p sakila < tablafilmactor.sql

# Creación de Usuarios

## Modificación de las contraseñas

- Podemos cambiar la contraseña del usuario que está conectado de la siguiente manera:

    - ALTER USER USER() IDENTIFIED BY 'asir';
        - Donde USER() nos devuelve el usuario conectado e IDENTIFIED BY '' es la nueva contraseña.
- Otra forma es con el comando mysqladmin (inseguro, no recomendado):
    - mysqladmin -u asir -p -h localhost password "1234"
- Con el siguiente comando:
    - SET PASSWORD FOR usuario2@localhost = 'hola';

EJERCICIOS:

Crear una base de datos con una tabla y un par de registros

1- Copia de seguridad de sakila y de la nueva base de datos creada.
2- Realizar una copia de sakila menos de la tabla de actor (actor) y peliculas (film).
3- Copia de seguridad de la tabla peliculas (film) de Sakila.
4- Creación de un usuario asociado a la máquina 192.168.10.40 con contraseña 4321 y que deba cambiar la contraseña cuando inicie sesión.
5- Creación de un usuario para cualquier máquina sin contraseña.
6- Creación de un usuario llamado asir para localhost con contraseña 1234 y con este usuario debemos probar a entrar en el sistema y comprobar cómo es la instrucción de creación de ese usuario.
7- Eliminación de todos los usuarios creados.
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
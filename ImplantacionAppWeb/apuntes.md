2 controles y 1 examen de evaluación. Los controles no quitan contenido. Examen 60%, controles 40% y los trabajos y ejercicios suman o restan 1 punto.

Correo de Antonio: antoniolopezninoperez@liceolapaz.net (otro correo: jton28@yahoo.es)

# TEMA 1: CONCEPTOS SOBRE APLICACIONES WEB (no título real del tema)

En toda aplicación web hay el cliente y el servidor (suministra la información)

Problemas: 
    - La información está en muchos sitios.
    - Deiseminación de la información
    - Traumas a la hora de hacer correcciones
    - La seguridad
    - Dificultad en las instalaciones personalizadas

Modelo de aplicación distribuída

Las máquinas a un segundo plano, lo importante es la conexión a Internet que es la que se utilizará para conectarse a la aplicación web.

Lo que mantiene a las máquinas activas son los sectores de multimedia y el sector videojuegos.

web vs escritorio

Plugin: Interconecta (buscar definición).

Hay que tener cuidado con la comopatibildiad entre las cosas, por ejemplo, la versión de PHP y la de los servidores.

## INSTALACIONES

Especificaciones de la máquina: 2 RAM y 30 de disco

nombre de la máquina: impweb18



Instalar GuestAdditions:

- sudo apt-get install virtualbox-guest-additions-iso

- Crear una carpeta, por ejemplo, en el escritorio para que sea fácilmente accesible. En "Dispositivos" insertamos la imagen de CD de las guest additions y copiamos todos los archivos del cd que se acaba de montar en la carpeta creada en el escritorio.

- Damos permisos a la carpeta: sudo chmod 777 -R /home/usuario/Escritorio/nombreCarpeta/*

- ejecutamos el archivo .run (nos desplazamos a la carpeta del escritorio): sudo ./VBoxLinuxAdditions.run

- Reiniciamos

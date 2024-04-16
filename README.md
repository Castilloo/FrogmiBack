# Resolución de prueba

- Esta aplicación está realizada en Ruby on rails en el Backend, Vuejs en el frontend y Postgresql para la base de datos.

### Backend

- Para persistir los datos mediante una task  ejecutar el comando:

~~~
    rails feature:get_data
~~~

Los endpoints que quedan expuestos son los siguientes:

Get 

- http://127.0.0.1:3000/api/features?page={page}&per_page={per_page}&mag_type%5B%5D={mgtype}%27

- http://127.0.0.1:3000/api/features

- http://127.0.0.1:3000/api/features/{id}/comments

Post
- http://127.0.0.1:3000/api/features/{id}/comments

### Base de datos

- La creación y configuración de la base de datos se encuentra en el docker file en la carpeta *creation_db*.

## Frontend

El proyecto frontend se encuentra en este link https://github.com/Castilloo/FrogmiFront

# ODIÓMETRO
---

Ya disponible en https://odiometro.es

Este es un proyecto que ayuda a medir el nivel de odio que se genera en Twitter en tiempo real.

El objetivo de este proyecto es hacernos conscientes del nivel de debate que se produce en España,
y el amplio uso de insultos, descalificaciones, etc. que se producen en Twitter. También recoge tweets de otros países hispanoparlantes.

La web hace uso de las siguientes tecnologías:
* NodeJS / Express
* Socket.io
* MySQL (if having problems, stick to 5.x; see [mysqljs#1962](https://github.com/mysqljs/mysql/pull/1962))
* VueJS
* SASS
* Grunt

## Instalación
---

1. Clonar el repositorio
```git clone git@github.com:ojoven/odiometro.git```

2. Desde la raíz del proyecto (instalará express, socket y otras librerías)

2. Desde la raíz del proyecto (instalará express, socket y otras librerías)
```npm install```

3. También desde la carpeta `/public` (instalará grunt y plugins, vue)
```cd public && npm install```

4. Crear una base de datos y configurar la aplicación para acceder a ella

4.2 Configure les credenciales de tu DB desde `/config/database_odiometro.json`; o `database_[dbname].pais.json`, si estás creando el odiómetro en tu país)

4.3 Importar el esquema a su base de datos
```mysql -u [username] -p [dbname] < db/app-schema.sql```

5. Configurar las credenciales de la [API de Twitter](https://developer.twitter.com/en/docs/twitter-api/getting-started/guide) en `/config/twitter_odiometro.json`

6. Corre el grunt desde */public*
```grunt```

7. Lanza la app
```node app.js```

8. Si has creado tu propia versión de país (o de otro estilo tipo amorómetro)
```node app.js [nombredebot]```. Alternativamente, configura la variable de sistema `APP_BOT_NAME`, en *.env*.


### IMPORTANTE
---
Tendrás que crear una app en Twitter y rellenar los datos de consumer key y secret, y access_token y secret en twitter_odiometro.json o twitter_odiometro.pais.json.

No sé bien cómo funciona la API de Twitter ahora, ya que estuvieron implementando bastantes restricciones que igual no afectan a apps antiguas pero sí a las nuevas. Si tienes algún problema o sabes cómo va, no dudes en escribir en las Issues.


## Notas adicionales de desarrollo
---

* Los componentes Vue del frontend se encuentran en `js/src/app/components`
* Otros archivos interesantes son:
    * bus.js -> Lo utilizamos como bus de eventos para emitir / recibir eventos
    * lib.js -> Una instancia Vue que nos sirve como librería de funciones (para funcionalidades compartidas entre componentes)
    * socket.js -> Simplemente inicializa socket.io en el frontend
    * store.js -> Una clase "store" donde almacenamos variables que serán compartidas por varios componentes
    * vue-instance.js -> Inicializa la instancia Vue principal
* en `vendor/smoothie.js` tenemos la librería que renderiza la gráfica en tiempo real
* si tienes sugerencias sobre cómo optimizar el código, hacerlo más legible, refactorizar, etc. las sugerencias y los pull requests son bienvenidos.



## Contacta
---
Si tienes alguna duda, sugerencia, crítica o palabra de odio, puedes contactarme en https://twitter.com/ojoven

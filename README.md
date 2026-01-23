# Recepción de Incidencias

El sistema deberá integrar la recepción de incidencias desde múltiples canales, utilizar Inteligencia Artificial (Gemini) para el triaje y la clasificación, interactuar con una base de datos (PostgreSQL) para la persistencia y el enriquecimiento de datos, y enrutar las tareas a diferentes colas de trabajo (RabbitMQ) según la lógica de negocio.




## Instalación

Clona el repositorio en el equipo

```bash
  git clone https://github.com/jaimeparra2402/INTEGRACION-DE-TECOLOGIAS.git
```

### Creación de un Fichero .env.n8n

Para el correcto funcionamiento del modelo es necesario crear un fichero .env.n8n siguiendo las especificaciones del [ejemplo](n8n/.env.example)

```env.n8n
RABBITMQ_HOST=incident-management-mq
RABBITMQ_PORT=5672
RABBITMQ_USER=guest

....   otras variables .....

MAIL_PASSWORD=applicationpassword
MAIL_HOST=smtp.gmail.com
```

Permitiendo configurar las credenciales que se emplearán en n8n

### Despliegue

Makefile que simplifica el proceso de despliegue en Docker
```bash
make help

"Comandos disponibles"
" make build                    - Construye la imagen o la baja"
" make up                       - Levanta los contenedores"
" make deploy                   - Construye y levanta la imagen"
" make down                     - Para los contenedores y los elimina"
" make stop                     - Para los contenedores"
" make rmvolume                 - Elimina el volumen de la BD"

```

Todo el entorno de desarrollo se realiza en el volumen de n8n_data, si ya se dispone de un volumen de n8n, simplemente puedes modificar el volumen en el fichero docker-compose.yml para poder hacer uso de tus credenciales.

Construimos nuestra imagen y construimos los contenedores.

```bash
make build
make up
```

## n8n

### Creación de credenciales

Para la creación de credenciales usando variables de entorno, ejemplo de Postgres Account

```
HOST(expression) = {{ $env.POSTGRES_HOST}}

DATABASE(expression) = {{ $env.POSTGRES_DB}}

USER(expression) = {{$env.POSTGRES_USER}}

PASSWORD(expression) = {{$env.POSTGRES_PASSWORD}}

PORT(expression) = {{$env.POSTGRES_PORT}}
```





## Autores

- Jaime Parra Jiménez 
- Alejandro Sánchez Rodríguez

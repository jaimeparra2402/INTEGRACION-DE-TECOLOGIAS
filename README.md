# Recepción de Incidencias

El sistema deberá integrar la recepción de incidencias desde múltiples canales, utilizar Inteligencia Artificial (Gemini) para el triaje y la clasificación, interactuar con una base de datos (PostgreSQL) para la persistencia y el enriquecimiento de datos, y enrutar las tareas a diferentes colas de trabajo (RabbitMQ) según la lógica de negocio.




## Instalación

Clona el repositorio en el equipo

```bash
  git clone https://github.com/jaimeparra2402/INTEGRACION-DE-TECOLOGIAS.git
```

### Creación de un Fichero .env

Para el correcto funcionamiento del modelo es necesario crear un fichero .env siguiendo las especificaciones del [ejemplo](.env.example)

```.env
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

### Configuración Workflow

1. En el workflow principal, hay que establecer el Workflow Error, por ello ...-> settings -> Error Workflow: se selecciona nuestro error workflow.
2. Una vez establecido el Error Workflow, para un correcto uso habría que activarlo.
3. Si quieres recibir el email, es necesario modificar en el Workflow de Sub-NotificacionCliente, en el nodo Send Mail y sustituir el mail_to por uno válido


### Ejemplo de uso

Para estos ejemplos se han utilizado los comandos definidos en [commands.txt](./commands.txt)

#### Caso 1: El cliente no existe

Al iniciar la base de datos PostgreSQL, no hay clientes registrados. Por lo tanto, al realizar una llamada al workflow principal, se activa el Error Workflow, devolviendo un mensaje de respuesta que indica que el cliente debe registrarse.

El error queda registrado en una tabla de Google Sheets.

#### Caso 2: Cliente registrado

Para crear un cliente, se ha utilizado un workflow auxiliar al que se le envían los datos necesarios para su creación.

Puede usarse el mismo Webhook del workflow principal, pero para ello es necesario desactivarlo temporalmente durante esta operación.
Como alternativa, se puede configurar un Webhook distinto para evitar conflictos y no modificar el workflow principal.

Una vez creado el cliente, se puede verificar el funcionamiento realizando una nueva llamada al workflow.


## Autores

- Jaime Parra Jiménez 
- Alejandro Sánchez Rodríguez

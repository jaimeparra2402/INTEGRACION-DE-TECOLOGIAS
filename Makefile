help:
	@echo "Comandos disponibles"
	@echo " make build			- Construye la imagen o la baja"
	@echo " make up 			- Levanta los contenedores"
	@echo " make deploy			- Construye y levanta la imagen"
	@echo " make down			- Para los contenedores y los elimina"
	@echo " make stop			- Para los contenedores"	
	@echo " make rmvolume  		- Elimina el volumen de la BD"

build:
	docker-compose -f docker-compose.yml build

up:
	docker-compose -f docker-compose.yml up -d

deploy:
	docker-compose -f docker-compose.yml up -d --build

down:
	docker-compose -f docker-compose.yml down

stop:
	docker-compose -f docker-compose.yml stop

rmvolume:
	docker volume rm proyecto_postgres_data
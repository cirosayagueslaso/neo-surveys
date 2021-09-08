build:
	docker build -t app .

run:
	docker-compose up -d

runit:
	docker-compose up -it

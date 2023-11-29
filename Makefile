makemigrations:
	pdm run manage.py makemigrations

migrate:
	pdm run manage.py migrate

collectstatic:
	pdm run manage.py collectstatic --noinput

runserver:
	pdm run manage.py runserver 0.0.0.0:8000

docker_up:
	docker compose up -d --build

docker_start:
	docker compose start

docker_stop:
	docker compose stop

docker_down:
	docker compose down
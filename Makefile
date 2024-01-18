# docker origin
.PHONY: docker_build_origin
# Сборка оригинального образа
docker_build_origin:
	docker build -t krddevdays-app:origin -f ./Dockerfile .

# docker + compose
.PHONY: docker_build docker_image_size docker_up docker_start docker_stop docker_down docker_reset
docker_build:
	docker build -t krddevdays-app:latest -f ./build/Dockerfile.app .
	docker build -t krddevdays-nginx:latest -f ./deploy/Dockerfile.nginx ./deploy

docker_image_size:
	docker image ls | grep krddevdays-app

docker_up:
	docker compose up -d

docker_start:
	docker compose start

docker_stop:
	docker compose stop

docker_down:
	docker compose down

docker_reset: docker_down docker_up

# minikube
.PHONY: mk8s_start mk8s_init mk8s_create mk8s_delete mk8s_stop
mk8s_start:
	minikube start

mk8s_init:
	minikube addons enable ingress
	minikube addons enable ingress-dns
	minikube addons enable registry

mk8s_dashboard:
	minikube dashboard --url

mk8s_create:
	@eval $$(minikube -p minikube docker-env) ;\
	docker build -t alex/krddevdays-app -f Dockerfile .
	kubectl create configmap krddevdays --from-env-file=.env
	kubectl create -f deploy

mk8s_delete:
	kubectl delete configmap krddevdays
	kubectl delete -f deploy

mk8s_stop:
	minikube stop

# pdm
.PHONY: lock install-dev
lock:
	pdm lock

install-dev:
	pdm sync

# django
.PHONY: makemigrations migrate collectstatic runserver
makemigrations:
	pdm run manage.py makemigrations

migrate:
	pdm run manage.py migrate

collectstatic:
	pdm run manage.py collectstatic --noinput

runserver:
	pdm run manage.py runserver 0.0.0.0:8000

.PHONY: build_origin image_size
# Сборка оригинального образа
build_origin:
	docker build -t krddevdays-app:origin -f ./Dockerfile .

image_size:
	docker image ls | grep krddevdays-app

.PHONY: build
# Сборка новой версии образа
build:
	docker build -t krddevdays-app:latest -f ./build/Dockerfile.app .
	docker build -t krddevdays-nginx:latest -f ./build/Dockerfile.nginx ./build

.PHONY: compose_up
compose_up:
	docker compose -f ./deploy/docker/docker-compose.yml up -d

# minikube
.PHONY: mk8s_init mk8s_start mk8s_create mk8s_delete mk8s_stop
mk8s_init:
	minikube start --driver=docker
	minikube addons enable ingress
	minikube addons enable ingress-dns
	minikube addons enable registry

mk8s_start:
	minikube start

mk8s_dashboard:
	minikube dashboard --url

mk8s_create:
	@eval $$(minikube -p minikube docker-env) ;\
	docker build -t alex/krddevdays-app -f ./build/Dockerfile.app .
	kubectl create configmap krddevdays --from-env-file=.env
	kubectl apply -f deploy

mk8s_apply:
	kubectl apply -f deploy

mk8s_delete:
	kubectl delete configmap krddevdays
	kubectl delete -f deploy

mk8s_stop:
	minikube stop
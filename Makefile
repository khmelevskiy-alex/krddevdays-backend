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

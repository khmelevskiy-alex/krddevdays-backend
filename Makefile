.PHONY: build_origin
# Сборка оригинального образа
build_origin:
	docker build -t krddevdays-app:origin -f ./Dockerfile .

image_size:
	docker image ls | grep krddevdays-app

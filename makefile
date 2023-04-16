SHELL := $(shell which zsh)

DOCKER_CURRENT_USER = -u $(shell id -u ${USER}):$(shell id -g ${USER})
CURRENT_DIR = -v ${PWD}:${PWD} -w ${PWD}

dotnet-sdk:
	docker run --rm -it ${CURRENT_DIR} mcr.microsoft.com/dotnet/sdk:6.0; sudo chown -R ${USER}:${USER} ${PWD}


DOCKER_TAG = dotnet-petstore

docker-build:
	docker build -t ${DOCKER_TAG} petstore

docker-stop:
	docker stop ${DOCKER_TAG} || true

docker-run: docker-stop docker-build
	docker run --rm -d -p 80:80 --name ${DOCKER_TAG} ${DOCKER_TAG}
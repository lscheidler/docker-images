DISTRIBUTION      := stretch
IMAGE_DATE        := $(shell date +"%Y%m%dT%H%M%S")

build: BASE_NAME=debian-$(DISTRIBUTION)-$(NAME)
build:
	docker build --build-arg LOCAL_REPOSITORY=$(LOCAL_REPOSITORY) --build-arg DISTRIBUTION=$(DISTRIBUTION) $(DOCKER_BUILD_ARGS) -t $(LOCAL_REPOSITORY):$(BASE_NAME)-latest -t $(LOCAL_REPOSITORY):$(BASE_NAME)-$(IMAGE_DATE) .

push: BASE_NAME=debian-$(DISTRIBUTION)-$(NAME)
push:
	echo docker tag $(LOCAL_REPOSITORY):$(BASE_NAME)-$(IMAGE_DATE) $(REMOTE_REPOSITORY):$(BASE_NAME)-$(IMAGE_DATE)
	echo docker push $(REMOTE_REPOSITORY):$(BASE_NAME)-$(IMAGE_DATE)
	echo docker tag $(LOCAL_REPOSITORY):$(BASE_NAME)-latest $(REMOTE_REPOSITORY):$(BASE_NAME)-latest
	echo docker push $(REMOTE_REPOSITORY):$(BASE_NAME)-latest

get:
	ansible-playbook ../get-resources.yml -e @resources.yml -e working_directory=$(shell pwd)

stretch: DISTRIBUTION=stretch
stretch: default

buster: DISTRIBUTION=buster
buster: default

default: build push

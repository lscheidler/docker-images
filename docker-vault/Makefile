all: buster
default: get build push

DISTRIBUTION := buster
NAME := vault

include ../Makefile.global-vars.mk
include ../Makefile.docker-rules.mk

clean:
	rm -rf volumes/data/vault-data

run: BASE_NAME=debian-buster-$(NAME)
run:
	docker run --privileged -it --rm=true -v ${PWD}/volumes/conf:/etc/vault -v ${PWD}/volumes/data:/data -p 8200:8200 $(LOCAL_REPOSITORY):$(BASE_NAME)-latest

run: BASE_NAME=debian-buster-$(NAME)
debug:
	docker run --privileged -it --rm=true -e LOGLEVEL=debug -v ${PWD}/volumes/conf:/etc/vault -v ${PWD}/volumes/data:/data -p 8200:8200 $(LOCAL_REPOSITORY):$(BASE_NAME)-latest

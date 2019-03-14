all: stretch-update

include ../Makefile.global-vars.mk

jessie-update:
	ansible-playbook update_image.yml -e local_repository=$(LOCAL_REPOSITORY) -e src_name=debian-jessie

stretch-update:
	ansible-playbook update_image.yml -e local_repository=$(LOCAL_REPOSITORY) -e src_name=debian-stretch

all: stretch

include ../Makefile.global-vars.mk

jessie:
	ansible-playbook create_base_image.yml -e local_repository=$(LOCAL_REPOSITORY) -e distribution=jessie

stretch:
	ansible-playbook create_base_image.yml -e local_repository=$(LOCAL_REPOSITORY) -e distribution=stretch

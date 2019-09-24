all: stretch

include ../Makefile.global-vars.mk

stretch: DISTRIBUTION=stretch
stretch: create-base-image

buster: DISTRIBUTION=buster
buster: create-base-image

create-base-image:
	ansible-playbook create_base_image.yml -e local_repository=$(LOCAL_REPOSITORY) -e distribution=$(DISTRIBUTION) -e force=true

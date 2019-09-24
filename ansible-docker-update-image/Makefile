all: stretch-update

include ../Makefile.global-vars.mk

stretch-update: DISTRIBUTION=stretch
stretch-update: update

buster-update: DISTRIBUTION=buster
buster-update: update

update:
	ansible-playbook update_image.yml -e local_repository=$(LOCAL_REPOSITORY) -e src_name=debian-$(DISTRIBUTION)

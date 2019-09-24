all: stretch tomcat7
default: get build push

NAME := service-wrapper

include ../Makefile.global-vars.mk
include ../Makefile.docker-rules.mk

tomcat7: DOCKER_BUILD_ARGS := --build-arg TOMCAT=tomcat7
tomcat7: override NAME := service-wrapper-tomcat7
tomcat7: override BASE_NAME := debian-$(DISTRIBUTION)-$(NAME)
tomcat7: default

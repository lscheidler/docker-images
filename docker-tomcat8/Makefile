all: stretch

NAME := tomcat8

include ../Makefile.global-vars.mk
include ../Makefile.docker-rules.mk

stretch: build push
jessie: build-jessie push-jessie
all: build push

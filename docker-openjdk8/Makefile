all: stretch

NAME := openjdk8

include ../Makefile.global-vars.mk
include ../Makefile.docker-rules.mk

JESSIE_DOCKERFILE := Dockerfile.jessie

stretch: build push
jessie: build-jessie push-jessie

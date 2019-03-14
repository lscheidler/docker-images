all: stretch

NAME := service-wrapper

include ../Makefile.global-vars.mk
include ../Makefile.docker-rules.mk

JESSIE_DOCKERFILE := Dockerfile.jessie

stretch: get build push
jessie: get build-jessie push-jessie

get:
	ansible-playbook get-newrelic-agent.yml

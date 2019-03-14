all: stretch

NAME := jmxtrans-agent

include ../Makefile.global-vars.mk
include ../Makefile.docker-rules.mk

stretch: get build push
jessie: get build-jessie push-jessie

get:
	ansible-playbook get-jmxtrans-agent.yml

all: stretch

NAME := nginx

include ../Makefile.global-vars.mk
include ../Makefile.docker-rules.mk

stretch: get build push
jessie: get build-jessie push-jessie

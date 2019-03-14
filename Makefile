all: stretch

stretch: stretch-update

stretch-base-image-update:
	make -C ansible-docker-update-image stretch-update

stretch-update:
	make -C docker-openjdk8
	make -C docker-jmxtrans-agent
	make -C docker-tomcat8
	make -C docker-service-wrapper
	make -C docker-nodejs
	make -C docker-ruby

jessie-base-image-update:
	make -C ansible-docker-update-image jessie-update

jessie-update:
	make -C docker-openjdk8 jessie
	make -C docker-jmxtrans-agent jessie
	make -C docker-tomcat7 jessie
	make -C docker-service-wrapper jessie

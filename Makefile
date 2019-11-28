all: stretch

buster: buster-update

buster-create-base-image:
	sudo -E make -C ansible-docker-base-image buster

buster-base-image-update:
	make -C ansible-docker-update-image buster-update

buster-update: DISTRIBUTION=buster
buster-update: update

stretch: stretch-update

stretch-create-base-image:
	sudo -E make -C ansible-docker-base-image stretch

stretch-base-image-update:
	make -C ansible-docker-update-image stretch-update

stretch-update: DISTRIBUTION=stretch
stretch-update: update

update:
	make -C docker-openjdk8
	make -C docker-jmxtrans-agent
	make -C docker-tomcat8
	make -C docker-service-wrapper
	make -C docker-nodejs
	make -C docker-ruby
	make -C docker-solr
	make -C docker-jar
	make -C docker-influxdb
	make -C docker-vault
	make -C docker-tomcat7
	make -C docker-service-wrapper tomcat7

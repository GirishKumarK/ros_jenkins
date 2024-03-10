# ----------------------------- DEFAULT ----------------------------- #

.ONESHELL:
.DEFAULT_GOAL := make

make:
	make setup-docker
	make setup-tty
	make setup-jenkins

# ------------------------------ BUILD ------------------------------ #

build:
	@docker pull osrf/ros:noetic-desktop-full-focal
	@docker build -t tortoisebot-ros1-gazebo ros1/gazebo/.
	# verify
	@docker images

clean:
	@docker rmi -f tortoisebot-ros1-gazebo
	# verify
	@docker images

# ------------------------------ SETUP ------------------------------ #

setup-docker:
	@sudo apt-get update
	@sudo apt-get install -y docker.io docker-compose
	@sudo service docker start
	@xhost +local:root

setup-tty:
	@echo cd ${PWD}
	@sudo service docker start
	@sudo usermod -aG docker ${USER}
	@newgrp docker

setup-jenkins:
	@./start_jenkins.sh
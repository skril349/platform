#!/bin/bash
echo "Chose your installation option (Update System first):"
options=("Update System" "Install Docker" "Quit")
select opt in "${options[@]}"
do
	case $opt in
		"Update System")
			sudo apt-get update -y
			sudo apt-get upgrade -y
			echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
			;;
		"Install Docker")
			sudo apt install apt-transport-https ca-certificates curl software-properties-common
			curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
			sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
			sudo apt update -y
			apt-cache policy docker-ce
			sudo apt install docker-ce
			sudo usermod -aG docker $(whoami)
			su - $(whoami)
			docker -v
			;;
		"Quit")
			break
			;;
		*) echo "invalid option $REPLY";;
	esac
done

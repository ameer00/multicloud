#!/bin/bash

echo -e "\n>>>>> Authorizing docker via gcloud"
gcloud docker -a

echo -e "\n>>>>> Running your Cloud Tools Container as cloud-tools"
docker run -d --name cloud-tools -h cloud-tools -v /var/run/docker.sock:/var/run/docker.sock -v $HOME/multicloud:/root/multicloud gcr.io/cloud-tools-201201/cloud-tools tail -f /dev/null

echo -e "\n>>>>> Getting you a session into your running container, and your'e ready to rock! Happy hacking!"
docker exec -it cloud-tools bash


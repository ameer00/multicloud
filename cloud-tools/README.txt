This container image provides the following tools:

* kubectl
* kubectx
* kubens
* kops
* aws
* helm

Additionally, you have the following scripts for convenience that are highly recommended for use with this container image. They have been created to remove the need for more complex docker commands:

* gcloud-init.sh -- this is a script that is more for the purposes of using inside the running container, and has already been placed in the image for you
* start-cloud-tools.sh -- this is a script that will pull the docker image and start it up appropriately for you. It will drop you into a bash session within the container once it is done.
* enter-cloud-tools.sh -- this script will re-enter you into your running cloud-tools container

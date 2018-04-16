#!/bin/bash

if [[ -z "${DEVSHELL_PROJECT_ID}" ]]; then
    echo ">>>>> Initializing gcloud with your credentials (assumed to be in $HOME)"
    echo -e "\n>>>>> Enter the name of your credential key: "
    read credentialkeyfile
    gcloud auth activate-service-account --key-file=$HOME/multicloud/$credentialkeyfile
fi

echo "You'll want to now run 'gcloud config set project <project ID>'"

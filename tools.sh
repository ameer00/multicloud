#!/bin/bash

# Install kubectx/kubens
cd $HOME
mkdir bin
PATH=$PATH:$HOME/bin/
sudo git clone https://github.com/ahmetb/kubectx $HOME/kubectx
sudo ln -s $HOME/kubectx/kubectx $HOME/bin/kubectx
sudo ln -s $HOME/kubectx/kubens $HOME/bin/kubens

# Install Helm
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh

# Install aws CLI
pip install awscli --upgrade --user

# Install kops
wget https://github.com/kubernetes/kops/releases/download/1.9.1/kops-linux-amd64
chmod +x kops-linux-amd64
mv kops-linux-amd64 ~/bin/kops
PATH=$PATH:$HOME/.local/bin/

# Install the hey tool
go get -u github.com/rakyll/hey

# Install terrform
wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip
unzip terraform_0.11.7_linux_amd64.zip
mv terraform ~/.local/bin
rm terraform_0.11.7_linux_amd64.zip

# Install kube ps1
git clone https://github.com/jonmosco/kube-ps1.git
echo 'source $HOME/kube-ps1/kube-ps1.sh' >> ~/.bashrc
export VAR="PS1='[\W \$(kube_ps1)]\$ '"
echo $VAR >> ~/.bashrc
source $HOME/.bashrc

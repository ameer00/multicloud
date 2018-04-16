FROM centos:latest


RUN echo $'[google-cloud-sdk] \n\
name=Google Cloud SDK \n\
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64 \n\
enabled=1 \n\
gpgcheck=1 \n\
repo_gpgcheck=1 \n\
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg \n\
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg' >> /etc/yum.repos.d/google-cloud-sdk.repo && \
 yum --enablerepo=extras install -y epel-release && \
 yum -y update && \
 yum install -y wget which openssl python-pip && \
 pip install --upgrade pip && \
 yum install -y google-cloud-sdk && \
 yum install -y bind-utils && \
 yum install -y gettext && \
 yum install -y docker && \
 yum install -y kubectl git && \
 curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh && \
 chmod 700 get_helm.sh && \
 ./get_helm.sh && \
 mkdir -p ~/.local/bin && \
 pip install awscli --upgrade --user && \
 wget https://github.com/kubernetes/kops/releases/download/1.8.0/kops-linux-amd64 && \
 chmod +x kops-linux-amd64 && \
 mv kops-linux-amd64 kops && \
 mv kops /usr/local/bin && \
 ln -s ~/.local/bin/aws /usr/local/bin/aws && \
 curl -L https://git.io/getLatestIstio | sh - && \
 mv istio-*/bin/istioctl /usr/local/bin && \
 wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx && \
 wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens && \
 chmod +x kubectx && \
 chmod +x kubens && mv kubectx /usr/local/bin && \
 mv kubens /usr/local/bin && \
 echo 'PS1="\[\u | \$(kubectl config current-context):\$(kubectl config view --minify --output 'jsonpath={..namespace}') | \[\e[31m\]\W\[\e[m\] \\$ "' >> /root/.bashrc

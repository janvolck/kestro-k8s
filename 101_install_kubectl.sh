# install kubectl
if [ -z $(which kubectl) ]; then
    sudo snap install kubectl --classic
fi

# install helm
if [ -z $(which helm) ]; then
    sudo snap install helm --classic
fi

# enable bash completion, no comments needed
if [ ! -e /etc/bash_completion.d/kubectl ]; then
    mkdir -p bash_completion.d
    kubectl completion bash > bash_completion.d/kubectl
    sudo mv bash_completion.d/kubectl /etc/bash_completion.d
fi

# enable bash completion, no comments needed
if [ ! -e /etc/bash_completion.d/helm ]; then
    mkdir -p bash_completion.d
    helm completion bash > bash_completion.d/helm
    sudo mv bash_completion.d/helm /etc/bash_completion.d
fi


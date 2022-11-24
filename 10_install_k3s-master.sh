# install k3s
# disable built-in traefik in order to work with latest version of traefik or nginx
# disable built-in flannel in order to link multus to flannel
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --disable servicelb --disable traefik --flannel-backend=none --node-ip=192.168.100.50" sh -s -
sudo touch /var/lib/rancher/k3s/server/manifests/traefik.yaml.skip

# copy k3s yaml to .kube/config and change access rights 
# so that we can connect to kubelet via kubectl without permission issues
if [ ! -e $HOME/.kube/config ]; then
    mkdir -p $HOME/.kube
    sudo cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/config
    sudo chown `whoami`:`whoami` $HOME/.kube/config
fi

export KUBECONFIG="$HOME/.kube/config"

# enable bash completion, no comments needed
if [ ! -e /etc/bash_completion.d/kubectl ]; then
    mkdir -p bash_completion.d
    kubectl completion bash > bash_completion.d/kubectl
    sudo mv bash_completion.d/kubectl /etc/bash_completion.d/
fi

# install flannel as default cni for multus
kubectl apply -f configs/kube-flannel.yml

# install cni-plugins
sudo mkdir -p /opt/cni/bin

# install cni-plugins
architecture=$(uname -m)
cni_version="v1.1.1"
cni_plugins=""


case $architecture in

    aarch64)
        cni_plugins="cni-plugins-linux-arm64-${cni_version}.tgz"
        ;;

    armv7l)
        cni_plugins="cni-plugins-linux-arm-${cni_version}.tgz"
        ;;
    
    *)
        cni_plugins="cni-plugins-linux-amd64-${cni_version}.tgz"
        ;;
esac

wget https://github.com/containernetworking/plugins/releases/download/${cni_version}/${cni_plugins}

sudo tar xvf ${cni_plugins} -C /opt/cni/bin
rm ${cni_plugins}


# enable cni dhcp daemon
sudo cp configs/cni-dhcp-daemon.service /etc/systemd/system
sudo systemctl enable cni-dhcp-daemon.service --now

# install helm
if [ -z $(which helm) ]; then
    # wget https://get.helm.sh/helm-v3.0.2-linux-arm.tar.gz
    # tar -zxvf  helm-v3.0.2-linux-arm.tar.gz
    wget https://get.helm.sh/helm-v3.8.0-linux-arm64.tar.gz    
    tar -zxvf helm-v3.8.0-linux-arm64.tar.gz
    sudo mv linux-arm64/helm /usr/local/bin/
    rm -rf linux-arm64 helm-v3.8.0-linux-arm64.tar.gz
fi

#install kubernetes web UI

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml

echo "K3S_TOKEN: "
sudo cat /var/lib/rancher/k3s/server/node-token
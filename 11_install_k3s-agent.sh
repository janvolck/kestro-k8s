# install k3s
# disable built-in traefik in order to work with latest version of traefik or nginx
# disable built-in flannel in order to link multus to flannel

token=$(ssh pi@rpi4-k8s-master -- sudo cat /var/lib/rancher/k3s/server/node-token)
curl -sfL https://get.k3s.io | K3S_URL=https://rpi4-k8s-master.kestro.home:6443 K3S_TOKEN=$token sh -

# enable bash completion, no comments needed
if [ ! -e /etc/bash_completion.d/kubectl ]; then
    mkdir -p bash_completion.d    
    kubectl completion bash > bash_completion.d/kubectl
    sudo mkdir -p /etc/bash_completion.d
    sudo mv bash_completion.d/kubectl /etc/bash_completion.d/
fi

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

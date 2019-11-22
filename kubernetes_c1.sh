
#Install KubeAdmin

https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/


sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

export KUBECONFIG=/etc/kubernetes/admin.conf


#Comandi su Master Calico Network

kubeadm init  --pod-network-cidr=192.168.0.0/16 --apiserver-advertise-address=192.168.57.10
export KUBECONFIG=/etc/kubernetes/admin.conf
kubectl apply -f https://docs.projectcalico.org/v3.8/manifests/calico.yaml
kubectl get pods --all-namespaces

# node1
kubeadm join 192.168.57.10:6443 --token h07t6b.6n88rpl6zn5lkbjs \
    --discovery-token-ca-cert-hash sha256:5082088e8684d6501af525dc65cafe3300ca8776ab36cf928977b6f9a768c794

# node2

kubeadm join 192.168.57.10:6443 --token h07t6b.6n88rpl6zn5lkbjs \
    --discovery-token-ca-cert-hash sha256:5082088e8684d6501af525dc65cafe3300ca8776ab36cf928977b6f9a768c794


# Master dopo il riavvio
sudo cp /etc/kubernetes/admin.conf $HOME/
sudo chown $(id -u):$(id -g) $HOME/admin.conf
export KUBECONFIG=$HOME/admin.conf


#Da utilizzare per fare join su nodi


kubeadm reset


#Comandi su Master flannel Network

sudo kubeadm init --pod-network-cidr=192.168.0.0/16
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

sudo iptables -A INPUT -m state --state NEW -m udp -p udp --dport 8285 -j ACCEPT
sudo iptables -A INPUT -m state --state NEW -m udp -p udp --dport 8472 -j ACCEPT
kubeadm init --pod-network-cidr=10.244.0.0/16
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/2140ac876ef134e0ed5af15c65e414cf26827915/Documentation/kube-flannel.yml
kubectl get pods --all-namespaces

kubeadm join 192.168.2.115:6443 --token p5up3v.x1tjprx0h9ugmuww \
    --discovery-token-ca-cert-hash sha256:54e6210d1d59aa853775ee8e28e3f61ddb7f2a5db686e656efd491c12348c511





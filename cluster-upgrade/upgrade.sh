package_update(){
  if [ -z "$1" ]; then
    echo "Usage: package_upgrade <version>"
    echo "Version in the format '<Major>:<Minor>' and NOT to include patch. v is already prefixed in the script"
    return 1
  fi
  VERSION=$1
  echo $VERSION
  echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v$VERSION/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
  curl -fsSL https://pkgs.k8s.io/core:/stable:/v$VERSION/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
  sudo apt-get update
}

get_kubeadm_upgrade_versions(){
  sudo apt update
  sudo apt-cache madison kubeadm
}

kubeadm_upgrade(){
  # Check if the version is provided
  if [ -z "$1" ]; then
    echo "Usage: kubeadm_upgrade <version>"
    return 1
  fi

  VERSION=$1
  echo $VERSION
  sudo apt-mark unhold kubeadm && \
  sudo apt-get update && sudo apt-get install -y kubeadm=$VERSION && \
  sudo apt-mark hold kubeadm
}

kubelet_upgrade(){
  # Check if the version is provided
  if [ -z "$1" ]; then
    echo "Usage: kubelet_upgrade <version>"
    return 1
  fi

  VERSION=$1
  echo $VERSION
  sudo apt-mark unhold kubelet kubectl && \
  sudo apt-get update && sudo apt-get install -y kubelet=$VERSION kubectl=$VERSION && \
  sudo apt-mark hold kubelet kubectl
  sudo systemctl daemon-reload
  sudo systemctl restart kubelet
}

worker_upgrade(){
kubeadm upgrade node
echo "Next run 'kubelet_upgrade <VERSION>'"
}

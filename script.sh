alias kg="k get"
alias kd="k describe"
alias kr="k run"
alias kcr="k create"
alias ka="k apply -f"
alias krm="k delete"
alias k="k "
alias kn="k config set-context --current --namespace"
export dry="--dry-run=client -o yaml"
alias watchall="watch -n0 kubectl get all,secret,cm,netpol,pvc -o wide --show-labels"
alias watchns="watch -n0 kubectl get ns --show-labels"
alias watchnodes="watch -n0 kubectl get no --show-labels"
alias watchpv="watch -n0 kubectl get pv --show-labels"
alias watchcontext="watch -n0 kubectl config get-contexts"
alias kevent="kubectl get ev -A -w"
set_context(){
 if [ -z "$1" ]; then
    echo "Usage: set_context <namespace>"
    return 1
  fi

  NAMESPACE=$1
  kubectl config set-context --current --namespace "$NAMESPACE"
}
debug() {
  # Check if the namespace is provided
  if [ -z "$1" ]; then
    echo "Usage: debug <namespace>"
    return 1
  fi

  NAMESPACE=$1

  # Run the kubectl command with the provided namespace
  kubectl run temp --rm -it --image nginx:alpine --restart Never --namespace "$NAMESPACE" -- sh
}

execpod() {
  # Check if the namespace is provided
  if [ -z "$1" ]; then
    echo "Usage: execpod <namespace> <podname>"
    return 1
  fi
  #Checf if the pod name is provided
  if [ -z "$2" ]; then
    echo "Usage: execpod <namespace> <podname>"
    return 1
  fi

  NAMESPACE=$1
  PODNAME=$2

  # Run the kubectl command with the provided namespace
  kubectl exec "PODNAME" -it --namespace "$NAMESPACE" -- sh
}

alias k=kubectl
export now="--now=true"
alias hosts="cat /etc/hosts"
alias os="cat /etc/*release*"
alias debugwget="echo wget -O- -T 2 <target host>"
alias debugcurl="echo curl --connect-timeout 2 <target host>"
alias debugnc="echo nc -w 2 <target destination> <target port>"


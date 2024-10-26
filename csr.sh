csr_req(){
  if [ -z "$1" ]; then
    echo "Usage: csr_req <path>"
    return 1
  fi
  FILE=$1
  echo $FILE

  encoded=$(cat $FILE | base64 | tr -d "\n")

cat << EOF 
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: myuser
spec:
  request: $encoded
  signerName: kubernetes.io/kube-apiserver-client
  expirationSeconds: 86400  # one day
  usages:
  - client auth
EOF
}

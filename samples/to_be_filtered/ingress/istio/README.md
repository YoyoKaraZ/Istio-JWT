
### Istio installation
istioctl install

### Installation of the test service
kubectl apply -f samples/httpbin/httpbin.yaml -n httpbin

### Get the IP for the apps that we will ping through the isitio ingress gateway
source GATEWAY.sh
kubectl apply -f httpbin_ingress.yaml

### Next : JWT

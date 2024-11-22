
```shell
minikube start --memory=16384 --cpus=4
minikube dashboard
minikube addons enable ingress
kubectl apply -f dashboard-ingress.yaml
kubectl get ingress -n kubernetes-dashboard
```

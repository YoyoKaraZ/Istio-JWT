
```shell
minikube start --memory=16384 --cpus=4
minikube dashboard
minikube addons enable ingress
kubectl apply -f dashboard-ingress.yaml
kubectl get ingress -n kubernetes-dashboard
```

Paste it in ```/etc/hosts```, like for example
```shell
192.168.39.239 dashboard.com
```

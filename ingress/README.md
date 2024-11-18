minikube addons enable ingress
kubectl apply -f dashboard-ingress.yaml
kubectl get ingress -n kubernetes-dashboard

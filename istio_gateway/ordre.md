ne pas oublier de rajouter les liens dans le /etc/hosts
# Comment les récupérer :
lancer le load balancer : minikube tunnel
récupérer l'external ip de l'ingressgateway : k get svc -n istio-system

laisser tourner minikube tunnel en fond, qui donnera une external ip et ermettra de faire le loadbalancing


up le service

creer le gateway ainsi que le virtualservice qui permerts de conserver le endpoint
 ajouter le istio-injection enabled


k create ns httpbin
kubectl label namespace httpbin istio-injection=enabled
k apply -f httpbin.yaml -n httpbin
k apply -f httpbin_gateway.yaml -n httpbin


k create ns curl
kubectl label namespace curl istio-injection=enabled
k apply -f curl.yaml -n curl

export CURL_POD=$(kubectl get pod -l app=curl -n curl -o jsonpath={.items..metadata.name})
k exec -it $CURL_POD -n curl -c curl -- curl http://httpbin.httpbin:8000


# Apparté : pour faire des tests manuels sur curl 
k exec -it $CURL_POD -n curl -c curl -- "/bin/sh"
while true; do curl http://httpbin.httpbin:8000 >/dev/null; sleep 1; done


# Mettre en place Kiali

k apply -f grafana.yaml
k apply -f prometheus.yaml
k apply -f kiali.yaml
k apply -f kiali_gateway.yaml -n istio-system # IMPORTANT : mettre le -n pour spécifier le namespace dans lequel est déployé le service que l'on veux exposer


# Activer la sécurité sur la liaison

k apply -f force_mtls.yaml

# Maintenant on va mieux manipuler les Requestsauthentication


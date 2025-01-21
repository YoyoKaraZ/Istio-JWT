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

## Moyen de le tester

kubectl exec $(kubectl get pod -l app=curl -n curl -o jsonpath={.items..metadata.name}) -n curl -c istio-proxy -- curl http://httpbin.httpbin:8000/ -o /dev/null -s -w '%{http_code}\n'  

Cette commande doit renvoyer une erreur 56, la ou elle fonctionnais avant, elle renvoyais 200



# Maintenant on va mieux manipuler les Requestsauthentication
# Pour le système de JWT


WORKING  
ALORS COMMENT J'AI FAIT


Merci le lien https://istiobyexample.dev/jwt/

## Applqiuer une requestAuthentication pour valider un token en particulier :

k apply -f request_authentication.yaml

## Ensuite, nous devons configurer une authorizationPolicy, qui s'assureras que toutes les requpetes ont un JWT, en rejetant les requetes qyu n'en ont pas, en retournant une erreur 403  

k apply -f authorizationpolicy.yaml

TOKEN=$(curl https://raw.githubusercontent.com/istio/istio/release-1.24/security/tools/jwt/samples/demo.jwt -s) && echo "$TOKEN" | cut -d '.' -f2 - | base64 --decode

kubectl exec $(kubectl get pod -l app=curl -n curl -o jsonpath={.items..metadata.name}) -n curl -c istio-proxy -- curl http://httpbin.httpbin:8000/ -o /dev/null --header "Authorization: Bearer $TOKEN" -s -w '%{http_code}\n'


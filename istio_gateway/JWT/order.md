# on commence par enforce le mtls of course

k apply -f enforce_jwt.yaml


# après ca, on va gérerer des clés nous permettant de génerer un token, on le retrouvera dans : generate_keys.sh

# générons les token avec generate_jwt_token.py


# après on va créer la requestauthentication via create_policy.yaml

k apply -f policy_creation.yaml



# Test de la policy

on a stocké le bon JWT dans tokens/token_based_on_private.jwt

export TOKEN="eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ5b3lvQHlveW8uY29tIiwic3ViIjoiYWRtaW4iLCJleHAiOjE2ODU1MDUwMDF9.kZocJBqK1oEi8NVnjbMT0KT2nfV9kFziBdYjbwA6LLJI8PF4VNipeWhvv4dkuFlKWHbZPsm7OE6Bp_FK2An_vuxpwD7zycZTngo2cszRuROK7gF4lB8Lpq4xlggqONrhhl0cyuPAVuI6BL8Z4V6Wb6_I-fBzvLSXSM9uOTKXDJVzfRG8kiIixpXkiOFW5Sg1qf1Z6GU4iTh0e70U4CsEqi5NU2Q_GlQeC1C8fpnrO10xaSpJLhdzFGYax3bCsO6JMUuwTy6UTf8zyKCeO6vni3LOQEQqgyxT4xrBzlG-LF26WGbmbmpaR1m7rmc81Yz_frwWCHbKn2mdiYBOxcb97A"

comme tout a l'heure, on refait sauf qu'on spécifie le token cette fois 



kubectl exec $(kubectl get pod -l app=curl -n curl -o jsonpath={.items..metadata.name}) -n curl -c istio-proxy -- curl http://httpbin.httpbin:8000/ -o /dev/null --header "Authorization: Bearer $TOKEN" -s -w '%{http_code}\n'  



# ON A UN SOUCIS 

je n'arrive pas a passer le mTLS que j'ai activé via le force_mtls

le système de token ne fonctionne pas
wtf

kubectl exec $(kubectl get pod -l app=curl -n curl -o jsonpath={.items..metadata.name}) -n curl -c istio-proxy -- curl http://httpbin.httpbin:8000/ -o /dev/null --header "Authorization: Bearer $TOKEN" -s -w '%{http_code}\n'

kubectl exec $(kubectl get pod -l app=productcatalogservice -o jsonpath={.items..metadata.name}) -c istio-proxy -- curl  http://frontend:80/ -o /dev/null --header "Authorization: Bearer $TOKEN" -s -w '%{http_code}\n'


OKAY CA MARCHE

Avec cette ligne 

kubectl exec $(kubectl get pod -l app=curl -n curl -o jsonpath={.items..metadata.name}) -n curl -- curl http://httpbin.httpbin:8000/ -o /dev/null --header "Authorization: Bearer $TOKEN" -s -w '%{http_code}\n'



k apply -f authorizationpolicy.yaml
k apply -f request_authentication.yaml
TOKEN=$(curl https://raw.githubusercontent.com/istio/istio/release-1.24/security/tools/jwt/samples/demo.jwt -s) && echo "$TOKEN" | cut -d '.' -f2 - | base64 --decode
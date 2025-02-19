# Commande de reference : 

kubectl exec $(kubectl get pod -l app=curl -n curl -o jsonpath={.items..metadata.name}) -n curl -- curl http://httpbin.httpbin:8000/ -o /dev/null --header "Authorization: Bearer $TOKEN" -s -w '%{http_code}\n'

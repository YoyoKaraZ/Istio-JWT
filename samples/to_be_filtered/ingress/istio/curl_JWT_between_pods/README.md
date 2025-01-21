### Curl Injection


kubectl apply -f <(istioctl kube-inject -f samples/httpbin/httpbin.yaml) -n httpbin
kubectl apply -f <(istioctl kube-inject -f samples/curl/curl.yaml) -n httpbin
kubectl exec "$(kubectl get pod -l app=curl -n httpbin -o jsonpath={.items..metadata.name})" -c curl -n httpbin -- curl http://httpbin.httpbin:8000/ip -sS -o /dev/null -w "%{http_code}\n"

### Enable only with valid JWT

k apply -f enable_only_jwt.yaml

### Test : this is rejected
kubectl exec "$(kubectl get pod -l app=curl -n foo -o jsonpath={.items..metadata.name})" -c curl -n foo -- curl "http://httpbin.foo:8000/headers" -sS -o /dev/null -H "Authorization: Bearer invalidToken" -w "%{http_code}\n"

### The requests without JWT will pass
### Require JWT

k apply -f require_jwt.yaml

### Now the last test won't passe
### you need a good JWT
### Test :

TOKEN=$(curl https://raw.githubusercontent.com/istio/istio/release-1.24/security/tools/jwt/samples/demo.jwt -s) && echo "$TOKEN" | cut -d '.' -f2 - | base64 --decode
kubectl exec "$(kubectl get pod -l app=curl -n httpbin -o jsonpath={.items..metadata.name})" -c curl -n httpbin -- curl "http://httpbin.httpbin:8000/headers" -sS -o /dev/null -H "Authorization: Bearer $TOKEN" -w "%{http_code}\n"


### Allow claim groups so only group1 is allowed

k apply -f allow_group_claim.yaml

### Tests for this last part

TOKEN_GROUP=$(curl https://raw.githubusercontent.com/istio/istio/release-1.24/security/tools/jwt/samples/groups-scope.jwt -s) && echo "$TOKEN_GROUP" | cut -d '.' -f2 - | base64 --decode

#### This one should work
kubectl exec "$(kubectl get pod -l app=curl -n httpbin -o jsonpath={.items..metadata.name})" -c curl -n httpbin -- curl "http://httpbin.httpbin:8000/headers" -sS -o /dev/null -H "Authorization: Bearer $TOKEN_GROUP" -w "%{http_code}\n"

#### This one should not work

kubectl exec "$(kubectl get pod -l app=curl -n httpbin -o jsonpath={.items..metadata.name})" -c curl -n httpbin -- curl "http://httpbin.httpbin:8000/headers" -sS -o /dev/null -H "Authorization: Bearer $TOKEN" -w "%{http_code}\n"


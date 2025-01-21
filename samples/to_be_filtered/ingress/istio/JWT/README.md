
## Create the gateway + Test ping
kubectl apply -f samples/httpbin/httpbin-gateway.yaml -n httpbin
curl "$INGRESS_HOST:$INGRESS_PORT/headers" -s -o /dev/null -w "%{http_code}\n"

## Enable the JWT Check
k apply -f enable_jwt.yaml

### At this point, you can 200 either with a good JWT, or without any
### Test

curl "$INGRESS_HOST:$INGRESS_PORT/headers" -s -o /dev/null -w "%{http_code}\n"
curl --header "Authorization: Bearer deadbeef" "$INGRESS_HOST:$INGRESS_PORT/headers" -s -o /dev/null -w "%{http_code}\n"
TOKEN=$(curl https://raw.githubusercontent.com/istio/istio/release-1.24/security/tools/jwt/samples/demo.jwt -s)
curl --header "Authorization: Bearer $TOKEN" "$INGRESS_HOST:$INGRESS_PORT/headers" -s -o /dev/null -w "%{http_code}\n"



### Testing phase
TOKEN=$(python3 ./gen-jwt.py ./key.pem --expire 5)
for i in $(seq 1 10); do curl --header "Authorization: Bearer $TOKEN" "$INGRESS_HOST:$INGRESS_PORT/headers" -s -o /dev/null -w "%{http_code}\n"; sleep 10; done


### Require a valid Token
k apply -f require_valid_token.yaml


### Test
curl --header "Authorization: Bearer $TOKEN" "$INGRESS_HOST:$INGRESS_PORT/headers" -s -o /dev/null -w "%{http_code}\n"

### Next : Curl_JWT_between_pods

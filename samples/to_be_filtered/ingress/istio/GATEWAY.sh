export INGRESS_NS=istio-system

export INGRESS_NAME=istio-ingressgateway

export INGRESS_PORT=$(kubectl -n "${INGRESS_NS}" get service "${INGRESS_NAME}" -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')

export INGRESS_HOST=$(kubectl get po -l istio=ingressgateway -n "${INGRESS_NS}" -o jsonpath='{.items[0].status.hostIP}')

export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT

echo GATEWAY_URL=$GATEWAY_URL

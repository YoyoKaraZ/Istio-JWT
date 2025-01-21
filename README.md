# Istio and Minikube Deployment Guide

This README provides a step-by-step guide to setting up an Istio environment on Minikube, deploying services, enabling mTLS, configuring JWT authentication, and testing the setup.

---

## Prerequisites

- Minikube installed and running
- Istio installed and configured
- Access to `kubectl` CLI

---

## 1. Setting Up Load Balancer

### Steps:
1. Start the Minikube tunnel:
   ```bash
   minikube tunnel
   ```

2. Get the external IP of the Istio ingress gateway:
   ```bash
   kubectl get svc -n istio-system
   ```

3. Keep the `minikube tunnel` running to maintain access to the external IP.

---

## 2. Deploying Services

### Deploy the `httpbin` Service
```bash
kubectl create namespace httpbin
kubectl label namespace httpbin istio-injection=enabled
kubectl apply -f httpbin.yaml -n httpbin
kubectl apply -f httpbin_gateway.yaml -n httpbin
```

### Deploy the `curl` Service
```bash
kubectl create namespace curl
kubectl label namespace curl istio-injection=enabled
kubectl apply -f curl.yaml -n curl
```

### Test Connectivity

1. Export the Pod name for `curl`:
   ```bash
   export CURL_POD=$(kubectl get pod -l app=curl -n curl -o jsonpath={.items..metadata.name})
   ```

2. Perform an HTTP request to `httpbin`:
   ```bash
   kubectl exec -it $CURL_POD -n curl -c curl -- curl http://httpbin.httpbin:8000
   ```

3. To continuously send requests:
   ```bash
   kubectl exec -it $CURL_POD -n curl -c curl -- /bin/sh
   while true; do curl http://httpbin.httpbin:8000 >/dev/null; sleep 1; done
   ```

---

## 3. Deploying Monitoring Tools (Kiali, Grafana, Prometheus)

### Apply Configurations:
```bash
kubectl apply -f grafana.yaml
kubectl apply -f prometheus.yaml
kubectl apply -f kiali.yaml
kubectl apply -f kiali_gateway.yaml -n istio-system
```

Access Kiali using the External IP from the ingress gateway.

---

## 4. Enabling Mutual TLS (mTLS)

### Steps:
1. Enable mTLS across namespaces:
   ```bash
   kubectl apply -f force_mtls.yaml
   ```

2. Verify the setup:
   ```bash
   kubectl exec $(kubectl get pod -l app=curl -n curl -o jsonpath={.items..metadata.name}) -n curl -c istio-proxy -- curl http://httpbin.httpbin:8000/ -o /dev/null -s -w '%{http_code}\n'
   ```

   Expect HTTP error code `56` to confirm non-secured connections are blocked. Before enabling mTLS, the response should have been `200`.

---

## 5. Configuring JWT Authentication

### RequestAuthentication

1. Apply a `RequestAuthentication` policy:
   ```bash
   kubectl apply -f request_authentication.yaml
   ```

2. Configure an `AuthorizationPolicy` to enforce JWT verification:
   ```bash
   kubectl apply -f authorizationpolicy.yaml
   ```

3. Fetch a demo JWT token:
   ```bash
   TOKEN=$(curl -s https://raw.githubusercontent.com/istio/istio/release-1.24/security/tools/jwt/samples/demo.jwt)
   ```

4. Test with the token:
   ```bash
   kubectl exec $(kubectl get pod -l app=curl -n curl -o jsonpath={.items..metadata.name}) -n curl -c istio-proxy -- curl http://httpbin.httpbin:8000/ --header "Authorization: Bearer $TOKEN" -s -o /dev/null -w '%{http_code}\n'
   ```

   Expect a `200` response for valid tokens.

---

## 6. Useful Resources

- [Istio Official Documentation](https://istio.io/latest/docs/)
- [JWT in Istio by Example](https://istiobyexample.dev/jwt/)

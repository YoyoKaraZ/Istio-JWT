# JWT Authentication with Istio

This guide provides step-by-step instructions for setting up JWT authentication in Istio, generating tokens, and testing the configuration.

---

## 1. Enforce mTLS

To start, enforce mutual TLS (mTLS):
```bash
kubectl apply -f ../mTLS/force_mtls.yaml
```

---

## 2. Generate Keys and Tokens

### Steps:
1. **Generate keys** for token creation using the `generate_keys.sh` script.
2. Use the `generate_jwt_token.py` script to generate the required tokens.

The generated keys and tokens will be stored in the appropriate directories for later use.

---

## 3. Configure RequestAuthentication

### Create the RequestAuthentication policy:
```bash
kubectl apply -f request_authentication.yaml
```

---

## 4. Test the Policy

### Using the Provided Token
A valid JWT is stored in `tokens/token_based_on_private.jwt`. Export it as an environment variable:
```bash
export MY_TOKEN="eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ5b3lvQHlveW8uY29tIiwic3ViIjoiYWRtaW4iLCJleHAiOjE2ODU1MDUwMDF9.kZocJBqK1oEi8NVnjbMT0KT2nfV9kFziBdYjbwA6LLJI8PF4VNipeWhvv4dkuFlKWHbZPsm7OE6Bp_FK2An_vuxpwD7zycZTngo2cszRuROK7gF4lB8Lpq4xlggqONrhhl0cyuPAVuI6BL8Z4V6Wb6_I-fBzvLSXSM9uOTKXDJVzfRG8kiIixpXkiOFW5Sg1qf1Z6GU4iTh0e70U4CsEqi5NU2Q_GlQeC1C8fpnrO10xaSpJLhdzFGYax3bCsO6JMUuwTy6UTf8zyKCeO6vni3LOQEQqgyxT4xrBzlG-LF26WGbmbmpaR1m7rmc81Yz_frwWCHbKn2mdiYBOxcb97A"
```

### Perform a Test Request
Run the following command to test with the token:
```bash
kubectl exec $(kubectl get pod -l app=curl -n curl -o jsonpath={.items..metadata.name}) -n curl -- curl http://httpbin.httpbin:8000/ -o /dev/null --header "Authorization: Bearer $MY_TOKEN" -s -w '%{http_code}\n'
```

If the above does not work, try using the Istio proxy directly:
```bash
kubectl exec $(kubectl get pod -l app=curl -n curl -o jsonpath={.items..metadata.name}) -n curl -c istio-proxy -- curl http://httpbin.httpbin:8000/ -o /dev/null --header "Authorization: Bearer $MY_TOKEN" -s -w '%{http_code}\n'
```

You can also test another service:
```bash
kubectl exec $(kubectl get pod -l app=productcatalogservice -o jsonpath={.items..metadata.name}) -c istio-proxy -- curl http://frontend:80/ -o /dev/null --header "Authorization: Bearer $MY_TOKEN" -s -w '%{http_code}\n'
```

---

## 5. Apply Authorization Policy

To finalize the setup, apply the AuthorizationPolicy:
```bash
kubectl apply -f authorizationpolicy.yaml
```

---

## 6. Testing with a Sample Token

A sample token can be fetched and decoded as follows:
```bash
TOKEN=$(curl https://raw.githubusercontent.com/istio/istio/release-1.24/security/tools/jwt/samples/demo.jwt -s)
echo "$TOKEN" | cut -d '.' -f2 | base64 --decode

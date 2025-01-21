
# Authentification

Concept de RequestAuthentication : Applique des JWT Rules a une requete venant de l'intérieur ou de l'exterieur

Exemple de code de requestautentication :
```yaml
apiVersion: security.istio.io/v1
kind: RequestAuthentication
metadata:
  name: "jwt-example"
  namespace: istio-system
spec:
  selector:
    matchLabels:
      istio: ingressgateway
  jwtRules:
  - issuer: "testing@secure.istio.io"
    jwksUri: "https://raw.githubusercontent.com/istio/istio/release-1.24/security/tools/jwt/samples/jwks.json"
```

**Explications :**

An issuer maps to a field in the JWT called iss which is the "party" that created the JWT, istio will decode the JWT and compare the iss field with this one.

**jwksUri** : resolvable URL which containes a public JWT key Set that istio uses to validate that the token was signed by a trusted JWT key set

In this case : Any JWT evaluated must have the iss field with the value testing@secure.istio.io and be signed by any key of the private part of the key present in http://auth-service.default.svc.cluster.local/jwk/public

La policy sera donc créée, il faut ensuite l'appliquer a une gateway, avec une authorizationpolicy


# Authorization

AuthorizationPolicy : policy to configure the access to the mesh, namespace and workloads

Objective : apply the request authentication in the previous step and decode the jwt, evaluate other fields



Istio's policies for JWT authorization are static; so pulling data from a database is imposisble with vanilla policies

On peux configurer un external service pour la logique d'autorisation
On peux communiquer avec eux soit via http soit via gRPC








L'ingress controler reponds a la problématique d'avoir a exposer un loadbalancer par service exposés a l'exterieur, avec une public ip différente a chaque fois

Ingress controler comprends : 
- Reverse proxy
- Traffic routing
- TLS Terminations capabilities

On utilise les ingress resource pour configurer l'ingress controler, afin de permettre de mettre plusieurs backends derriere la meme ip


# Ingress resource
Resource that helps defining the routing to the backend services

Two types of routing : 
- Host based routing
- Path-based routing

### Host based routing 

two hosts defined the the resource. If the incoming request is https://foo.bar.com/bar where host name is "foo.bar.com" and prefix is "/bar", it goes to "service1" and requests for "*.foo.com" with prefix "/foo" goes to "service2".

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ingress-wildcard-host
spec:
  rules:
  - host: "foo.bar.com"
    http:
      paths:
      - pathType: Prefix
        path: "/bar"
        backend:
          service:
            name: service1
            port:
              number: 80
  - host: "*.foo.com"
    http:
      paths:
      - pathType: Prefix
        path: "/foo"
        backend:
          service:
            name: service2
            port:
              number: 80
```


### Path-based routing

how the routing happens on incoming request for application path with prefix '/testpath'. That means, if there is an incoming request, for https://myexamplesite.com/testpath it will be evaluated against below ingress rule and it would be sent to the service called test on port 80


```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: minimal-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx-example
  rules:
  - http:
      paths:
      - path: /testpath
        pathType: Prefix
        backend:
          service:
            name: test
            port:
              number: 80
```



### Flow de communication avec un ingress controler

![[Pasted image 20250114115448.png]]



# Istio Ingress Gateway

IngressGateway runs as a service object, with few pods running behind it

Operates at the edge of the service mesh and serves as traffic controller incoming requests

# Istio Gateway



istio Gateway n'est pas un pod en tant que tel, c'est une ressource qui sert à contrôler l'ingress controller

On peux y configurer : 
- Accepter le traffic sur le gost que l'on veux
- configurer TLS pour les requetes inconnues


Below is the yaml snippet of istio gateway component. Here it shows that in the selector, it uses istio: ingressgateway as the label to bind to istio ingress gateway and this is how its bound to istio gateway. It also has the 'servers' section which has the configuratio for configuring the port number, hosts that this gateway is configured to accept traffic on.

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: httpbin-gateway
spec:
  selector:
    istio: ingressgateway # use Istio default gateway implementation
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - "httpbin.example.com"
```

## Istio Virtual Service

Virtual service sert a configurer le routage vers les backend

On configures un virtual service par applications et par backend

virtual service component, that shows how its configured to route the traffic to backend 'service' based on incoming hosts and uri prefix.

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: reviews-route
spec:
  hosts:
  - reviews.prod.svc.cluster.local
  http:
  - name: "reviews-v2-routes"
    match:
    - uri:
        prefix: "/wpcatalog"
    - uri:
        prefix: "/consumercatalog"
    rewrite:
      uri: "/newcatalog"
    route:
    - destination:
        host: reviews.prod.svc.cluster.local
        subset: v2
  - name: "reviews-v1-route"
    route:
    - destination:
        host: reviews.prod.svc.cluster.local
        subset: v1
```

![[Pasted image 20250114134904.png]]

Istio Service Mesh vs Nginx Ingress controller
6
- Activer mTLS entre les services
- Avoir une meilleur observabilité sur le traffic entre les services
- Avoir des techniques de déploiement (blue/green, circuit breaking, A/B testing, etc.)

Nginx uniquement si on veux gérer un traffic entrant et le distribuer aux applications backend, ca marche bien pour les petits workloads


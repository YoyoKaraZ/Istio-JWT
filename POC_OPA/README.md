# POC_OPA

Ce projet est une preuve de concept (POC) visant à intégrer **Open Policy Agent (OPA)** dans un environnement **Istio** pour une gestion avancée des politiques de sécurité et d’autorisation. L’implémentation inclut **Keycloak** pour l’authentification et l’émission de JWT, un service applicatif (**new_site**) à sécuriser, et des configurations spécifiques d’OPA.

## Architecture du projet

Le projet est organisé comme suit :

1. **Déploiement de Keycloak**
   - Keycloak est déployé dans un namespace dédié et configuré avec PostgreSQL comme backend.
   - Keycloak est utilisé pour gérer l’authentification des utilisateurs et émettre des tokens JWT.
   - Les fichiers de déploiement nécessaires se trouvent dans **`keycloak/`**.

2. **Build et déploiement de new_site**
   - L’application **new_site** est conteneurisée et déployée dans le cluster.
   - Elle est protégée par Istio et soumise aux politiques d’autorisation définies par OPA.
   - Les fichiers de déploiement sont disponibles dans **`new_site/`**.

3. **Déploiement d’OPA**
   - OPA est déployé avec une configuration spécifique dans un namespace.
   - Il reçoit les requêtes d’Istio et applique les politiques définies.
   - Les fichiers nécessaires se trouvent dans **`OPA_ABAC/`**.

4. **Déploiement de curl pour test**
   - Un pod **curl** est déployé dans un namespace séparé.
   - Il est utilisé pour tester les accès à **new_site** en envoyant des requêtes avec différents JWT.
   - Les fichiers de configuration sont situés dans **`curl/`**.

## Prérequis

Avant de commencer, assurez-vous d’avoir :

- Un cluster Kubernetes avec Istio installé.
- Helm installé pour faciliter le déploiement des services.
- `kubectl` configuré pour interagir avec votre cluster.
- Docker installé pour builder l’image de **new_site**.

## Étapes d’installation

### 1. Déploiement de Keycloak

Créez un namespace dédié :
```sh
kubectl create namespace keycloak
```

Appliquez les manifestes de déploiement :
```sh
kubectl apply -f keycloak/
```

### 2. Build et déploiement de new_site

Construisez l’image Docker de l’application :
```sh
docker build -t new_site .
```

Appliquez le déploiement Kubernetes :
```sh
kubectl apply -f new_site/
```

### 3. Déploiement d’OPA


Déployez OPA avec sa configuration personnalisée :
```sh
kubectl apply -f OPA_ABAC/
```

### 4. Déploiement de curl pour tester

Créez un namespace pour les tests :
```sh
kubectl create namespace curl
```

Déployez le pod curl :
```sh
kubectl apply -f curl/
```

## Conclusion

Ce POC montre comment intégrer **Keycloak** et **OPA** dans un environnement Istio pour une gestion avancée des autorisations. Il peut être adapté pour des scénarios plus complexes avec des règles de sécurité personnalisées.


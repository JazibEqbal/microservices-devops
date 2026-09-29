### Project Overview
```text
                         ┌───────────────┐
                         │     GitHub    │
                         └───────┬───────┘
                                 │
                              CI/CD
                                 │
                                 ▼
                         ┌───────────────┐
                         │      GHCR     │
                         └───────┬───────┘
                                 │
                                 ▼
        ┌─────────────────────────────────────────────────────┐
        │                     Kubernetes                      │
        │                                                     │
        │                    ┌──────────┐                     │
        │                    │ Ingress  │                     │
        │                    └────┬─────┘                     │
        │                         │                           │
        │                    ┌────▼─────┐                     │
        │                    │ API Svc  │                     │
        │                    └────┬─────┘                     │
        │                         │                           │
        │                       API Pods                      │
        │                      /        \                     │
        │                     ▼          ▼                    │
        │              Message Service   Food Service         │
        │                     │              │                │
        │                Message Pods    Food Pods            │
        │                     │                               │
        │                    PVC                              │
        │                     │                               │
        │              Persistent Data                        │
        │                                                     │
        │  ConfigMap │ Secret │ RBAC │ NetworkPolicy │ HPA    │
        │  Probes    │ Resources │ Rolling Updates            │
        └─────────────────────────────────────────────────────┘
```
### API Pod configuration
```text
                         API Pod
                            │
          ┌─────────────────┼─────────────────┐
          │                 │                 │
          ▼                 ▼                 ▼
      ConfigMap           Secret         ServiceAccount
          │                 │                 │
          ▼                 ▼                 ▼
   Non-sensitive        Sensitive          Pod Identity
   configuration        values                 │
                                               ▼
                                       Role + RoleBinding
                                               │
                                               ▼
                                       RBAC Permissions

                            │
                            ▼
                    Resource Requests
                            │
                       ┌────┴────┐
                       ▼         ▼
                      CPU      Memory

                            │
                            ▼
                    Health Probes
                   ┌────────┴────────┐
                   ▼                 ▼
              Readiness          Liveness
                   │                 │
             Receive traffic     Restart if
             or not?             unhealthy
```

### Network architecture
```text
                         Ingress
                            │
                            ▼
                       API Service
                            │
                            ▼
                         API Pods
                       /          \
                      /            \
                     ▼              ▼
            Message Service    Food Service
                    │                │
                    ▼                ▼
              Message Pods       Food Pods


NetworkPolicy:

API ───────────────► Message Service     Yes
API ───────────────► Food Service        Yes

Unknown Pod ───────► Message Service     No
Unknown Pod ───────► Food Service        No
```

### Scaling architecture
```text
                         HPA
                          │
             ┌────────────┼────────────┐
             ▼            ▼            ▼
          API HPA     Message HPA   Food HPA
             │            │            │
             ▼            ▼            ▼
         API Pods     Message Pods   Food Pods
          1 → 3          1 → 3        1 → 3
```
## CI-CD Flow:

                             git push → main
                                    │
                                    ▼
                         ┌────────────────────┐
                         │     CI Pipeline    │
                         ├────────────────────┤
                         │  1. Checkout       │
                         │  2. Build images   │
                         │  3. Push → GHCR    │
                         └─────────┬──────────┘
                                   │
                               CI SUCCESS
                                   │
                                   │ same SHA / manual SHA
                                   ▼
                ┌──────────────────────────────────────┐
                │              CD Pipeline             │
                ├──────────────────────────────────────┤
                │ 1. Self-hosted runner                │
                │ 2. Start & validate Minikube         │
                │ 3. Enable & validate Ingress         │
                │ 4. Deploy using deploy.sh <SHA>      │
                │ 5. Verify rollout                    │
                │ 6. Run smoke tests                   │
                │ 7. Rollback on failure               │
                └──────────────────┬───────────────────┘
                                   │
                                   ▼
                                Minikube
                                   │
                  ┌────────────────┼────────────────┐
                  ▼                ▼                ▼
                 API        Message Service    Food Service
                                   │
                                   ▼
                            Persistent Storage
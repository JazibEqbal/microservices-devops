## CI-CD Flow:

                         git push → main
                                │
                                ▼
                     ┌────────────────────┐
                     │   CI Pipeline      │
                     │                    │
                     │  1. Checkout       │
                     │  2. pytest         │
                     │  3. Build images   │
                     │  4. Push → GHCR    │
                     └─────────┬──────────┘
                               │
                         CI SUCCESS
                               │
                               │ same SHA
                               ▼
                     ┌────────────────────┐
                     │   CD Pipeline      │
                     │                    │
                     │  1. Receive SHA    │
                     │  2. Self-hosted    │
                     │     runner         │
                     │  3. deploy.sh SHA  │
                     │  4. Rollout        │
                     │  5. Smoke tests    │
                     │  6. Rollback       │
                     └─────────┬──────────┘
                               │
                               ▼
                            Minikube
                               │
              ┌────────────────┼────────────────┐
              ▼                ▼                ▼
             API        Message Service    Food Service
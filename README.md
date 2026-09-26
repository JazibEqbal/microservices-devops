                    Kubernetes
                         |
              +----------+----------+
              |                     |
              v                     v
          API Service        Message Service
              |                     | 
              |                     | 
           API Pod             Message Pod
              |                     |
              |                     | 
       +------+------+              |
       |             |              |
       ConfigMap      Secret       PVC
           |             |           |
           +------+------+           |
                  |                  |
              Environment      Persistent Data
                  |
             Resources
           CPU / Memory
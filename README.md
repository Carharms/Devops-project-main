This repo manages the overall project


final-project-main/
├── README.md                 (Overall project overview, architecture)
├── Git_Workflow.md           (Your detailed Git Flow doc)
├── docker-compose.yml        (For local dev of ALL services)
├── terraform/                (Your root Terraform configurations)
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── environments/
│       ├── dev.tfvars
│       ├── staging.tfvars
│       └── prod.tfvars
├── jenkins/                  (Any global Jenkins configurations, shared libs)
├── kubernetes/               (Top-level K8s manifests like namespaces, perhaps ingress)
└── docs/                     (Additional detailed documentation)

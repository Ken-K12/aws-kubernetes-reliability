---
name: kubernetes-review
description: Review Kubernetes manifests in this portfolio for reliability, scalability, and operational best practices. Use when reviewing Kubernetes YAML, deployments, services, probes, resources, HPA, or reliability tests.
---

# Kubernetes Review

Review Kubernetes manifests for:

- replicas
- readiness and liveness probes
- resource requests and limits
- HPA configuration
- service configuration
- reliability risks

Keep recommendations simple.

For each issue:

1. Explain the problem.
2. Explain why it matters.
3. Provide the minimal fix.
4. Show how to verify it with kubectl.

Do not add unnecessary Kubernetes components.
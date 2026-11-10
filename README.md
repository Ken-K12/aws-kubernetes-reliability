# AWS Kubernetes Reliability

A hands-on Kubernetes project demonstrating reliability and scaling patterns on AWS.

## Goals

- Deploy a highly available web application
- Verify Kubernetes self-healing
- Configure resource requests and limits
- Configure Horizontal Pod Autoscaling
- Test rolling updates and rollback

## Architecture

- Kubernetes Deployment
- 3 replicas
- Service
- Liveness and readiness probes
- HPA: 3-10 replicas
- CPU target: 50%

## Quick Start

```bash
kubectl apply -f k8s/
kubectl get pods
kubectl get svc
kubectl get hpa
```

## Portfolio Roadmap

This repository is the first of a series of DevOps/SRE portfolio labs.

- [Portfolio roadmap (5 core labs)](docs/portfolio-roadmap.md)
- [Additional CV-driven themes](docs/additional-themes.md)

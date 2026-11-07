# Copilot Instructions

This repository is a hands-on Kubernetes reliability portfolio project.

## Goals

- Keep Kubernetes manifests simple and production-oriented.
- Prefer standard Kubernetes resources.
- Prioritize reliability, scalability, and observability.
- Keep examples easy to understand and explain in technical interviews.

## Kubernetes

- Define CPU and memory requests and limits.
- Use readiness and liveness probes where appropriate.
- Use at least 3 replicas for highly available workloads.
- Use Horizontal Pod Autoscaler where appropriate.
- Avoid unnecessary complexity.

## Changes

When modifying Kubernetes manifests:

1. Explain why the change is needed.
2. Provide the simplest working solution.
3. Provide commands to apply the change.
4. Provide commands to verify the result.
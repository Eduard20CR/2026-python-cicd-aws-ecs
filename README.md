# 🚀 CI/CD Pipeline for a Python API on AWS (ECS Fargate)

This project demonstrates a **production-style CI/CD pipeline** for a Python API using **AWS managed services**, following real world DevOps best practices.

The goal is to automatically build, version, and deploy a containerized Python API to **ECS Fargate** whenever new code is pushed to GitHub.

## 🧠 What This Project Covers

* Containerized Python API (FastAPI)
* Automated Docker image builds
* Image versioning using **Git commit SHA**
* Secure image storage in Amazon ECR
* Automated deployments to ECS Fargate
* Infrastructure designed with scalability and cost control in mind

## 🛠 Tech Stack

* **Python** (FastAPI)
* **Docker**
* **GitHub**
* **AWS CodePipeline**
* **AWS CodeBuild**
* **Amazon ECR**
* **Amazon ECS (Fargate)**
* **Application Load Balancer**
* **CloudWatch Logs**
* *(Terraform planned for infrastructure as code)*

## 📐 Architecture Overview

**Flow:**

1. Code is pushed to `main` on GitHub
2. CodePipeline is triggered
3. CodeBuild:

   * Builds Docker image
   * Tags image with Git commit SHA
   * Pushes image to ECR
4. ECS Service:

   * Pulls new image
   * Performs rolling update on Fargate
5. Application is served via an Application Load Balancer

## 📁 Project Structure

```text
.
├── app/
│   ├── main.py
│   └── ...
├── tests/
│   └── ...
├── Dockerfile
├── requirements.txt
├── buildspec.yml
└── README.md
```

## 🩺 Health Check

The API exposes a health endpoint used by ECS and the Load Balancer:

```http
GET /health
```

Returns:

```json
{
  "status": "ok"
}
```

## 🧪 Local Development

### Build and run locally

```bash
docker build -t fastapi-api .
docker run -p 80:80 fastapi-api
```

Access:

* API: `http://localhost:80`
* Health check: `http://localhost:80/health`

## 🔁 CI/CD Strategy

### Image Versioning

* Docker images are tagged using the **Git commit SHA**
* This provides:

  * Full traceability
  * Easy rollbacks
  * Reproducible deployments

### Deployment Type

* ECS **rolling updates**
* Zero-downtime deployments
* One task replaced at a time

<!-- ## 🔐 Configuration & Secrets

* Environment variables are defined at the ECS Task Definition level
* Secrets are injected at runtime using:

  * AWS Secrets Manager
  * or SSM Parameter Store

Secrets are **never baked into the Docker image**. -->

## 💰 Cost Awareness

This project is designed as a **lab-friendly setup**:

* No cost when ECS services are stopped
* Fargate is billed only while tasks are running
* Resources can be destroyed or scaled to zero when not in use

## 🧱 Infrastructure as Code

The infrastructure was initially created manually to fully understand how each AWS component works and how they integrate with one another.
After validating the architecture, the entire setup was automated using Terraform, reproducing all AWS resources as code, including:

- Networking
- ECS & ECR
- CI/CD pipeline
- IAM roles and policies

## 🎯 Learning Objectives

* Understand real-world CI/CD pipelines on AWS
* Learn how ECS deployments work under the hood
* Apply DevOps best practices (immutability, traceability, automation)
* Prepare for production-grade cloud roles

## 📄 License

This project is for educational and portfolio purposes.
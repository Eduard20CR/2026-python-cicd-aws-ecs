# 🚀 End-to-End CI/CD Pipeline for a Python API on AWS (ECS Fargate)

This project showcases a **production-style, end-to-end CI/CD pipeline** for a containerized Python API running on **AWS ECS Fargate**, with **fully automated infrastructure and deployments using Terraform**.

The objective is to provision all required AWS resources as code and enable **automatic, zero-downtime deployments** whenever new code is pushed or merged into the `main` branch.

## 🧠 What This Project Demonstrates

* End-to-end **Infrastructure as Code (IaC)** using Terraform
* A complete **CI/CD pipeline** using AWS-native services
* Automated Docker builds and deployments
* Real-world debugging, observability, and IAM troubleshooting
* Production-style ECS deployment patterns

It reflects real challenges encountered when building and operating cloud infrastructure.

## 🛠 Tech Stack

* **Python** (FastAPI)
* **Docker**
* **GitHub**
* **Terraform**
* **AWS CodePipeline**
* **AWS CodeBuild**
* **Amazon ECR**
* **Amazon ECS (Fargate)**
* **Application Load Balancer**
* **Amazon CloudWatch (Logs & Metrics)**
* **AWS CloudTrail**

## 📐 Architecture Overview

### High-level Flow

1. Code is pushed or merged into `main` on GitHub
2. **CodePipeline** is automatically triggered
3. **CodeBuild**:

   * Builds the Docker image
   * Tags the image using the Git commit SHA
   * Pushes the image to **Amazon ECR**
4. **ECS Service (Fargate)**:

   * Pulls the new image
   * Performs a **rolling deployment**
5. Traffic is routed through an **Application Load Balancer**
6. Logs and events are monitored using **CloudWatch** and **CloudTrail**

## 🧱 Infrastructure as Code (Terraform)

All AWS resources are fully defined and managed using **Terraform**, including:

* VPC and networking components
* ECS Cluster, Task Definitions, and Services
* Application Load Balancer and Target Groups
* ECR repository
* CodePipeline and CodeBuild
* IAM roles and policies

This allows the entire environment to be **reproducible, versioned, and auditable**.

## 🔁 CI/CD Strategy

### Image Versioning

* Docker images are tagged using the **Git commit SHA**
* This provides:

  * Full traceability
  * Easy rollbacks
  * Immutable deployments

### Deployment Type

* ECS **rolling updates**
* Zero downtime
* Controlled task replacement managed by ECS

## 🔍 Observability & Debugging

This project required extensive troubleshooting beyond the “happy path”:

* **CloudWatch Logs** were used to diagnose runtime issues when the application failed to start or behaved unexpectedly.
* **CloudTrail** was critical for debugging **IAM permission issues**, allowing inspection of failed API calls and denied actions.
* Load Balancer health checks were used to validate application availability during deployments.

These experiences helped solidify a practical understanding of how AWS services behave in real environments.

## 🩺 Health Check

The API exposes a health endpoint used by ECS and the ALB:

```http
GET /health
```

Response:

```json
{
  "status": "ok"
}
```

## 📁 Project Structure

```text
.
├── app/
│   ├── main.py
│   └── ...
├── Dockerfile
├── requirements.txt
├── buildspec.yml
├── terraform/
│   └── modules & environments
└── README.md
```

## 🧪 Local Development

### Build and run locally

```bash
docker build -t fastapi-api .
docker run -p 8000:8000 fastapi-api
```

Access:

* API: `http://localhost:8000`
* Health check: `http://localhost:8000/health`

## 💰 Cost Awareness

This project was designed with **cost control in mind**:

* Fargate tasks are billed only while running
* Resources can be scaled down or destroyed via Terraform
* Suitable for lab, learning, and portfolio usage

## 🎯 Learning Outcomes

* Deep understanding of **ECS deployment mechanics**
* Practical experience with **AWS CI/CD pipelines**
* Real-world IAM and observability troubleshooting
* Strong grasp of **production-ready cloud workflows**
* Confidence designing, deploying, and debugging AWS systems

## 🚧 Future Improvements

Possible next iterations include:

* Blue/Green deployments
* Automated testing in the pipeline
* Enhanced security hardening
* Cost optimization strategies
* Metrics and alerting

## 📄 License

This project is intended for **educational and portfolio purposes**.
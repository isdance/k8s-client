### About Project:

I created a CI/CD pipeline using Jenkins, to automate the whole workflow of code linting, packaging, containerizing and uploading. At last Jenkins will trigger a automated deployment to AWS EKS cluster, using rolling update deployment strategy.

![pipeline-overview](./docs/images/pipeline-overview.png)

![pipeline-steps](./docs/images/pipeline-steps.png)

### Project Tasks:

- Working in AWS
- Using Jenkins to implement Continuous Integration and Continuous Deployment
- Building pipelines
- Working with CloudFormation to deploy clusters
- Building Kubernetes clusters
- Building Docker containers in pipelines

### Project Structure:

```
Dockerfile: A multi-steps docker image build, including production code build, nginx integration and dockerization.

Jenkinsfile: For Jenkins pipeline

/k8s: scripts for AWS EKS deployment using rolling update strategy.

/eksctl: script for initial setup of the AWS EKS Cluster.

/playbooks: simple playbook to trigger EKS update.

other: code for frontend project.
```

### Project Setup

1. setup AWS cluster. The Kubernetes cluster initialization will be done by hand. Below script will create 3 nodes in `us-west-2` region across 3 AZs.

simple-k8s.yml

```yml
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: EKS-udacity-capstone
  region: us-west-2

nodeGroups:
  - name: ng-1
    minSize: 3
    maxSize: 3
    instanceType: t2.small
    ssh:
      publicKeyName: jumpbox-key
```

Run `eksctl create cluster -f simple-k8s.yml`

![eks-result](./docs/images/eks-result.png)

To verify nodes are successfully created.

![eks-result](./docs/images/eks-result-nodes.png)

2. Trigger auto deployment via Jenkins Pipeline.


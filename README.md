PostgreSQL Database Deployment with Tekton
This repository contains the necessary files to build and deploy a PostgreSQL database on OpenShift using a Tekton-based CI/CD pipeline.

Files in this Repository
Dockerfile: A Dockerfile to build a PostgreSQL container image. It includes instructions to run initial SQL scripts to create tables and insert data.

create_tables.sql: The SQL schema to create the users table.

insert_data.sql: The SQL statements to insert sample data into the users table.

secret.yaml: A Kubernetes Secret manifest containing the database credentials.

pvc.yaml: A PersistentVolumeClaim (PVC) manifest to provide persistent storage for the database.

deployment.yaml: A Kubernetes Deployment manifest that defines how to run the PostgreSQL container, referencing the Secret and PVC.

tekton-pipeline.yaml: A Tekton Pipeline manifest that orchestrates the entire build and deployment process.

tekton-apply-manifests-task.yaml: A custom Tekton Task that applies the Kubernetes manifests to the cluster.

CI/CD Workflow with Tekton
This pipeline automates the entire process: a push to the Git repository triggers a new build and deployment.

Required OpenShift Resources
Before you can run the pipeline, you need to ensure the following Tekton tasks are available on your cluster. They are typically included by default with the OpenShift Pipelines Operator.

git-clone

buildah

Tekton Pipeline Configuration
To get started, you will need to apply the Tekton manifest files to your cluster.

Apply the custom Task:

oc apply -f tekton-apply-manifests-task.yaml

Apply the Pipeline:

oc apply -f tekton-pipeline.yaml

Manual Pipeline Run
To test the pipeline manually, you can use the oc start-pipelinerun command. Replace the Git URL and image name with your repository information.

oc start-pipelinerun postgresql-pipeline \
  -p "git-url=[https://github.com/YOUR_GITHUB_USER/YOUR_REPO_NAME.git](https://github.com/YOUR_GITHUB_USER/YOUR_REPO_NAME.git)" \
  -p "image-name=image-registry.openshift-image-registry.svc:5000/$(oc project -q)/my-postgresql-app" \
  --workspace name=source,claimName=tekton-workspace-pvc

Note: You will need to create a PersistentVolumeClaim named tekton-workspace-pvc for the pipeline to use as a temporary workspace.

Automated Deployment with Triggers
To set up automatic deployments on every git push to your repository, you need to create a Tekton Trigger.

In the OpenShift Web Console, navigate to the Developer perspective.

Go to Pipelines -> Pipelines and click on your postgresql-pipeline.

Click the Actions menu on the top right and select Create Trigger.

Choose to create a Git event listener, select GitHub, and follow the on-screen instructions to create the necessary webhook. This will provide you with a URL to add to your GitHub repository's webhooks settings.

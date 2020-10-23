# Migrate for Anthos Getting Started

Overview

## Description

## Demo

## Features

- feature:1
- feature:2

## Requirement

## Usage
### Prepare Cloud SDK
#### Installation
```
$ brew cask install google-cloud-sdk
```

#### Update Cloud SDK
```
$ gcloud components update
```

#### Authorization
```
$ gcloud auth login
```

### Enable required Services

|Name|Title|
|----|-----|
|servicemanagement.googleapis.com|Service Management API|
|servicecontrol.googleapis.com|Service Control API|
|cloudresourcemanager.googleapis.com|Cloud Resource Manager API|
|compute.googleapis.com|Compute Engine API|
|container.googleapis.com|Kubernetes Engine API|
|containerregistry.googleapis.com|Google Container Registry API|
|cloudbuild.googleapis.com|Cloud Build API|

```
$ gcloud services enable servicemanagement.googleapis.com servicecontrol.googleapis.com cloudresourcemanager.googleapis.com compute.googleapis.com container.googleapis.com containerregistry.googleapis.com cloudbuild.googleapis.com
```

### Configure Service Account

- To access **Container Registry** and **Cloud Storage**
- To use **Compute Engine** as a migration source

#### To access Container Registry and Cloud Storage

```
gcloud iam service-accounts create m4a-install --project=(gcloud config get-value project)
gcloud projects add-iam-policy-binding (gcloud config get-value project)  \
  --member=serviceAccount:m4a-install@(gcloud config get-value project).iam.gserviceaccount.com \
  --role=roles/storage.admin
gcloud iam service-accounts keys create m4a-install.json \
  --iam-account=m4a-install@(gcloud config get-value project).iam.gserviceaccount.com \
  --project=(gcloud config get-value project)
```

#### To use Compute Engine as a migration source

```
gcloud iam service-accounts create m4a-ce-src \
  --project=(gcloud config get-value project)
gcloud projects add-iam-policy-binding (gcloud config get-value project)  \
  --member=serviceAccount:m4a-ce-src@(gcloud config get-value project).iam.gserviceaccount.com \
  --role=roles/compute.viewer
gcloud iam service-accounts keys create m4a-ce-src.json \
  --iam-account=m4a-ce-src@(gcloud config get-value project).iam.gserviceaccount.com \
  --project=(gcloud config get-value project)
```

### Create GKE Cluster

```
$ gcloud container clusters create m4a-process \
    --project (gcloud config get-value project) \
    --zone=us-central1-f \
    --enable-ip-alias \
    --num-nodes=1 \
    --machine-type=n1-standard-2 \
    --cluster-version=1.16 \
    --enable-stackdriver-kubernetes
```

#### Create Windows Node Pool

```
$ gcloud container node-pools create m4a-node-pool \
    --cluster=m4a-process \
    --zone=us-central1-f \
    --image-type=WINDOWS_SAC \
    --num-nodes=1 \
    --scopes "cloud-platform" \
    --machine-type=n1-standard-2
```

### Get Credential for GKE Cluster

```
$ gcloud container clusters get-credentials m4a-process \
    --zone=us-central1-f \
    --project (gcloud config get-value project)
```

### Install Migrate for Anthos

Visit [GKE Menu](https://console.cloud.google.com/kubernetes/list?_ga=2.146152052.173896692.1603064141-983599867.1599137884)

Click **Connect** Button and use Cloud Shell

```
$ gcloud container clusters get-credentials m4a-process --zone us-central1-f --project $(gcloud config get-value project)
```

Upload `m4a-install.json` which is key file for accessing Container Registry and Cloud Storage

```
$ migctl setup install --json-key=m4a-install.json
```

## Installation

## Licence

Released under the [MIT license](https://gist.githubusercontent.com/shinyay/56e54ee4c0e22db8211e05e70a63247e/raw/34c6fdd50d54aa8e23560c296424aeb61599aa71/LICENSE)

## Author

[shinyay](https://github.com/shinyay)

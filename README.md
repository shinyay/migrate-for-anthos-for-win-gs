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
```

## Installation

## Licence

Released under the [MIT license](https://gist.githubusercontent.com/shinyay/56e54ee4c0e22db8211e05e70a63247e/raw/34c6fdd50d54aa8e23560c296424aeb61599aa71/LICENSE)

## Author

[shinyay](https://github.com/shinyay)

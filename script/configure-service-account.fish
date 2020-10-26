#!/usr/bin/env fish

function do_func
  argparse -n do_func 'h/help' 'f/flug=' -- $argv
  or return 1

  if set -lq _flag_help
    echo "configure-service-account.fish -f/--flug <YES/NO>"
    echo "YES: Create Service Account"
    echo "  - m4a-install: To access Container Registry and Cloud Storage"
    echo "  - m4a-ce-src: To use Compute Engine as a migration source"
    echo "NO: List Service Account"
    return
  end

  set -lq _flag_flug
  or set -l _flag_flug NO

  if test (string upper $_flag_flug) = NO
    gcloud iam service-accounts list
    return
  end

  gcloud iam service-accounts describe m4a-install@(gcloud config get-value project).iam.gserviceaccount.com
  
  if test (echo $status) -ne 0
    #### To access Container Registry and Cloud Storage
    gcloud iam service-accounts create m4a-install \
      --project=(gcloud config get-value project)
    gcloud projects add-iam-policy-binding (gcloud config get-value project)  \
      --member=serviceAccount:m4a-install@(gcloud config get-value project).iam.gserviceaccount.com \
      --role=roles/storage.admin
    gcloud iam service-accounts keys create m4a-install.json \
      --iam-account=m4a-install@(gcloud config get-value project).iam.gserviceaccount.com \
      --project=(gcloud config get-value project)
    #### To use Compute Engine as a migration source
    gcloud iam service-accounts create m4a-ce-src \
      --project=(gcloud config get-value project)
    gcloud projects add-iam-policy-binding (gcloud config get-value project)  \
      --member=serviceAccount:m4a-ce-src@(gcloud config get-value project).iam.gserviceaccount.com \
      --role=roles/compute.admin
    gcloud iam service-accounts keys create m4a-ce-src.json \
      --iam-account=m4a-ce-src@(gcloud config get-value project).iam.gserviceaccount.com \
      --project=(gcloud config get-value project)
    #### Displau service account list
    gcloud iam service-accounts list
  end
end

do_func $argv

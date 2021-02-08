for API in 'cloudresourcemanager' 'cloudbilling' 'iam' 'compute' 'storage-api'; do
  gcloud services enable "${API}.googleapis.com”
done

provider "google" {
  credentials = file("/home/user/terraform-admin.json")
  project     = "my-12345-project"
  region      = "us-central1"
  zone        = "us-central1-c"
}

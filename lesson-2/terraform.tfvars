zone         = "us-central1-c"
name         = "nginx-terraform"
machine_type = "n1-custom-1-4608"
image        = "centos-7"
region       = "us-central1"
project      = "my-12345-project"
size         = "35"
type         = "pd-ssd"
labels = {
  servertype        = "nginxserver"
  osfamily          = "redhat"
  wayofinstallation = "nginx-terraform"
}

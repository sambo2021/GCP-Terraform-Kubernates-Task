#create service account with admin previleges
resource "google_service_account" "access" {
  account_id   = "access"
  display_name = "access-service-account"
}
#giving this service acount role on container to be admin 
resource "google_project_iam_binding" "Cluster"{
    project = "sambo-project"
    role = "roles/container.admin"
    members=[
      "serviceAccount:access@sambo-project.iam.gserviceaccount.com",
      ]
    depends_on = [google_service_account.access]
}
#giving this service acount role on container storage to be admin 
resource "google_project_iam_binding" "GCR"{
    project = "sambo-project"
    role = "roles/storage.objectAdmin"
    members=[
      "serviceAccount:access@sambo-project.iam.gserviceaccount.com",
      ]
    depends_on = [google_service_account.access]
}
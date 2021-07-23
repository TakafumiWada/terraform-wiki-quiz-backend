module "quizwiki_backend" {
  source = "../"

  project_id     = var.project_id
  project_number = var.project_number
  credentials    = var.credentials
  branch_name    = var.branch_name
}
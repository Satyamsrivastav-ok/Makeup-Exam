package main

deny[msg] {
  input.kind == "Deployment"
  input.spec.template.spec.containers[_].image == "nginx:latest"
  msg = "Latest image tag is not allowed"
}

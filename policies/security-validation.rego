package main

deny[msg] {
  input.spec.template.spec.securityContext.runAsUser == 0
  msg = "Running as root user is not allowed"
}

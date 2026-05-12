package main

deny[msg] {
  input.spec.template.spec.containers[_].securityContext.privileged == true
  msg = "Privileged containers are not allowed"
}

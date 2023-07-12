provider "kubernetes" {
  config_path = "~/.kube/config"
}
terraform {
  backend "kubernetes" {
    name = "robertobackend"
    namespace = "rashid"
    config_path = "~/.kube/config"
    secret_suffix    = "state"
  }
  
}

variable "name" {
  type = string
  default = "roberto"
}
variable "containername" {
  type = string
  default = "robertocontainer"
}
variable "namespace" {
  type = string
  default = "rashid"
}
variable "id" {
  type = list(object({
    id = number
  }))
  default = [ {
    id = 0
  },
  {
    id = 1
  },
  {
    id = 3
  } ]
}

resource "kubernetes_deployment" "robertodeployment" {
  count = length(var.id)
  metadata {
    name = "${var.name}"
    namespace = "${var.namespace}"
    labels = {
      id = "root"
      value= "${var.name}"
    }
  }
  spec {
    template {
      metadata{
            name = "robertocontainer-${var.id[count.index].id}"
            namespace = var.namespace
            labels = {
                id="root"
            }
        }
    spec {
      container {
            name ="${var.id[count.index].id}-robertotpsshcontainer"
            image= "robertolandry/tpssh:latest"
            command = ["sleep"]
            args = ["infinity"]
        }

    }
    }
    replicas = 1
    selector {
      match_labels = {
        id= "root"
      }
    }
  } 
  

}

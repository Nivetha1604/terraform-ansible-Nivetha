# Use vm_names from lb.tf locals
locals {
  pip_names = [for n in local.vm_names : "${n}-pip"]
}

data "azurerm_public_ip" "vm_pip" {
  for_each            = toset(local.pip_names)
  name                = each.value
  resource_group_name = var.resource_group_name

  depends_on = [
    module.linux_vm["vm1"],
    module.linux_vm["vm2"],
    module.linux_vm["vm3"],
  ]
}

locals {
  public_ips = [for k, v in data.azurerm_public_ip.vm_pip : v.ip_address]
}

resource "null_resource" "run_ansible" {
  depends_on = [
    module.linux_vm["vm1"],
    module.linux_vm["vm2"],
    module.linux_vm["vm3"],
  ]

  triggers = {
    ips_hash = sha1(join(",", local.public_ips))
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOC
      set -e
      mkdir -p .ansible
      cat > .ansible/inventory_n01725290.ini <<'INV'
      [linux]
      ${join("\n", [for ip in local.public_ips : "${ip} ansible_user=azureuser ansible_ssh_private_key_file=/home/n01725290/.ssh/id_rsa ansible_ssh_common_args='-o StrictHostKeyChecking=no'"])}
      INV
      echo ">>> Inventory written to .ansible/inventory_n01725290.ini"
      ansible --version
      ansible-playbook -i .ansible/inventory_n01725290.ini ../ansible/n01725290-playbook.yml
    EOC
  }
}


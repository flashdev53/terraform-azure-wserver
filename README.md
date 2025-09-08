#  Azure Web Server Infrastructure with Terraform

This project provisions a basic web server infrastructure on Microsoft Azure using Terraform. It sets up a Linux virtual machine (Ubuntu) with NGINX installed and accessible over HTTP and SSH.

---

##  Features

- Azure Resource Group in Central India
- Virtual Network with Subnet
- Static Public IP Address
- Network Security Group with:
  - Allow SSH (Port 22)
  - Allow HTTP (Port 80)
- Network Interface associated with NSG
- Ubuntu Linux Virtual Machine
  - SSH key-based login
  - NGINX installed and running
- Public IP output on completion

---

##  File Structure

```bash
.
├── main.tf         # Terraform infrastructure definition
├── output.tf       # Outputs the public IP of the VM
└── README.md       # Project documentation
```
## Prerequisites

-Terraform

-Azure CLI

-Azure subscription

-SSH key pair (public and private)

## SSH Key Configuration

Ensure your local SSH public key is located at:

```bash
/home/dev/.ssh/id_rsa.pub
```
And your private key at:

```bash
/home/dev/.ssh/id_rsa
```
Update the paths in main.tf if needed.

## Usage

### Login to Azure CLI (if not already):
```bash
az login
```
### Initialize Terraform:
```bash
terraform init
```
### Plan the deployment:
```bash
terraform plan
```
### Apply the configuration:
```bash
terraform apply
```
### Access the web server:

After deployment, Terraform will output the public IP. You can access the NGINX server in your browser:
```bash
http://<public_ip>
```
You can also SSH into the VM:
```bash
ssh devadmin@<public_ip> -i /home/dev/.ssh/id_rsa
```
## Teardown

To destroy all the resources:
```bash
terraform destroy
```
## Notes

-The VM uses the Standard_B1s size (suitable for testing/dev).

-The default region is Central India — you can modify it in main.tf.

-This setup is for demo/development purposes. Do not use as-is in production.

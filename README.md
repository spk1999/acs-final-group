
# ACS370 Final Project 
#### Team Members
* Sunil Shrestha
* Abhishek Dahal
* Sujan Panthi
* Meheraj Maharjan
### Two-Tier Web Application Automation using Terraform, Ansible and GitHub
Use the below mentioned code in order to setup the infrastructure in terraform.

Clone the repository.
git clone https://github.com/spk1999/acs-final-group

### Deploy the Network part as required by the project
	Go to acs730-final-project/ProjectWeek6 /dev/network directory and follow the steps
*	terrafrom init 
*	terraform fmt
*	terraform validate
*	terraform plan
*	terrform apply
### Deploy the webservers part as required by the project

### Go acs730-final-project/ProjectWeek6 /dev/webserver and follow the steps

*	terrafrom init # initialize terrform
*	terraform fmt
*	terraform validate
*	terraform plan
*	terrform apply

### Ansible to deploy the webservers
The following instructions needs to be followed for the ansible part.
*	Install ansible and boto3 dependencies 
*	sudo yum install –y ansible
*	sudo pip2.7 install boto3 
*	enable_plugins = aws_ec2 
*	ansible-playbook -i aws_ec2.yaml playbook3.yaml 
 GitHub 

### The following Instructions needs to be followed for the Github Action part
*	When the terraform and ansible part has been completed the following can be done for the auto deployment part
*	git push
*	(Once the git push happens )Git action gets triggered
*	trivy and tfsec workflow is used trigger on any push or pull_request
*	tfdeploy workflow is used trigger when the admin or the contridutor approves the merge request


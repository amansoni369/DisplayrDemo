# Displayr Demo #

This README provides details on how the problem was solved.

## Dependencies ##
* This solution makes use of `Hashicorp's Terraform` tool.
* It also needs you to have an AWS account. In order to provision resources in your aws account, you will need to credentials for programmatic access. Refer to aws official doco on how to do that https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys

## How To Use ##
Before running terraform, you will need to configure an `aws profile`. This aws profile will allow you to create aws resources inside the corresponding aws account. 
Use `aws-cli` to configure credentials. If you don't have aws-cli, please download aws-cli for windows from - https://awscli.amazonaws.com/AWSCLIV2.msi. If you wish to run it on linux, the install required package of aws-cli for linux. Once `aws-cli` is installed, you should be able to setup your aws profile. To do that, execute below steps:

```
Configuring aws credentials:
* Test if aws-cli is installed by running `aws --version`. If that works fine you are good to go, else you might have to update windows path to include path where aws-cli is installed.
* Open `powershell` or `cmd` on your windows machine.
* Run `aws configure --profile <<<your_profile_name>>>` and follow the prompts. Please input the profile name of your choice and make a note of it.
```

Post aws profile configuration, it is time to run terraform templates. Terraform needs the binary file in order to execute. Download the binary from -> https://www.terraform.io/downloads. Save the terraform binary on your system and update the env var to point to terraform binary. Once that is done, test it out by running `terraform -version`.

Please follow below steps on how to run terraform:-

How to run terraform templates:
* In order to run terraform, open any terminal on your windows (`cmd`/`powershell`/`vscode terminal`)
* Browse to the folder with terraform binary file and to test out if terraform works, run `terraform --version` command. If you wish to *run terraform from anywhere*, `set terraform path` in your windows environment variables.
* If all good, run the below commands:
    * `terraform init` - This will initialise terraform with required providers/packages.
    * `terraform plan` - This will describe the plan based on terraform templates.
    * `terraform apply -auto-approve` - This command will implement the changes in your aws environment. This will prompt you for aws profile name that was setup in above steps. The EC2 instance is enabled with Password Authentication. 
    
        For this demo, the temporary password is configured and it is displayed in the output post terraform run.
    * `terraform destroy -auto-approve` - Use this command to destroy the aws infrastructure without any manual intervention.

Once above steps are executed successfully, terraform will share useful output.

## Health Check ##
There is a basic healthcheck script in the repository which does basic health checks on the webserver. In order to execute the script, run `.\healthcheck.sh http://<<web_server_ip>>/`. You will get the ip address of web server from terraform output.
The script can be run from windows/linux and it checks the health of web server externally. It checks the health of web server every 5 seconds. 
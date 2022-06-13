# udacity-project-2

# This was edited in cloud shell

[![Python application test with Github Actions](https://github.com/huy-js/azure-udacity-project-2/actions/workflows/pythonapp.yml/badge.svg)](https://github.com/huy-js/azure-udacity-project-2/actions/workflows/pythonapp.yml)

[![Build Status](https://dev.azure.com/huycntt/azure-udacity-project-2/_apis/build/status/huy-js.azure-udacity-project-2?branchName=main)](https://dev.azure.com/huycntt/azure-udacity-project-2/_build/latest?definitionId=20&branchName=main)

* First of all set up SSH Keys in your azure cloud shell, add the `id_rsa.pub` key to your GitHub repo ( ssh keys)  and then clone the project there.

```sh
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub
```

Create a virtual environment for your application.

```sh
python3 -m venv ~/.myrepo
source ~/.myrepo/bin/activate
```
* Run `make lint` check syntax

```sh
make lint
```
* Run `make test` run check testcase

```sh
make test
```
* Run `make all` which will install, lint, and test code

```sh
make all
```

![alt text](https://github.com/huy-js/azure-udacity-project-2/blob/main/images/make-all.png)

* Next set up Github Actions in your repo doing this :

> just add an space on botton of file `.github/workflows/pythonapp.yml` and save it

```sh
ls -l .github/workflows/pythonapp.yml
vim .github/workflows/pythonapp.yml
```

## Second : CI/CD Pipeline with AZURE DEVOPS

* Go to Azure Devops page and sign in it, create a New Project inside your organization create a new one if you do not have any

* In your Project in Azure DevOps, go to Project Settings and create a new `Pipeline --> Service Connection` to connect to service

> Note 1 : Name your Service Connection `azure-udacity-project-2`
> Note 2: Use a link of as this `https://dev.azure.com/<organization>/<project_name>/_apis/serviceendpoint/endpoints?api-version=5.0-preview.2`  to find your ServiceConnectionID ( take note of this number since you will needed in the yaml file to build the pipeline). Replace the values for the ones that you created for your organization and project name.
Note3: the ServiceConnection ID is the number before the name `azure-udacity-project-2` of the above link.

* Create the app service to Azure app Service (using Plan B1) with this command:

```sh
az webapp up -n <name of webapp> --location eastus --sku B1
```
![alt text](https://github.com/huy-js/azure-udacity-project-2/blob/main/images/appservice.png)

* Important you need to create a self host agent pool to handle your pipeline
> Create your own Azure Virtual Machine with following step in Udacity CD part
> Config this Agent Pool in project settings

![alt text](https://github.com/huy-js/azure-udacity-project-2/blob/main/images/agentpool.png)

* In your new Project in Azure DevOps, go to Pipelines --> New Pipeline --> GitHub --> Select Your Repo --> Select `an Existing YAML file`

> Choose the `main` branch and the file named `azure-pipelines.yml`
> Update the `azure-pipelines.yml` with the name of your webapp

* Choose Run Pipeline and your Azure DevOps Pipeline is going to start to be deployed with all his stages (in this case 2: Build & deploy)

![alt text](https://github.com/huy-js/azure-udacity-project-2/blob/main/images/custom-yaml-file.png)

* Perform a cosmetic change to your app.py , so you can see your CI/CD pipelines in action on Azure DevOps ( CD) & GitHub Actions (CI)

> On file `app.py` change this line:

```sh
html = "<h3">Sklearn Prediction Home</h3>"
```

to this one:

```sh
html = "<h2>Sklearn Prediction Home APP - RestAPI</h2>"
```

and then perform a quick lint and push the changes to your repo:

```sh
git add .
git commit -m "app.py updated"
git push
```

* Check that the webapp is running opening his URL, example:

```sh
https://az-devops-project-2.azurewebsites.net/
```
![alt text](https://github.com/huy-js/azure-udacity-project-2/blob/main/images/change_to_restapi.png)

Update the file `make_predict_azure_app.sh` with the app service end point

* When the Azure Devops pipeline is successfully deployed, then its time to make a prediction:

```sh
./make_predict_azure_app.sh
```

```sh
Port: 443
{"prediction":[20.35373177134412]}
```

> Note: Azure cloud Shell is not enough good to perform locust there, so use a VM or your own local machine ( windows, macos, linux) to run Locust
> Note: copy both files (`loadtesting.sh` & `locustfile.py`) and run the `loadtesting.sh` file and open the browser on `http://localhost:8089/` :

```sh
./loadtesting.sh
```

>from there you can see how the load testing is performing and how you app established on a # of RPS
> This is good to know how good is your webapp and your plan to manage the requests. So you can decide to scale up the plan service of your webapp for example.
-> Locust could generate a stats report.

![alt text](https://github.com/huy-js/azure-udacity-project-2/blob/main/images/locust.png)

## CLEANING OUT

* Delete the resource group of your app service created.

## Future Enhancements

* Adding more test cases.
* Creating a UI for making predictions.
* Using Github Actions instead of Azure pipelines. 

## YouTube Demo

# Cloud Devops using Microsoft Azure Project 2

# This was edited in cloud shell

[![Python application test with Github Actions](https://github.com/huy-js/azure-udacity-project-2/actions/workflows/pythonapp.yml/badge.svg)](https://github.com/huy-js/azure-udacity-project-2/actions/workflows/pythonapp.yml)

[![Build Status](https://dev.azure.com/huycntt/azure-udacity-project-2/_apis/build/status/huy-js.azure-udacity-project-2?branchName=main)](https://dev.azure.com/huycntt/azure-udacity-project-2/_build/latest?definitionId=20&branchName=main)

# Introduction
In this project, you will build a project in Github repository. You will Makefile and requirements to initial lint, test and install cycle and intergrate with Azure Pipelins to run Continous Delivery in Azure App Service

# Project plan
* Trello url: https://trello.com/b/S8rF7YFI/azure-devops-project-2
* Link to spreadsheet: 
https://docs.google.com/spreadsheets/d/1M3G9nIk6ByEg0wnLStx_y8pRqiRuP1UBzMNjy8n06Ls/edit?usp=sharing

# Set up
* Azure Portal: (https://portal.azure.com/)
* Gihub Account: (https://github.com/)
* Azure Devops: (https://dev.azure.com/)

## First: Create make file and run Githubs Actions
* First of all we need set up ssh in Azure Cloud Shell, `id_rsa.pub` key to your GitHub repo (ssh keys) and then clone the project into Azure Cloud Shell.

```sh
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub
```

* Create virtual environment in your application.

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

* Set up Github Actions in your repository:

> just add an space on botton of file `.github/workflows/pythonapp.yml` and save it

```sh
ls -l .github/workflows/pythonapp.yml
vi .github/workflows/pythonapp.yml
```

## Second : CI/CD Pipeline with AZURE DEVOPS

* Go to Azure Devops page and sign in it, create a New Project inside your organization create a new one if you do not have any

* In your Project in Azure DevOps, go to Project Settings and create a new `Pipeline --> Service Connection` to connect to service

> Note 1 : Name your Service Connection `azure-udacity-project-2`
> Note 2: Find your ServiceConnectionID by url `https://dev.azure.com/<organization>/<project_name>/_apis/serviceendpoint/endpoints?api-version=5.0-preview.2` and replace your information organization and project_name
> Note3: the ServiceConnectionID is the number before the name `azure-udacity-project-2` in this url

* Create the app service to Azure app Service (using Plan B1) is recommandation:
> Run shell script to add your azure app service
```sh
./command.sh
```
![alt text](https://github.com/huy-js/azure-udacity-project-2/blob/main/images/appservice.png)

* Important you need to create a self host agent pool to handle your pipeline
> Create your own Azure Virtual Machine with following step in Udacity CD part
> Config this Agent Pool in project settings

![alt text](https://github.com/huy-js/azure-udacity-project-2/blob/main/images/agentpool.png)

* In your new Project in Azure DevOps, go to Pipelines --> New Pipeline --> GitHub --> Select Your Repo --> Select `an Existing YAML file`

> Choose the `main` branch and the file named `azure-pipelines.yml`
> Update the `azure-pipelines.yml` with the your app service information

* Choose Run Pipeline and your Azure DevOps Pipeline is going to start to be deployed with all his stages (in this case 2: Build & deploy)

![alt text](https://github.com/huy-js/azure-udacity-project-2/blob/main/images/custom-yaml-file.png)

* Perform a cosmetic change to your app.py , so you can see your CI/CD pipelines in action on Azure DevOps (CD) & GitHub Actions (CI)

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
> Note: run locust and open the browser on `http://localhost:8089/` :

```sh
locust
```

![alt text](https://github.com/huy-js/azure-udacity-project-2/blob/main/images/locust-ui.png)

> Run locust in your local machine to load testing and performing your app service
> Run locust app and fill information abount Number of user, Spawn rate and URL to loadtesting in your app service
> Locust could generate a stats report.

![alt text](https://github.com/huy-js/azure-udacity-project-2/blob/main/images/locust.png)

## Cleaning project

* Delete the resource group of your app service created.

## Future Enhancements

* Adding more test cases.
* Creating a UI for making predictions.
* Using Github Actions instead of Azure pipelines. 
* Using Circle CI in project

## YouTube Demo
https://youtu.be/yed11CCghh0
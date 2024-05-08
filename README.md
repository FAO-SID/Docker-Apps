# Dockerized RStudio for GSP activities
This repository includes instructions and dockerfiles to build a dockerized standard version of Rstudio for running scripts developped at GSP.
This solves the difficulties found by many GSP partners regarding the installation of packages and running the code provided in GSP developments.

The easiest way is to retrieve the image from the docker hub by typoing 
Step 1: Install docker desktpp in you computer.
Step 2: Open a Terminal/Command Prompt window.
Step 3: Type in the Terminal/Command Prompt window.
        docker pull luislado/rstudio_gsp:v1.0

Alternatively, you can build your own image:

Step 1: Install docker desktpp in you computer.
Step 2: Clone this repository.
Step 3: Open a Terminal/Command Prompt window.
Step 4: Move to the cloned folder.
Step 5: Within the folder, type in the terminal the following line:
    docker-compose up --build.
The installation will start and will take about 45 minutes to finish from scratch. After the installation, you will find a new folder ('rstudio-data') in the cloned folder. This will be the default root for the working directory. Rstudio will only access to the files located in this new directory.
Step 6: Type localhost:8787 in your web browser. The Rstudio GUI appears and asks for a user: 'rstudio' and password_: 'rstudio' 




# Dockerized RStudio for GSP activities
This repository included instructions and dockerfiles to build an image for a dockerized version of Rstudio.
This solves the difficulties found by many GSP partners regarding the installation of packages and running the code provided in GSP developments.

Step 1: Install docker desktpp in you computer.
Step 2: Clone this repository.
Step 3: Open a Terminal/Command Prompt window.
Step 4: Move to the cloned folder.
Step 5: Within the folder, run the command "docker-compose up --build" in the terminal.

The installation will start and will take about 45 minutes to finish from scratch. After the installation, you will find a new folder ('rstudio-data') in the cloned folder. This will be the default root for the working directory. Rstudio will only access to the files located in this new directory.

Step 6: Type localhost:8787 in your web browser. The Rstudio GUI appears and asks for a user: 'rstudio' and password_: 'rstudio' 

You can use R studio with all the reuirements for running the GSP scripts.




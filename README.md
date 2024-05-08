# Dockerized RStudio for GSP Activities

This repository provides instructions and Dockerfiles to build a Dockerized standard version of RStudio for running scripts developed at GSP. This setup aims to solve difficulties faced by many GSP partners when installing packages and running code from GSP developments.

## Quick Start: Using Image from Docker Hub

The simplest way to get started is to pull the image directly from Docker Hub.

### Steps:
1. **Install Docker Desktop** on your computer.
2. **Download** the `docker-compose.yml` file into an empty folder.
3. **Open a Terminal/Command Prompt** window and navigate to the folder containing the `docker-compose.yml` file.
   ```bash
   cd my_empty_folder
3. **Type in the Terminal/Command Prompt** window the following command:
   ```bash
   docker pull luislado/rstudio_gsp:v1.0

The image will be downloaded from docker hub and installed in your computer

4. **Run the container** typing in the Terminal/Command Prompt window:
   ```bash
   docker-compose up -d
5. **Enter Rstudio** typing:
    ```bash
    localhost:8787

6. **Enter Rstudio in your web browser**. `User` and `password` have been set to:
    ```bash
    rstudio

## Building Your Own Docker Image

Alternatively, you can build your own image using the files in the  *build_image* folder.

### Steps:
1. **Install Docker Desktop** on your computer.
2. **Clone the build_image directory**.
3. **Open a Terminal/Command** Prompt window.
4. **Navigate** to the Cloned Folder:
    ```bash
    cd my_directory

5. **Build the Image** using Docker Compose:
    ```bash
    docker-compose up --build

The installation will take about 45 minutes to complete from scratch. After installation, a new folder named rstudio-data will appear in the cloned folder. This will be the default root working directory, and RStudio will only access files within this directory.
Access RStudio: Open a web browser and go to:
   
5.
    ```bash
    localhost:8787

The RStudio GUI will appear and prompt you to log in. Use the following credentials:
- Username: rstudio
- Password: rstudio


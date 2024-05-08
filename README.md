# Standardized RStudio for FAO-GSP Training Activities

Welcome to this repository, which offers a standardized Dockerized version of RStudio adapted to the requirements of FAO-GSP training activities. This solution addresses common installation issues related to RStudio and its dependencies by providing a containerized environment that includes all necessary R packages to run the R scripts implemented at GSP. This approach ensures a consistent and conflict-free setup across different computing environments.

The Dockerized RStudio we've developed aims to simplify the process of setting up a fully functional RStudio workspace, eliminating the variability and system conflicts often encountered with traditional installation methods. This makes it an ideal solution for users who need a reliable and quick setup to begin their data analysis without the hassle of configuring the software and resolving dependency issues.

This solution has been tested to work effectively across various systems, demonstrating its robustness and adaptability. The repository is equipped with Dockerfiles and comprehensive instructions for building and running the Dockerized RStudio, making it accessible for both beginners and advanced users. The configuration is designed to be flexible, allowing easy updates and additions to the package list through simple modifications of the Dockerfile.

For those new to Docker or containerization, this repository can serve as an excellent starting point for learning how to deploy and manage containerized applications. Additionally, this setup promotes better management of resources in environments where multiple users need access to a standardized analytical toolset.

Explore the documentation to get started with deploying your Dockerized RStudio environment and take advantage of a streamlined setup process that keeps your system clean and your software portable.

## Quick Start: Using Image from Docker Hub

The simplest way to get started is to pull the Docker image directly from Docker Hub.

### Steps:
1. **Install Docker Desktop** on your computer.
2. **Download** the `docker-compose.yml` file into an empty folder.
3. **Open a Terminal/Command Prompt** window and navigate to the folder containing the `docker-compose.yml` file:
   
   ```bash
   cd my_empty_folder
3. **Type in the Terminal/Command Prompt** window the following command:
   ```bash
   docker pull luislado/rstudio_gsp:v1.0

The image will be downloaded from Docker Hub and installed in your computer

4. **Run the container** typing in the Terminal/Command Prompt window:
   ```bash
   docker-compose up -d
A new folder named `rstudio-data` will appear in the installation folder. This will be the default root working directory, and RStudio will only access files within this directory. 

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

The installation will take about 45 minutes to complete from scratch. After installation, a new folder named `rstudio-data` will appear in the cloned folder. This will be the default root working directory, and RStudio will only access files within this directory.
Access RStudio: Open a web browser and go to:
   
5.
    ```bash
    localhost:8787

The RStudio GUI will appear and prompt you to log in. Use the following credentials:
- Username: rstudio
- Password: rstudio


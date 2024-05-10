# Shiny Applicatin to create postgresql National Soil Databases following the recommentations in ISO-28258 data model

This repository, which offers a standardized Dockerized version of RStudio adapted to the requirements of FAO-GSP training activities. This solution addresses common installation issues related to RStudio and its dependencies by providing a containerized environment that includes all necessary R packages to run the R scripts implemented at GSP. This approach ensures a consistent and conflict-free setup across different computing environments.

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
   docker-compose up -d

The 'yml' file creates two independent Docker images which containerize both PostgreSQL and Shiny. The containers are connected in a common network thus, it is possible the transfer of data between them. 

The PostgreSQL container is used to store and distribute soil standardized data according to ISO-28258 data model, which be stored locally in a new folder named `/data/postgis` in the mounting folder.

The Shiny Application consist in a Frontend to allow the easy exchange of soil data from common 'xlsx' files to the PosgreSQL following the requirements imposed in ISO-28258 data model. The Application do not require to store any specific data but it also provides a folder  named `r-scripts` which serve as a root path to Shiny.

4. **Enter Shiny in your web browser**: You can enter the Shiny application from your web browser just typing:
    ```bash
    localhost:3838

5. **Enter Rstudio in your web browser**. `User` and `password` have been set to:
    ```bash
    rstudio

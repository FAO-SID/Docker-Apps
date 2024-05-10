# Shiny Application to create PostgreSQL National Soil Databases following the recommentations in the ISO-28258 data model

This repository provides Dockerized software solutions adapted to FAO-GSP activities, focusing on the creation of PostgreSQL National Soil Databases adhering to the ISO-28258 data model. The containerized solution is designed to overcome common installation challenges associated with Postgres, R, Shiny and its dependencies, offering a reliable and consistent setup across different computing environments.

## Features
- Standardized Environment: The Dockerized applications simplifies the process of establishing a fully functional workspaces by removing system variability and conflicts typical with traditional installations.
- Ready-to-Use: Equipped with all necessary R packages to implement Soil Standard Databases, this setup is tested across various systems, proving its robustness and adaptability.
- User-Friendly: Comprehensive instructions are provided for building and running the Dockerized application, making it accessible for both novice and advanced users. The Docker configuration allows for easy updates and package additions.
- Resource Management: Ideal for environments requiring multiple users to access a standardized analytical toolset without resource conflicts.

## Architecture
The configuration deploys two Docker containers:

- PostgreSQL: Manages soil data in accordance with the ISO-28258 standard. Data is stored locally in the /data/postgis directory.
- Shiny Application: Provides a frontend interface for importing soil data from common 'xlsx' files to PostgreSQL. It also includes an 'r-scripts' folder that serves as the root path for the Shiny server.

Explore the documentation to deploy your Dockerized environment and streamline your setup process, ensuring a clean system and portable software.


## Quick Start: Using Image from Docker Hub

The simplest way to get started is to pull the Docker images directly from Docker Hub.

### Steps:
1. **Install Docker Desktop** on your computer.
2. **Download** the `docker-compose.yml` file into an empty folder.
3. **Navigate** to the folder with the 'docker-compose.yml' file using a Terminal/Command Prompt:   
   ```bash
   cd your_empty_folder
3. **Launch the containers** with the following command:
   ```bash
   docker-compose up -d

The 'yml' file install two Docker images in the system, which containerize both 'PostgreSQL' and 'Shiny'. The containers are connected in a common network thus, it is possible the transfer of data between them. 

4. **Access the Shiny Application**: Open your web browser and enter:
    ```bash
    localhost:3838


# Standardized Software Solutions for FAO-SID Activities

Welcome to this repository, offering standardized, Dockerized solutions for FAO-SID activities. These solutions address common software installation challenges and library dependency issues by providing a consistent, containerized environment with all necessary software requirements. This ensures a uniform and conflict-free setup across various computing environments.

The Dockerized setup simplifies creating a fully functional workspace, eliminating system variability and conflicts often encountered with traditional installation methods. It provides a quick, reliable solution for data analysis without the hassle of software configuration and dependency resolution.

## Features and Benefits
- **Robust and Adaptable:** Tested across different systems, the images demonstrate robustness and adaptability. Dockerfiles and detailed instructions are included to ensure seamless building and execution of software applications.
- **Flexible:** Easily update or extend the package list via simple Docker Hub image modifications.
- **Resource Management:** Ideal for environments where multiple users require access to a standardized analytical toolset without conflicts.

For beginners or those new to Docker, this repository serves as a valuable introduction to deploying and managing containerized applications. It promotes efficient resource management for environments needing standardized analytical tools.

## Current Implementations
- **Dockerized RStudio:** Includes complete Rstudio installation with all required R packages for mapping training activities at FAO-SID.
- **Multi-Container Environment PostgreSQL/PostGIS + Shiny:** Combines a PostgreSQL/PostGIS database server with a Shiny web application to build standardized national soil databases according to ISO-28258. These services share a network and have established dependencies.

## Quick Start: Using Image from Docker Hub

The simplest way to get started is to pull the Docker image directly from Docker Hub.

### Steps:
1. **Install Docker Desktop** on your computer.
2. **Clone this repository** to your computer and unzip it.
3. **Open a Terminal/Command Prompt** window and navigate to the unzipped folder (in this example 'my_folder') and to the folder with the application you want to install.
   ```bash
   cd my_folder/GLOSIS ISO 28258/
4. **Type in the Terminal/Command Prompt** window the following command:
   ```bash
   docker-compose up -d

More details about accessing the applications are provided in the specific installation folders.

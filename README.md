# Standardized Software Solutions for GloSIS

Welcome to this repository, offering standardized, Dockerized solutions for GloSIS activities. These solutions address common software installation challenges and library dependency issues by providing a consistent, containerized environment with all necessary software requirements. This ensures a uniform and conflict-free setup across various computing environments.

The Dockerized setup simplifies creating a fully functional workspace, eliminating system variability and conflicts often encountered with traditional installation methods. It provides a quick, reliable solution for data analysis without the hassle of software configuration and dependency resolution.

## Features and Benefits
- **Robust and Adaptable:** Tested across different systems, the images demonstrate robustness and adaptability. Dockerfiles and detailed instructions are included to ensure seamless building and execution of software applications.
- **Flexible:** Easily update or extend the package list via simple Docker Hub image modifications.
- **Resource Management:** Ideal for environments where multiple users require access to a standardized analytical toolset without conflicts.

For beginners or those new to Docker, this repository serves as a valuable introduction to deploying and managing containerized applications. It promotes efficient resource management for environments needing standardized analytical tools.

## Current Implementations
- **Dockerized RStudio:** Includes complete Rstudio installation with all required R packages for mapping training activities at FAO-SID.
- **Multi-Container Environment PostgreSQL/PostGIS + Shiny:** Combines a PostgreSQL/PostGIS database server with a Shiny web application to build standardized national soil databases according to ISO-28258. These services share a network and have established dependencies.


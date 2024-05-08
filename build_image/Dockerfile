# Dockerfile
# Base image from the Rocker project with RStudio pre-installed
FROM rocker/rstudio:4.3.1

# Install required system libraries for R packages
RUN apt-get update && \
    apt-get install -y \
        libudunits2-dev \
        libgdal-dev \
        libgeos-dev \
        libproj-dev \
        libssl-dev \
        libcurl4-openssl-dev \
        libxml2-dev \
        libxt-dev \
        libglu1-mesa-dev \
        g++ \
        tcl \
        tk \
        tcl-dev \
        tk-dev \
        && apt-get clean

# Install R packages from CRAN
RUN R -e "install.packages(c('sp', 'terra', 'raster', 'sf', 'clhs', 'sgsR', 'entropy', 'tripack', 'manipulate', 'dplyr', 'doSNOW', 'Rfast', 'remotes'), repos='https://cloud.r-project.org')"

# Install synoptReg from GitHub
RUN R -e "remotes::install_github('lemuscanovas/synoptReg')"

RUN R -e "install.packages(c('rstudioapi'), repos='https://cloud.r-project.org')"

RUN R -e "install.packages(c('tcltk'), repos='https://cloud.r-project.org')"

RUN R -e "install.packages(c('tidyverse','data.table','caret','quantregForest','doParallel'), repos='https://cloud.r-project.org')"

RUN R -e "install.packages(c('readxl','mapview','aqp','mpspline2','plotly'), repos='https://cloud.r-project.org')"


# Default port and user setup for RStudio Server
EXPOSE 8787

CMD ["/init"]

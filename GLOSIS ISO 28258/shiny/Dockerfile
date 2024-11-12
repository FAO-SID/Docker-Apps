FROM rocker/shiny:latest

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev \
    libudunits2-dev \
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Install required R packages
RUN R -e "install.packages(c('shiny', 'shinydashboard', 'shinycssloaders', 'shinyjs', 'flexdashboard', 'rpostgis', 'RPostgres', 'DBI', 'DT', 'crosstalk', 'leaflet', 'RColorBrewer', 'viridis', 'readxl', 'dplyr', 'reactable', 'sparkline', 'ggplot2', 'plotly', 'aqp', 'reactablefmtr'), dependencies=TRUE)"

RUN R -e "install.packages(c('digest', 'geohashTools', 'jsonlite'), dependencies=TRUE)"

RUN R -e "install.packages(c('utils'), dependencies=TRUE)"

RUN R -e "install.packages(c('shinythemes','tidyr', 'terra','sf','raster','stars'), dependencies=TRUE)"

# Copy the Shiny apps from the host
ADD ./r-scripts/ /srv/shiny-server/

EXPOSE 3838

CMD ["shiny-server"]

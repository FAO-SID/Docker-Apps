# To remove all existing images, containers and databases, run the following commands in your docker-compose.yml folder
docker stop $(docker ps -q)
docker rm $(docker ps -aq)
docker rmi $(docker images -q) --force
docker network prune -f
docker volume prune -f
docker system prune -a --volumes -f


# To create a new installation of the apps, run the following commands in your docker-compose.yml folder:
cd /home/carva014/Work/Code/FAO/Docker-Apps/GloSIS-database
docker-compose up --build -d
ll


# check container
docker ps --all


# Get sample data for MapServer
wget https://storage.googleapis.com/fao-maps-catalog-data/geonetwork/gsoc/GSOCmap/GSOCmap1.5.0.tif


# Generate overviews
cp GSOCmap1.5.0.tif GSOC_tmp.tif
gdaladdo -r bilinear GSOC_tmp.tif


# Tilling and indexing
gdal_translate \
    -of COG \
    -a_srs EPSG:4326 \
    -co COMPRESS=DEFLATE \
    -co PREDICTOR=2 \
    -a_nodata -3.39999995214436425e+38 \
    GSOC_tmp.tif \
    GSOC.tif

rm GSOCmap1.5.0.tif
rm GSOC_tmp.tif
mv GSOC.tif /home/carva014/Work/Code/FAO/Docker-Apps/GloSIS-database/data/mapserver/GSOC.tif
cp /home/carva014/Work/Code/FAO/Docker-Apps/GloSIS-database/test_data/mapserver/getfeatureinfo.tmpl /home/carva014/Work/Code/FAO/Docker-Apps/GloSIS-database/data/mapserver/getfeatureinfo.tmpl
cp /home/carva014/Work/Code/FAO/Docker-Apps/GloSIS-database/test_data/mapserver/GSOC.map /home/carva014/Work/Code/FAO/Docker-Apps/GloSIS-database/data/mapserver/GSOC.map


# GetCapabilities
http://localhost:8082/?map=/etc/mapserver/GSOC.map&SERVICE=WMS&REQUEST=GetCapabilities
# GetMap
http://localhost:8082/?map=/etc/mapserver/GSOC.map&SERVICE=WMS&VERSION=1.3.0&REQUEST=GetMap&CRS=EPSG:4326&BBOX=-60,-180,85,180&WIDTH=800&HEIGHT=400&LAYERS=GSOC&STYLES=default&FORMAT=image/png
# GetLegendGraphic
http://localhost:8082/?map=/etc/mapserver/GSOC.map&SERVICE=WMS&VERSION=1.1.1&LAYER=GSOC&REQUEST=getlegendgraphic&FORMAT=image/png
# GetFeatureInfo
http://localhost:8082/?map=/etc/mapserver/GSOC.map&SERVICE=WMS&VERSION=1.3.0&REQUEST=GetFeatureInfo&BBOX=537861,6757475,734631,6932972&CRS=EPSG:3857&WIDTH=1073&HEIGHT=957&LAYERS=GSOC&STYLES=default&FORMAT=image/png&QUERY_LAYERS=GSOC&INFO_FORMAT=text/html&I=389&J=589
# QGIS add WMS layer
http://localhost:8082/?map=/etc/mapserver/GSOC.map






# # drop db if already exists
# docker exec -it glosis_db psql -d postgres -U glosis -c "DROP DATABASE IF EXISTS iso28258"

# # create db
# docker exec -it glosis_db psql -d postgres -U glosis -c "CREATE DATABASE iso28258 WITH OWNER = glosis TEMPLATE = postgres"

# # remove unnecessary schemas and extensions
# docker exec -it glosis_db psql -d iso28258 -U glosis -c "DROP EXTENSION postgis_tiger_geocoder"
# docker exec -it glosis_db psql -d iso28258 -U glosis -c "DROP EXTENSION postgis_topology"
# docker exec -it glosis_db psql -d iso28258 -U glosis -c "DROP EXTENSION fuzzystrmatch"
# docker exec -it glosis_db psql -d iso28258 -U glosis -c "DROP SCHEMA IF EXISTS tiger"
# docker exec -it glosis_db psql -d iso28258 -U glosis -c "DROP SCHEMA IF EXISTS tiger_data"
# docker exec -it glosis_db psql -d iso28258 -U glosis -c "DROP SCHEMA IF EXISTS topology"

# # create objects
# docker cp /home/carva014/Work/Code/FAO/glosis-db/ISO_28258_ISRIC_v1.5_changed.sql glosis_db:/tmp/init.sql
# docker exec -it glosis_db psql -d iso28258 -U glosis -f /tmp/init.sql

# # db is running on localhost::5442

###############################################
#                Data Cube
###############################################


# Working directory
INPUT_DIR="/home/carva014/Downloads/FAO/SIS/PH"
REF_GEOTIFF=$INPUT_DIR/tmp/PHL_Subsoil_ESP30_100_step1.tif
cd $INPUT_DIR
ls -hl


# Chcek NoData values before start processing
for FILE in *.tif;
do 
    gdalinfo "$FILE" | grep NoData
done


# STEP 1: Put all layers in the same EPSG:32651
mkdir tmp
for FILE in *.tif; 
do
    BASENAME=$(basename -s .tif "$FILE")
    gdalwarp -r bilinear -dstnodata -9999 -t_srs EPSG:32651 "$FILE" ./tmp/"$BASENAME"_step1.tif
done


# Chcek raster details
cd tmp
for FILE in *_step1.tif;
do 
    gdalinfo "$FILE" | grep Origin
done

for FILE in *_step1.tif;
do 
    gdalinfo "$FILE" | grep "Size is"
done

for FILE in *_step1.tif;
do 
    gdalinfo "$FILE" | grep "Pixel Size"
done


# Set a uniform resolution (pixel size): 0.0083333333 dd / 1000 meters
# Determine the common bounding box (extent): Calculate the smallest rectangle that encompasses all GeoTIFFs:

    # Minimum X (left): The smallest origin X of all.
    # Maximum X (right): Origin X + (Width x Pixel Size) for all.
    # Minimum Y (bottom): Origin Y + (HEIGHT x Pixel Size) for all.
    # Maximum Y (top): The largest origin Y of all.

    # Max X = 116.924998812300032 + (1162 x 0.0083333333) = 126.61
    # Min Y = 21.124414830380886 - (1984 x 0.0083333333)  = 4.59

ORIGIN_X=$(gdalinfo $REF_GEOTIFF | grep "Origin" | awk -F'[(),]' '{print $2}')
ORIGIN_Y=$(gdalinfo $REF_GEOTIFF | grep "Origin" | awk -F'[(),]' '{print $3}')
WIDTH=$(gdalinfo $REF_GEOTIFF | grep "Size is" | awk '{print $3}' | sed 's/,//')
HEIGHT=$(gdalinfo $REF_GEOTIFF | grep "Size is" | awk '{print $4}')
PIXEL_SIZE=$(gdalinfo $REF_GEOTIFF | grep "Pixel Size" | awk -F'[(),]' '{print $2}')

echo $ORIGIN_X
echo $ORIGIN_Y
echo $WIDTH
echo $HEIGHT
echo $PIXEL_SIZE

# In case you would like to override the previouse values, from a reference GeoTIFF
PIXEL_SIZE=1000

X_MIN=$ORIGIN_X
Y_MIN=$(echo "$ORIGIN_Y-($HEIGHT*$PIXEL_SIZE)" | bc)
X_MAX=$(echo "$ORIGIN_X+($WIDTH*$PIXEL_SIZE)" | bc)
Y_MAX=$ORIGIN_Y

echo $X_MIN, $Y_MIN, $X_MAX, $Y_MAX


# STEP 2: Align GeoTIFF's
for FILE in *_step1.tif;
do
    gdalwarp -r bilinear -tr $PIXEL_SIZE $PIXEL_SIZE -te $X_MIN $Y_MIN $X_MAX $Y_MAX "$FILE" ${FILE/_step1/_step2}
done


# STEP 3: Generate overviews
for FILE in *_step2.tif;
do
    cp "$FILE" ${FILE/_step2/_step3}
    gdaladdo -r bilinear ${FILE/_step2/_step3}
done


# STEP 4: Tilling and indexing
for FILE in *_step3.tif;
do
    gdal_translate \
        -of COG \
        -a_srs EPSG:32651 \
        -co COMPRESS=DEFLATE \
        -co PREDICTOR=2 \
        $FILE \
        ${FILE/_step3/_step4}
done


# Coping COG files (step4 files) to a final folder (COG)
cd ..
mkdir COG
cp  ./tmp/*_step4.tif ./COG/
cd COG
for FILE in ./*;
do
    NEWNAME="${FILE//_step4/}"
    mv "$FILE" "$NEWNAME"
done


# Verify
for FILE in *.tif;
do 
    gdalinfo "$FILE" | grep NoData
done
for FILE in *.tif;
do 
    gdalinfo "$FILE" | grep Origin
done

for FILE in *.tif;
do 
    gdalinfo "$FILE" | grep "Size is"
done

for FILE in *.tif;
do 
    gdalinfo "$FILE" | grep "Pixel Size"
done


# The folder tmp can me deleted
cd ..
rm -Rf ./tmp/


# gdalinfo -stats /home/carva014/Downloads/FAO/SIS/PH/PHL_ak_0_30_Mean.tif nan -> -9999.000
# gdalinfo -stats /home/carva014/Downloads/FAO/SIS/PH/PHL_GSAS_Top0_30PH.tif nothing -> 6,248272
# gdalinfo -stats /home/carva014/Downloads/FAO/SIS/PH/PHL_GSOCseq_ASR_BAU_Map030.tif 0 -> 0 & -99999
# gdalinfo -stats /home/carva014/Downloads/FAO/SIS/PH/PHL_OCS.tif nan -> -9999.000
# gdalinfo -stats /home/carva014/Downloads/FAO/SIS/PH/PHL_RSR_SSM1.tif nan -> -9999.000
# gdalinfo -stats /home/carva014/Downloads/FAO/SIS/PH/PHL_RSR_SSM1_UncertaintyMap030.tif nan -> -9999.000
# gdalinfo -stats /home/carva014/Downloads/FAO/SIS/PH/PHL_RSR_SSM2.tif nan -> -9999.000
# gdalinfo -stats /home/carva014/Downloads/FAO/SIS/PH/PHL_RSR_SSM2_UncertaintyMap030.tif nan -> -9999.000
# gdalinfo -stats /home/carva014/Downloads/FAO/SIS/PH/PHL_RSR_SSM3.tif nan -> -9999.000
# gdalinfo -stats /home/carva014/Downloads/FAO/SIS/PH/PHL_RSR_SSM3_UncertaintyMap030.tif nan -> -9999.000
# gdalinfo -stats /home/carva014/Downloads/FAO/SIS/PH/PHL_subsoil_EC30_100.tif nan -> -9999.000
# gdalinfo -stats /home/carva014/Downloads/FAO/SIS/PH/PHL_Subsoil_ESP30_100.tif nan -> -9999.000
# gdalinfo -stats /home/carva014/Downloads/FAO/SIS/PH/PHL_Subsoil_PH30_100.tif nan -> -9999.000
# gdalinfo -stats /home/carva014/Downloads/FAO/SIS/PH/PHL_Subsoil_SAS30_100.tif nan -> -9999.000
# gdalinfo -stats /home/carva014/Downloads/FAO/SIS/PH/PHL_Top0_30ESP_uncert.tif nan -> -9999.000
# gdalinfo -stats /home/carva014/Downloads/FAO/SIS/PH/PHL_TopEC0_30.tif nan -> -9999.000
# gdalinfo -stats /home/carva014/Downloads/FAO/SIS/PH/PHL_Topsoil_ESP0_30.tif nan -> -9999.000
# gdalinfo -stats /home/carva014/Downloads/FAO/SIS/PH/PHL_Topsoil_PH0_30.tif nan -> -9999.000
# gdalinfo -stats /home/carva014/Downloads/FAO/SIS/PH/PHL_TopsoilSAS0_30.tif nan -> -9999.000


# # NoData from -99999 to -9999, like all the other rasters
# gdal_calc.py -A PHL_GSOCseq_ASR_BAU_Map030.tif --outfile=PHL_GSOCseq_ASR_BAU_Map030_B.tif --calc="A*(A!=-99999) + -9999*(A==-99999)" --NoDataValue=-9999
# gdalinfo -stats PHL_GSOCseq_ASR_BAU_Map030.tif
# gdalinfo -stats PHL_GSOCseq_ASR_BAU_Map030_B.tif
# rm PHL_GSOCseq_ASR_BAU_Map030.tif
# mv PHL_GSOCseq_ASR_BAU_Map030_B.tif PHL_GSOCseq_ASR_BAU_Map030.tif


# # NoData not defined to 6,248272, and then to -9999, like the rest
# gdalinfo -stats PHL_GSAS_Top0_30PH.tif
# # Minimum=4.446, Maximum=7.825, Mean=6.169, StdDev=0.229
# gdal_translate -a_nodata 6,248272 PHL_GSAS_Top0_30PH.tif PHL_GSAS_Top0_30PH_B.tif
# gdalinfo -stats PHL_GSAS_Top0_30PH_B.tif
# # Minimum=4.446, Maximum=7.825, Mean=6.169, StdDev=0.229
# # NoData Value=6.24827194213867188
# gdal_calc.py -A PHL_GSAS_Top0_30PH.tif --outfile=PHL_GSAS_Top0_30PH_C.tif --calc="A*(A!=6.248272) + -9999*(A==6.248272)" --NoDataValue=-9999
# gdalinfo -stats PHL_GSAS_Top0_30PH_C.tif
# # Minimum=4.446, Maximum=7.825, Mean=5.805, StdDev=0.363
# # NoData Value=-9999
# rm PHL_GSAS_Top0_30PH.tif
# rm PHL_GSAS_Top0_30PH_B.tif
# mv PHL_GSAS_Top0_30PH_C.tif PHL_GSAS_Top0_30PH.tif

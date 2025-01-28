#!/bin/bash

###############################################
#                   NoData                    #
###############################################

# Input, output directories and conventional NoData value
INPUT_DIR="/home/carva014/Downloads/FAO/SIS/VNM"                        # << EDIT THIS LINE!
OUTPUT_DIR="/home/carva014/Downloads/FAO/SIS/VNM_NoData"                # << EDIT THIS LINE!
NODATA=-1                                                               # << EDIT THIS LINE!
cd $INPUT_DIR

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Chcek NoData values before start processing
echo "########################"
echo "#        Before        #"
echo "########################"
printf "%-8s %-8s %-12s %-12s %-8s %s\n" "Minimum" "Maximum" "Mean" "StdDev" "NoData" "File"
for FILE in *.tif; do
    BASENAME=$(basename "$FILE")
    # Get GeoTIFF stats
    CURRENT_NODATA=$(gdalinfo "$FILE" | grep "NoData Value=" | awk -F'NoData Value=' '{print $2}')
    MIN=$(gdalinfo -stats "$FILE" | grep "Minimum=" | awk -F'Minimum=' '{print $2}' | awk -F',' '{print $1}')
    MAX=$(gdalinfo -stats "$FILE" | grep "Minimum=" | awk -F'Maximum=' '{print $2}' | awk -F',' '{print $1}')
    MEA=$(gdalinfo -stats "$FILE" | grep "Minimum=" | awk -F'Mean=' '{print $2}' | awk -F',' '{print $1}')
    STD=$(gdalinfo -stats "$FILE" | grep "Minimum=" | awk -F'StdDev=' '{print $2}' | awk -F',' '{print $1}')
    printf "%-8s %-8s %-12s %-12s %-8s %s\n" "$MIN" "$MAX" "$MEA" "$STD" "$CURRENT_NODATA" "$BASENAME"
done

# # Dealing with Nodata values
# gdal_calc.py -A Sub30_100ECse.tif --outfile=Sub30_100ECse_NoData.tif --calc="A*(A!=0.1270795613527298) + -1*(A==0.1270795613527298)" --NoDataValue=-1
# gdal_calc.py -A Sub30_100ESP.tif --outfile=Sub30_100ESP_NoData.tif --calc="A*(A!=6.29727840423584) + -1*(A==6.29727840423584)" --NoDataValue=-1
# gdal_calc.py -A Sub30_100PH.tif --outfile=Sub30_100PH_NoData.tif --calc="A*(A!=6.0150837898254395) + -1*(A==6.0150837898254395)" --NoDataValue=-1
# gdal_calc.py -A Sub30_100saltaffected.tif --outfile=Sub30_100saltaffected_NoData.tif --calc="A*(A!=2) + -1*(A==2)" --NoDataValue=-1
# gdal_calc.py -A Top0_30ECse.tif --outfile=Top0_30ECse_NoData.tif --calc="A*(A!=0.23120065033435822) + -1*(A==0.23120065033435822)" --NoDataValue=-1
# gdal_calc.py -A Top0_30ESP.tif --outfile=Top0_30ESP_NoData.tif --calc="A*(A!=3.2343051433563232) + -1*(A==3.2343051433563232)" --NoDataValue=-1
# gdal_calc.py -A Top0_30PH.tif --outfile=Top0_30PH_NoData.tif --calc="A*(A!=6.248271942138672) + -1*(A==6.248271942138672)" --NoDataValue=-1
# gdal_calc.py -A Top0_30saltaffected.tif --outfile=Top0_30saltaffected_NoData.tif --calc="A*(A!=1) + -1*(A==1)" --NoDataValue=-1
# gdal_calc.py -A PHL_GSOCseq_ASR_BAU_Map030.tif --outfile=PHL_GSOCseq_ASR_BAU_Map030_NoData.tif --calc="A*(A!=-99999) + -9999*(A==-99999)" --NoDataValue=-9999

# Replace -9999 values with -1 and assign -1 as NoData so it is not taken into account when doing calculations
echo
echo "Assigning NoData value $NODATA"
echo
for FILE in *.tif; do
    BASENAME=$(basename "$FILE")
    OUTPUT_FILE="$OUTPUT_DIR/$BASENAME"
    MEA=$(gdalinfo -stats "$FILE" | grep "Minimum=" | awk -F'Mean=' '{print $2}' | awk -F',' '{print $1}')
    if [ "$MEA" != "-9999" ]; then
        gdal_calc.py --quiet -A $FILE --outfile=$OUTPUT_FILE --calc="A*(A!=-9999) + $NODATA*(A==-9999)" --NoDataValue=$NODATA
    fi
done

# Loop through GeoTIFFs with fixed NoData values
echo "########################"
echo "#        After         #"
echo "########################"
printf "%-8s %-8s %-12s %-12s %-8s %s\n" "Minimum" "Maximum" "Mean" "StdDev" "NoData" "File"
for FILE in "$OUTPUT_DIR"/*.tif; do
    BASENAME=$(basename "$FILE")
    # Get GeoTIFF stats
    CURRENT_NODATA=$(gdalinfo "$FILE" | grep "NoData Value=" | awk -F'NoData Value=' '{print $2}')
    MIN=$(gdalinfo -stats "$FILE" | grep "Minimum=" | awk -F'Minimum=' '{print $2}' | awk -F',' '{print $1}')
    MAX=$(gdalinfo -stats "$FILE" | grep "Minimum=" | awk -F'Maximum=' '{print $2}' | awk -F',' '{print $1}')
    MEA=$(gdalinfo -stats "$FILE" | grep "Minimum=" | awk -F'Mean=' '{print $2}' | awk -F',' '{print $1}')
    STD=$(gdalinfo -stats "$FILE" | grep "Minimum=" | awk -F'StdDev=' '{print $2}' | awk -F',' '{print $1}')
    printf "%-8s %-8s %-12s %-12s %-8s %s\n" "$MIN" "$MAX" "$MEA" "$STD" "$CURRENT_NODATA" "$BASENAME"
done

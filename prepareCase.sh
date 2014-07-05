#!/bin/bash

### CLEAR THE 0 DIRECTORY
(cd 0; rm -f *)

. $PWD/../../../bin/bashrc noPrint

### COPY RELEVANT FIELDS

# Copy the void fraction field
if [ $WM_PROJECT_VERSION_NUMBER -lt 230 ]
then
    sed 's/object      alpha.org;/object      alpha1;/' < 0.org/alpha1.org > 0/alpha1
elif [ $FOAMEXTENDPROJECT -eq 1 ]
then
    sed 's/object      alpha.org;/object      alpha1;/' < 0.org/alpha1.org > 0/alpha1
else
    sed 's/object      alpha.org;/object      alpha.water;/' < 0.org/alpha1.org > 0/alpha.water
fi

# Copy the pressure field
if [ $WM_PROJECT_VERSION_NUMBER -lt 170 ]
then
    sed 's/object      pd.org;/object      pd;/' < 0.org/pd.org > 0/pd
elif [ $FOAMEXTENDPROJECT -eq 1 ]
then
    sed 's/object      pd.org;/object      pd;/' < 0.org/pd.org > 0/pd
else
    sed 's/object      pd.org;/object      p_rgh;/' < 0.org/pd.org > 0/p_rgh
fi

# Copy the velocity field
cp 0.org/U.org 0/U

### COPY FVSOLUTION AND FVSCHEMES
source="system/fvFiles"
target="system"

if [ $WM_PROJECT_VERSION_NUMBER -lt 170 ]
then
    cp $source/fvSolution.16 $target/fvSolution
    cp $source/fvSchemes.16 $target/fvSchemes
elif [ $FOAMEXTENDPROJECT -eq 1 ]
then
    cp -f $source/fvSolution.f30 $target/fvSolution
    cp -f $source/fvSchemes.f30 $target/fvSchemes
elif [ $WM_PROJECT_VERSION_NUMBER -lt 210 ]
then
    cp $source/fvSolution.17 $target/fvSolution
    cp $source/fvSchemes.17 $target/fvSchemes
elif [ $WM_PROJECT_VERSION_NUMBER -lt 230 ]
then
    cp $source/fvSolution.21 $target/fvSolution
    cp $source/fvSchemes.21 $target/fvSchemes
else
    cp $source/fvSolution.23 $target/fvSolution
    cp $source/fvSchemes.23 $target/fvSchemes
fi

### COPY TRANSPORTPROPERTIES
if [ $WM_PROJECT_VERSION_NUMBER -lt 230 -o $FOAMEXTENDPROJECT -eq 1 ]
then
    cp ../../commonFiles/transportProperties.16 constant/transportProperties
else
    cp ../../commonFiles/transportProperties.23 constant/transportProperties
fi



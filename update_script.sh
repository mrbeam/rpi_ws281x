#!/usr/bin/env bash

sudo rm -rf rpi_ws281x
if [ $? -ne 0 ]
then
   echo "Could not delete old repository!"
   exit 1
fi

git clone https://github.com/mrbeam/rpi_ws281x.git
if [ $? -ne 0 ]
then
   echo "Could not clone new repository!"
   exit 1
fi

pushd rpi_ws281x
   scons
   if [ $? -ne 0 ]
   then
      echo "Something went wrong during the scons software build!"
      exit 1
   fi

   pushd python
      python setup.py build
      if [ $? -ne 0 ]
      then
         echo "Something went wrong during the python setup.py build!"
         exit 1
      fi

      sudo pip uninstall -y rpi-ws281x
      if [ $? -ne 0 ]
      then
         echo "Could not uninstall the previous rpi-ws281x package!"
         exit 1
      fi

      sudo pip install .
      if [ $? -ne 0 ]
      then
         echo "Could not install the new rpi-ws281x package!"
         exit 1
      fi
   popd
popd

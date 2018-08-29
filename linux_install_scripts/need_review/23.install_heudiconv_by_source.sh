#!/bin/bash

if [ "$#" -lt 1 ];then
	echo "Usage: $0 <install folder (absolute path)>"
	echo "For sudoer recommend: $0 /opt"
	echo "For normal user recommend: $0 $HOME/app"
	exit 0
fi

echo -n "installing heudiconv..." #-n without newline

DEST=$1
mkdir -p $DEST

D_DIR=$DEST/heudiconv
if [ -d $D_DIR ]; then
	rm -rf $D_DIR
fi

mkdir -p $D_DIR

#pydicom #installed when install nipype 
#dcmstack  eash_install .zip(download and save to dropbox)
#nipype  #installed by my script
#nibabel #installed when install nipype
#dcm2niix

#installing heudiconv...23.install_heudiconv_by_source.sh: line 28: conda: command not found
#23.install_heudiconv_by_source.sh: line 29: pip: command not found

#conda install -y -c conda-forge nipype 
#pip install https://github.com/moloney/dcmstack/archive/c12d27d2c802d75a33ad70110124500a83e851ee.zip

cd $D_DIR
wget https://raw.githubusercontent.com/nipy/heudiconv/master/bin/heudiconv
chmod +x heudiconv
cd

# conda install -y -c conda-forge nipype && \
#     conda install cmake && \
#     pip install https://github.com/moloney/dcmstack/archive/c12d27d2c802d75a33ad70110124500a83e851ee.zip && \


#ImportError: /usr/lib/libblas.so.3: undefined symbol: gotoblas
#fix:#sudo apt-get remove libopenblas-base
#you got two libblas.so.3
#/usr/lib/libblas/libblas.so.3
#/usr/lib/openblas-base/libblas.so.3


#/opt/heudiconv/heudiconv -b -d /mnt/hgfs/data/7T_BIDS/dicoms/{subject}/*IMA -s 001 -f /mnt/hgfs/data/7T_BIDS/7T_TOPSY_BIDS_heuristic.py -c dcm2niix -b -o ./output

#/opt/heudiconv/heudiconv -b -d /mnt/hgfs/data/{subject}/*.dcm -s 0001 -f /mnt/hgfs/data/convertall.py -c dcm2niix -b -o ./output


#singularity exec -B /mnt/hgfs/data:data neuroimage.img heudiconv -b -d /data/7T_BIDS/dicoms/{subject}/*.IMA -s 001 -f /data/7T_BIDS/7T_TOPSY_BIDS_heuristic.py -c dcm2niix -b -o /data/output

#pydicom  
#dcmstack 
#nipype
#nibabel
#dcm2niix

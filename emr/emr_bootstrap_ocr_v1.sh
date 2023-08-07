#!/bin/bash
set -x -e

echo -e 'export PYSPARK_PYTHON=/usr/bin/python3 
export HADOOP_CONF_DIR=/etc/hadoop/conf 
export SPARK_JARS_DIR=/usr/lib/spark/jars 
export SPARK_HOME=/usr/lib/spark' >> $HOME/.bashrc && source $HOME/.bashrc

echo "$1"
version=`echo "$1" | cut -d\- -f1`
echo "$version"

sudo python3 -m pip install --upgrade pip setuptools
sudo python3 -m pip install numpy==1.21.5 pillow==9.0.1 imageio==2.16.0 pip ipython spark-nlp==3.4.0
sudo python3 -m pip install --upgrade spark-ocr==$version+spark30 --extra-index-url=https://pypi.johnsnowlabs.com/$1

#sudo wget https://www.dropbox.com/s/f0o8flw8v2we3h3/spark-ocr-assembly-3.11.0-spark30.jar -P /usr/lib/spark/jars
sudo wget https://pypi.johnsnowlabs.com/$1/jars/spark-ocr-assembly-$version-spark30.jar -P /usr/lib/spark/jars
sudo mv /usr/lib/spark/jars/spark-ocr-assembly-$version-spark30.jar /usr/lib/spark/jars/spark-ocr-assembly-$version-spark301+amzn.jar
sudo wget https://s3.amazonaws.com/auxdata.johnsnowlabs.com/public/jars/spark-nlp-assembly-3.4.0.jar -P /usr/lib/spark/jars

set +x
exit 0

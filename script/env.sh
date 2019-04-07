#!/bin/bash

echo "
export SPARK_HOME=/opt/spark
export LIVY_HOME=/opt/livy
export PATH=$PATH:$SPARK_HOME/bin:$LIVY_HOME/bin
" >> ~/.bashrc

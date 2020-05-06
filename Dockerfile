FROM python:3.7-slim

ENV SPARK_VERSION 2.4.5
ENV HADOOP_VERSION 2.7
ENV SPARK_HOME /opt/spark
ENV JAVA_HOME /opt/java
ENV LD_LIBRARY_PATH /opt/hadoop/lib/native
ENV PATH $SPARK_HOME/bin:$JAVA_HOME/bin:$PATH
ENV HOME /root

RUN \
  mkdir -p /usr/share/man/man1 && \
  apt-get update && apt-get install -y ssh rsync vim sudo zip wget

COPY lib/native ${LD_LIBRARY_PATH}

RUN \
  wget https://raw.githubusercontent.com/bhavik9243/openjdk-binaries/master/open-jdk/download/OpenJDK8U-jre_x64_linux_hotspot_8u252b09.tar.gz && \
  tar xzf OpenJDK8U-jre_x64_linux_hotspot_8u252b09.tar.gz && \
  mv jdk8u252-b09-jre ${JAVA_HOME} && \
  rm -rf OpenJDK8U-jre_x64_linux_hotspot_8u252b09.tar.gz && \
  wget http://mirrors.estointernet.in/apache/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
  tar xzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
  mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} ${SPARK_HOME} && \
  rm -rf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
  pip install jupyter pandas boto3

WORKDIR ${HOME}

RUN ipython profile create pyspark && jupyter notebook --generate-config
RUN mkdir -p .ipython/kernels/pyspark
COPY config/00-default-setup.py .ipython/profile_pyspark/startup/
COPY config/00-default-setup.py .ipython/profile_default/startup/
COPY config/kernel.json .ipython/kernels/pyspark
COPY config/jupyter_notebook_config.py .jupyter/

CMD ["jupyter","notebook"]
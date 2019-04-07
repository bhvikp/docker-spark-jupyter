FROM continuumio/miniconda3:latest

ENV SPARK_HOME /opt/spark
ENV LIVY_HOME /opt/livy
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV HOME /root

RUN \
  apt-get update && apt-get install -y \
  ssh \
  rsync \
  vim \
  sudo \
  zip \
  openjdk-8-jdk

RUN pip install jupyter

COPY script/env.sh .

RUN \
  wget http://mirrors.estointernet.in/apache/hadoop/common/hadoop-3.1.2/hadoop-3.1.2.tar.gz && \
  wget http://mirrors.estointernet.in/apache/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz && \
  mkdir -p ${HOME}/notebooks && \
  tar xzf spark-2.4.0-bin-hadoop2.7.tgz && \
  unzip livy-0.5.0-incubating-bin.1.zip && \
  mv spark-2.4.0-bin-hadoop2.7 $SPARK_HOME && \
  mv livy-0.5.0-incubating-bin $LIVY_HOME && \
  chmod +x env.sh && bash env.sh && \
  rm -rf spark-2.4.0-bin-hadoop2.7.tgz livy-0.5.0-incubating-bin.1.zip env.sh

WORKDIR ${HOME}

RUN ipython profile create pyspark
RUN mkdir -p .ipython/kernels/pyspark
COPY config/00-default-setup.py .ipython/profile_pyspark/startup/
COPY config/00-default-setup.py .ipython/profile_default/startup/
COPY config/kernel.json .ipython/kernels/pyspark

RUN jupyter notebook --generate-config
COPY config/jupyter_notebook_config.py .jupyter/

ENV PATH /opt/conda/envs/env/bin:$PATH

EXPOSE 8998 4040 8888

CMD ["jupyter","notebook"]

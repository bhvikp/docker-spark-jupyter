# docker-spark-jupyter
Dockerized development environment with spark, jupyter

### Features!

    - Apache Spark 2.4.5
    - Jupyter Notebook
    - Pandas
    - Boto3
    - AWSCLI

### Installation

Pull docker image from docker hub repository
```sh
$ docker pull bhavik9243/datascience-book:latest
```

### Run/Start/Stop Container

```sh
$ docker run -itd --name ds_book --hostname localhost -v $PWD/notebooks:/root/notebooks -p 8888:8888 -p 4040:4040 bhavik9243/datascience-book:latest
$ docker start ds_book
$ docker stop ds_book
```

### Jupyter Access

> **Jupyter Notebook** : [http://127.0.0.1:8888](http://127.0.0.1:8888)
>
> **Password** : `letmein`

#### Enjoy :)
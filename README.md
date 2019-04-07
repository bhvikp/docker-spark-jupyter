# docker-spark-jupyter-livy
Dockerized development environment with spark, jupyter, livy

### Features!

    - Apache Spark 2.4.0
    - Jupyter Notebook
    - Conda Environment
    - Apache Livy
    - Sklearn
    - Tensorflow

### Installation

Pull docker image from docker hub repository
```sh
$ docker pull bhavik9243/datascience-book:latest
```

### Run/Start/Stop Container

```sh
$ docker run -itd --name ds_book --hostname localhost -p 8888:8888 -p 8998:8998 -p 4040:4040 bhavik9243/datascience-book:latest
$ docker start ds_book
$ docker stop ds_book
```

### Jupyter Access

> **Jupyter Notebook** : [http://127.0.0.1:8888](http://127.0.0.1:8888)
> **Password** : `letmein`

#### Enjoy!! :)
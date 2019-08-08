FROM python:3.6-buster

RUN useradd -Urm -d /opt/airflow airflow
RUN pip install cryptography apache-airflow 'apache-airflow[postgres,kubernetes,crypto]'

RUN mkdir /opt/data-pipeline
VOLUME /opt/data-pipeline

USER airflow
COPY ./configure.sh /opt/airflow
RUN mkdir /opt/airflow/logs
WORKDIR /opt/airflow
EXPOSE 8080
ENTRYPOINT [ "/usr/local/bin/airflow" ]

# Infrastructure

* Infrastructure
    * [Postgres Operator](https://github.com/CrunchyData/postgres-operator) (Crunchy Data)
        * [PostgreSQL](https://www.postgresql.org/)
        * [pgAdmin](https://www.pgadmin.org/)
    * [MariaDB](https://mariadb.org/)
        * [phpMyAdmin](https://www.phpmyadmin.net/)
    * [RabbitMQ Cluster Operator](https://www.rabbitmq.com/kubernetes/operator/operator-overview.html)
        * [RabbitMQ](https://www.rabbitmq.com/)
    * [Redis Operator](https://docs.redis.com/latest/kubernetes/architecture/operator/)
        * [Redis](https://docs.redis.com/latest/)
* Monitoring
    * [Prometheus Operator](https://prometheus-operator.dev/)
    * [Prometheus](https://prometheus.io/)
        * [Node Exporter](https://github.com/prometheus/node_exporter)
    * [Grafana](https://grafana.com/grafana/)
        * [Promtail](https://grafana.com/docs/loki/latest/clients/promtail/)
    * [Grafana Loki](https://grafana.com/oss/loki/)

## Prometheus - Infrastructure

Infrastructure are collected by it's own instance of Prometheus.

## PostgreSQL

Various services require PostgreSQL to store their data, including other parts of the infrastructure like Harbor. 

### CrunchData PostgreSQL Operator

## Redis Cluster

Cache and data service

## RabbitMQ Cluster

Messaging:
* Queues
* Event topics
* Streams
* MQTT

### Enabling management

### Enabling MQTT

## MariaDB

**To do**

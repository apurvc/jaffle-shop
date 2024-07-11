FROM ghcr.io/dbt-labs/dbt-bigquery:1.8.2
USER root
WORKDIR /dbt

COPY script.sh ./
COPY jaffle-data ./

ENTRYPOINT "./script.sh"
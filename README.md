# A Fork of Jaffle shop github repo to setup against Bigquery

# 🥪 The Jaffle Shop BigQuery Fork 🦘
*Original repository here https://github.com/dbt-labs/jaffle-shop*

**Setup you can run in cloud shell**

```bash
python -m venv dbt-env
source dbt-env/bin/activate
(optional) pip install -r requirements.txt (if you want to generate sample data)
pip install dbt-core dbt-bigquery
```

2. Update **GCP project id** in `profiles.yml` and then run `dbt deps` to test if the configs are correct for you to run against BigQuery.

```bash
dbt deps # installs the dependency defined in packages.yml

dbt debug # test connection with bigquery and profile is correctly setup

Sample run

(dbt-env) cloud_user_p_448bd91e@cloudshell:~/jaffle-shop (playground)$ dbt debug
17:06:27  Running with dbt=1.8.3
17:06:27  dbt version: 1.8.3
17:06:27  python version: 3.10.12
17:06:27  python path: /home/cloud_user_p_448bd91e/dbt-env/bin/python
17:06:27  os info: Linux-6.1.85+-x86_64-with-glibc2.35
17:06:27  Using profiles dir at /home/cloud_user_p_448bd91e/jaffle-shop
17:06:27  Using profiles.yml file at /home/cloud_user_p_448bd91e/jaffle-shop/profiles.yml
17:06:27  Using dbt_project.yml file at /home/cloud_user_p_448bd91e/jaffle-shop/dbt_project.yml
17:06:27  adapter type: bigquery
17:06:27  adapter version: 1.8.2
17:06:28  Configuration:
17:06:28    profiles.yml file [OK found and valid]
17:06:28    dbt_project.yml file [OK found and valid]
17:06:28  Required dependencies:
17:06:28   - git [OK found]

17:06:28  Connection:
17:06:28    method: oauth
17:06:28    database: None
17:06:28    execution_project: None
17:06:28    schema: dbt_jaffle
17:06:28    location: us
17:06:28    priority: interactive
17:06:28    maximum_bytes_billed: None
17:06:28    impersonate_service_account: None
17:06:28    job_retry_deadline_seconds: None
17:06:28    job_retries: 1
17:06:28    job_creation_timeout_seconds: None
17:06:28    job_execution_timeout_seconds: 300
17:06:28    timeout_seconds: 300
17:06:28    client_id: None
17:06:28    token_uri: None
17:06:28    dataproc_region: None
17:06:28    dataproc_cluster_name: None
17:06:28    gcs_bucket: None
17:06:28    dataproc_batch: None
17:06:28  Registered adapter: bigquery=1.8.2
17:06:29    Connection test: [OK connection ok]

17:06:29  All checks passed!

```

3. As DBT transforms existing data we will populate some raw data present in jaffle-data folder. If you want to generate more data check `seed-paths` config in your `dbt-project.yml`, you can run `jafgen` and then `seed` to work on generated data. This is another approach people use for testing the transformations.

```bash
(optional) jafgen [number of years to generate] # e.g. jafgen 6
dbt seed # it will load the data raw data in bigquery. 
```

4. Execute `dbt run` to get the transformations done on Raw data.

```bash
dbt run

(dbt-env) cloud_user_p_448bd91e@cloudshell:~/jaffle-shop (playground)$ dbt run
16:38:39  Running with dbt=1.8.3
16:38:40  Registered adapter: bigquery=1.8.2
16:38:41  Unable to do partial parsing because profile has changed
16:38:45  Found 13 models, 6 seeds, 27 data tests, 6 sources, 19 metrics, 770 macros, 6 semantic models, 3 saved queries, 3 unit tests
16:38:45  
16:38:48  Concurrency: 1 threads (target='dev')
16:38:48  
16:38:48  1 of 13 START sql table model dbt_jaffle.metricflow_time_spine ................. [RUN]
16:38:54  1 of 13 OK created sql table model dbt_jaffle.metricflow_time_spine ............ [CREATE TABLE (3.7k rows, 0 processed) in 6.30s]
16:38:54  2 of 13 START sql view model dbt_jaffle.stg_customers .......................... [RUN]
16:38:55  2 of 13 OK created sql view model dbt_jaffle.stg_customers ..................... [CREATE VIEW (0 processed) in 1.22s]
16:38:55  3 of 13 START sql view model dbt_jaffle.stg_locations .......................... [RUN]
16:38:56  3 of 13 OK created sql view model dbt_jaffle.stg_locations ..................... [CREATE VIEW (0 processed) in 1.20s]
16:38:56  4 of 13 START sql view model dbt_jaffle.stg_order_items ........................ [RUN]
16:38:58  4 of 13 OK created sql view model dbt_jaffle.stg_order_items ................... [CREATE VIEW (0 processed) in 1.30s]
16:38:58  5 of 13 START sql view model dbt_jaffle.stg_orders ............................. [RUN]
16:38:59  5 of 13 OK created sql view model dbt_jaffle.stg_orders ........................ [CREATE VIEW (0 processed) in 1.10s]
16:38:59  6 of 13 START sql view model dbt_jaffle.stg_products ........................... [RUN]
16:39:00  6 of 13 OK created sql view model dbt_jaffle.stg_products ...................... [CREATE VIEW (0 processed) in 1.07s]
16:39:00  7 of 13 START sql view model dbt_jaffle.stg_supplies ........................... [RUN]
16:39:01  7 of 13 OK created sql view model dbt_jaffle.stg_supplies ...................... [CREATE VIEW (0 processed) in 1.00s]
16:39:01  8 of 13 START sql table model dbt_jaffle.locations ............................. [RUN]
16:39:04  8 of 13 OK created sql table model dbt_jaffle.locations ........................ [CREATE TABLE (6.0 rows, 398.0 Bytes processed) in 3.35s]
16:39:04  9 of 13 START sql table model dbt_jaffle.products .............................. [RUN]
16:39:07  9 of 13 OK created sql table model dbt_jaffle.products ......................... [CREATE TABLE (10.0 rows, 949.0 Bytes processed) in 3.09s]
16:39:07  10 of 13 START sql table model dbt_jaffle.order_items .......................... [RUN]
16:39:12  10 of 13 OK created sql table model dbt_jaffle.order_items ..................... [CREATE TABLE (90.9k rows, 10.1 MiB processed) in 4.94s]
16:39:12  11 of 13 START sql table model dbt_jaffle.supplies ............................. [RUN]
16:39:15  11 of 13 OK created sql table model dbt_jaffle.supplies ........................ [CREATE TABLE (65.0 rows, 2.7 KiB processed) in 2.95s]
16:39:15  12 of 13 START sql table model dbt_jaffle.orders ............................... [RUN]
16:39:20  12 of 13 OK created sql table model dbt_jaffle.orders .......................... [CREATE TABLE (61.9k rows, 18.2 MiB processed) in 4.91s]
16:39:20  13 of 13 START sql table model dbt_jaffle.customers ............................ [RUN]
16:39:24  13 of 13 OK created sql table model dbt_jaffle.customers ....................... [CREATE TABLE (935.0 rows, 7.8 MiB processed) in 3.68s]
16:39:24  
16:39:24  Finished running 7 table models, 6 view models in 0 hours 0 minutes and 38.71 seconds (38.71s).
16:39:24  
16:39:24  Completed successfully
16:39:24  
16:39:24  Done. PASS=13 WARN=0 ERROR=0 SKIP=0 TOTAL=13
```
** Docs and Lineage ** 
5. Execute `dbt docs generate ` to get the documentations generated for the code.

```bash
(dbt-env) cloud_user_p_c2d60e26@cloudshell:~/jaffle-shop (playground-s-11-96c13f89)$ dbt docs generate
19:55:51  Running with dbt=1.8.3
19:55:52  Registered adapter: bigquery=1.8.2
19:55:53  Found 13 models, 6 seeds, 27 data tests, 6 sources, 19 metrics, 770 macros, 6 semantic models, 3 saved queries, 3 unit tests
19:55:53  
19:55:53  Concurrency: 1 threads (target='dev')
19:55:53  
19:55:56  Building catalog
19:56:03  Catalog written to /home/cloud_user_p_c2d60e26/jaffle-shop/target/catalog.json
```

5. Once successfull run `dbt docs serve --port 8080` in cloud shell to get the docs served locally. For production use cases this can be served from bucket or other appropriate approaches.

```bash
19:56:49  Running with dbt=1.8.3
http://localhost:8080
Serving docs at 8080
To access from your browser, navigate to: http://localhost:8080

Press Ctrl+C to exit.
127.0.0.1 - - [11/Jul/2024 19:56:59] "GET /?authuser=0&redirectedPreviously=true HTTP/1.1" 200 -
127.0.0.1 - - [11/Jul/2024 19:57:00] "GET /manifest.json?cb=1720727820239 HTTP/1.1" 200 -
127.0.0.1 - - [11/Jul/2024 19:57:00] "GET /catalog.json?cb=1720727820239 HTTP/1.1" 200 -
127.0.0.1 - - [11/Jul/2024 19:57:00] code 404, message File not found
127.0.0.1 - - [11/Jul/2024 19:57:00] "GET /$%7Brequire('./assets/favicons/favicon.ico')%7D HTTP/1.1" 404 -
```

you can open the browser to localhost:8080 , as we are using cloud shell we use the Web preview option as described in https://cloud.google.com/shell/docs/using-web-preview

![dbt Lineage](https://github.com/apurvc/jaffle-shop/blob/dd62ad82d8fdea091e1695306fc3faaa72837c39/DBT%20lineage.png)
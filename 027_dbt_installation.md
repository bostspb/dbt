# 27. dbt Installation (All Platforms)

1. Create new virtual environment in PyCharm via Anaconda with Python 3.10 with name `dbt310`
2. Install package `dbt-snowflake` ver 1.5.0
3. Go to the CMD for creating a dbt project:
```cmd
mkdir %userprofile%\.dbt

cd c:\work\dbt
conda activate dbt310

dbt init airbnb_project
```
During initialisation of project we put next params:
- Which database would you like to use? - `snowflake`
- account (https://<this_value>.snowflakecomputing.com) - put account part from snowflake url
- user (dev username): - `dbt` (get it from [creating dbt user script in Snowflake](course_resources/010-snowflake-setup.md))
- password (dev password): - `dbtPassword123`
- role (dev role): - `transform`
- warehouse (warehouse name): - `COMPUTE_WH`
- database (default database that dbt will build objects in): - `AIRBNB`
- schema (default schema that dbt will build objects in): - `DEV` - will be created by dbt
- threads (1 or more) [1]: - `1` - enough for learning goals

After installing we check connecting dbt with Snowflake: 
```cmd
cd c:\work\dbt\airbnb_project
conda activate dbt310
dbt debug
```
```
(dbt310) c:\work\dbt\airbnb_project>dbt debug
06:38:23  Running with dbt=1.5.6
06:38:23  dbt version: 1.5.6
06:38:23  python version: 3.10.12
06:38:23  python path: C:\Users\Zakhar\anaconda3\envs\dbt310\python.exe
06:38:23  os info: Windows-10-10.0.19045-SP0
06:38:23  Using profiles.yml file at C:\Users\Zakhar\.dbt\profiles.yml
06:38:23  Using dbt_project.yml file at c:\work\dbt\airbnb_project\dbt_project.yml
06:38:23  Configuration:
06:38:23    profiles.yml file [OK found and valid]
06:38:23    dbt_project.yml file [OK found and valid]
06:38:23  Required dependencies:
06:38:23   - git [OK found]

06:38:23  Connection:
06:38:23    account: *******-******
06:38:23    user: dbt
06:38:23    database: AIRBNB
06:38:23    schema: DEV
06:38:23    warehouse: COMPUTE_WH
06:38:23    role: transform
06:38:23    client_session_keep_alive: False
06:38:23    query_tag: None
06:38:23  Registered adapter: snowflake=1.5.0
06:38:25    Connection test: [OK connection ok]

06:38:25  All checks passed!
```
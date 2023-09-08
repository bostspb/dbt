# Udemy: The Complete dbt Bootcamp
> https://www.udemy.com/course/complete-dbt-data-build-tool-bootcamp-zero-to-hero-learn-dbt/ <br>
> https://github.com/nordquant/complete-dbt-bootcamp-zero-to-hero/tree/main

`dbt` `Snowflake` `Preset` `Jinja` `SQL`


## Section 1: Course Introduction
1. Instructors Introduction
2. Welcome
3. Course Structure Overview

## Section 2: Theory - The Data Maturity Model
4. Introduction - Maslow's Pyramid of Data
5. The Data Maturity Model
6. ETL and ELT
- **Quiz 1**: The Data Maturity Model

## Section 3: Theory - Data Warehouses, Data Lakes and Lakehouses
7. Data Warehousing - a short introduction
8. External Tables and Cloud Data Warehouses
9. Data Lakes
10. Data Lakehouse
- **Quiz 2**: Data Warehouses, Data Lakes and Lakehouses

## Section 4: Theory - The Modern Data Stack
11. The Modern Data Stack
- **Quiz 3**: The Modern Data Stack

## Section 5: Theory - Slowly Changing Dimension (SCD)
12. The Basics of Slowly Changing Dimensions
13. Type 0 - Retain Original
14. Type 1 - Overwrite
15. Type 2 - Add New Row
16. Type 3 - Add New Attribute
- **Quiz 4**: Slowly Changing Dimension (SCD)

## Section 6: Intro to the practical sessions: dbt and the Airbnb use-case
17. dbt Overview
18. Use-case and Input Data Model Overview

## Section 7: Practice - Setup
19. How to use github and the course's resources
    https://github.com/nordquant/complete-dbt-bootcamp-zero-to-hero/blob/main/_course_resources/course-resources.md 
20. Snowflake Registration
21. A note on the Snowflake data import    
22. [Importing Airbnb Data into Snowflake](course_resources/010-snowflake-setup.md)    
23. READ ME! Setup instructions and Prerequisites
24. Optional - Installing Python and pip on Windows
25. Optional - Setting up a Python Virtualenv on Windows
26. Optional - Setting up Python and pip on a Mac
27. [dbt Installation](027_dbt_installation.md) (All Platforms)
28. Creating a dbt 1.5 project and connecting it to Snowflake using dbt init
29. READ ME - dbt project structure - data folder vs. seeds folder
30. Overview of the dbt Project Structure
31. Install dbt power tools into VSCode Setup (optional)
32. A note on the DEV schema
33. [Datasets and Data Flow Overview](033_datasets_and_data_flow_overview.md)

# Section 8: Models
34. Learning Objectives - Models
35. Models Overview
    - Models are the basic building block of your business logic
    - Materialized as tables, views, etc…
    - They live in SQL files in the `models` folder
    - Models can reference each other and use templates and macros
36. Theory: CTE - Common Table Expressions
37. Creating our first model: Airbnb listings
    1. Created [src_listings.sql](airbnb_project/models/src/src_listings.sql) 
       and [src_reviews.sql](airbnb_project/models/src/src_reviews.sql)
    2. Executed command `dbt run` for creating model objects in Snowflake (views `dev.src_listings` and `dev.src_reviews`)
- **Quiz 5**: Models Quiz
- **Assignment 1**: Create the `src_hosts` model
  - Create a model which builds on top of our raw_hosts table.
    - Name the model `models/src/src_hosts.sql`
    - Use a CTE to define an alias called `raw_hosts`. 
      This CTE will select every column from the raw host table `AIRBNB.RAW.RAW_HOSTS`
    - In your final SELECT, select every column and record from raw_hosts and rename the following columns:
       - `id` to `host_id`
       - `name` to `host_name`
  - Solution
    - Created [src_hosts.sql](airbnb_project/models/src/src_hosts.sql)
    - Executed command `dbt run`

# Section 9: Materializations
38. Learning Objectives - Materializations
39. [Materializations Overview](039_materializations_overview.md)
40. Model Dependencies and dbt's ref tag
    - Jinja - https://palletsprojects.com/p/jinja/
    - Created [dim_listings_cleansed.sql](airbnb_project/models/dim/dim_listings_cleansed.sql) 
      and [dim_hosts_cleansed.sql](airbnb_project/models/dim/dim_hosts_cleansed.sql)
    - Executed command `dbt run`
42. Table type materialization & Project-level Materialization config
    - Added type materialization by default and for models at `models/dim` folder
      via [dbt_project.yml](airbnb_project/dbt_project.yml), section `models`
43. Incremental materialization
    - Created model [fct_reviews.sql](airbnb_project/models/fct/fct_reviews.sql) with file-level materialization config
    - Executed command `dbt run` and find table `dev.fct_reviews`
    - Added a new record to the raw table: 
      `INSERT INTO "AIRBNB"."RAW"."RAW_REVIEWS" VALUES (3176, CURRENT_TIMESTAMP(), 'Zakhar', 'excellent stay!', 'positive');`
    - Executed command `dbt run` and make sure existing new row in `dev.fct_reviews`
44. Ephemeral materialization
    - Added final model [dim_listings_w_hosts.sql](airbnb_project/models/dim/dim_listings_w_hosts.sql)
    - Added type materialization `ephemeral` for models at `models/src` folder
      via [dbt_project.yml](airbnb_project/dbt_project.yml)
    - Dropped views `dev.src_listings`, `dev.src_reviews` and `dev.src_hosts` in Snowflake    
    - Changed type materialization on `view` for models `dim_hosts_cleansed` and `dim_listings_cleansed` with file-level
    - Executed command `dbt run`
- **Quiz 6**: Quiz - Materializations

# Section 10: Seeds and Sources
44. Learning Objectives - Seeds and Sources
45. Seeds and Sources Overview
    - Seeds are local files that you upload to the data warehouse from dbt
    - Sources is an abstraction layer on the top of your input tables
    - Source freshness can be checked automatically
46. Seeds
    - Loaded a file [seed_full_moon_dates.csv](https://dbtlearn.s3.us-east-2.amazonaws.com/seed_full_moon_dates.csv)
      at folder `seeds/`
    - Executed command `dbt seed` 
    - Added mart model [full_moon_reviews.sql](airbnb_project/models/mart/full_moon_reviews.sql)
    - Executed command `dbt run`
47. Sources
    - Added [sources.yml](airbnb_project/models/sources.yml)
    - Replaced inline source table names in models [src_listings.sql](airbnb_project/models/src/src_listings.sql), 
      [src_reviews.sql](airbnb_project/models/src/src_reviews.sql) and [src_hosts.sql](airbnb_project/models/src/src_hosts.sql)
      on refs
    - Executed command `dbt compile`
48. Source Freshness
    - Added in file [sources.yml](airbnb_project/models/sources.yml) a section `freshness`
    - Executed command `dbt source freshness` - get `WARN` alarm

# Section 11: Snapshots
49. Learning Objectives - Snapshots
50. Snapshots Overview
    - Snapshots live in the `snapshots` folder
    - Snapshots implement SCD type 2 
    - Strategies:
      - **Timestamp**: A `unique key` and an `updated_at` field is defined on the source model. 
        These columns are used for determining changes.
      - **Check**: Any change in a set of columns (or all columns) will be picked up as an update
51. Creating a Snapshot
    - Added file [scd_raw_listings.sql](airbnb_project/snapshots/scd_raw_listings.sql)
    - Executed command `dbt snapshot`
    - Check the state of future test row: <br>
      `SELECT * FROM AIRBNB.DEV.SCD_RAW_LISTINGS WHERE ID=3176;`
    - Updated a record in table `raw.raw_listings`: <br>
      `UPDATE AIRBNB.RAW.RAW_LISTINGS SET MINIMUM_NIGHTS=30, updated_at=CURRENT_TIMESTAMP() WHERE ID=3176;`
    - Executed command `dbt snapshot`
    - Check state of test row: <br>
      `SELECT * FROM AIRBNB.DEV.SCD_RAW_LISTINGS WHERE ID=3176;` - we see a new row with SCD type 2 
- **Quiz 7**: Snapshots Quiz

# Section 12: Tests
52. Learning objectives - Tests
53. Tests Overview
    - There are two types of tests: **singular** and **generic**
    - Singular tests are SQL queries stored in tests which are expected to return an empty resultset
    - There are four built-in generic tests:
      - unique
      - not_null
      - accepted_values
    - Relationships
    - You can define your own custom generic tests or import tests from dbt packages (will discuss later)
54. Generic Tests
    - Added file [models/schema.yml](airbnb_project/models/schema.yml) 
    - Executed command `dbt test`
55. Singular Tests
    - Added file [tests/dim_listings_minumum_nights.sql](airbnb_project/tests/dim_listings_minumum_nights.sql)
    - Executed command `dbt test`
    - Executed command `dbt test --select dim_listings_cleansed` (restricting test execution)
- **Assignment 2**: Create your own singular test
  - Create a singular test in `tests/consistent_created_at.sql` that checks that there is no review date that is 
    submitted before its listing was created: Make sure that every `review_date` in `fct_reviews` is more recent than
    the associated `created_at` in `dim_listings_cleansed`.
  - Solution: [tests/consistent_created_at.sql](airbnb_project/tests/consistent_created_at.sql)
- **Quiz 8**: Tests Quiz

# Section 13: Macros, Custom Tests and Packages
56. Learning Objectives - Macros, Custom Tests and Packages
57. Macros Overview
    - Macros are jinja templates created in the macros folder
    - There are many built-in macros in DBT
    - You can use macros in model definitions and tests
    - A special macro, called test, can be used for implementing your own generic tests
    - dbt packages can be installed easily to get access to a plethora of macros and tests
58. Creating our First Macro
    - Added macros [macros/no_nulls_in_columns.sql](airbnb_project/macros/no_nulls_in_columns.sql)
    - Added a new test [tests/no_nulls_in_dim_listings.sql](airbnb_project/tests/no_nulls_in_dim_listings.sql)
    - Executed command `dbt test --select dim_listings_cleansed`
59. Writing Custom Generic Tests
    - Added macros [macros/positive_value.sql](airbnb_project/macros/no_nulls_in_columns.sql)
    - Inserted test `positive_value` for column `minimum_nights` at [models/schema.yml](airbnb_project/models/schema.yml) 
    - Executed command `dbt test --select dim_listings_cleansed`
60. README updated versions of packages
61. Installing Third-Party Packages
    - Went to https://hub.getdbt.com
    - Created file [packages.yml](airbnb_project/packages.yml)
    - Executed command `dbt deps`
    - Added new column `review_id` at model [fct_reviews](airbnb_project/models/fct/fct_reviews.sql)<br>
      `{{ dbt_utils.generate_surrogate_key(['listing_id', 'review_date', 'reviewer_name', 'review_text']) }} AS review_id`
    - Executed command `dbt run --full-refresh --select fct_reviews`
- **Quiz 9**: Macros, Custom Tests and Packages Quiz

# Section 14: Documentation
62. Learning Objectives - Documentation
63. Documentation Overview
    - Documentations can be defined two ways:
      - In yaml files (like `schema.yml`)
      - In standalone markdown files
    - Dbt ships with a lightweight documentation web server
    - For customizing the landing page, a special file, `overview.md` is used
    - You can add your own assets (like images) to a special project folder
64. Writing and Exploring Basic Documentation
    - Added section `description` for some items at file [models/schema.yml](airbnb_project/models/schema.yml)
    - Executed command `dbt docs generate`
    - Start docs web-server `dbt docs serve`
65. Markdown-based Docs, Custom Overview Page and Assets
    - Added file [models/docs.md](airbnb_project/models/docs.md)
    - Added section `description` for column `minimum_nights` at file [models/schema.yml](airbnb_project/models/schema.yml)<br>
      `{{ doc("dim_listing_cleansed__minimum_nights") }}`
    - Executed command `dbt docs generate`
    - Start docs web-server `dbt docs serve`
    - Added file [models/overview.md](airbnb_project/models/overview.md) for rewrite overview page of documentation
    - Downloaded image [input_schema.png](https://dbtlearn.s3.us-east-2.amazonaws.com/input_schema.png) at new folder `/assets`
    - Added section `asset-paths` at [dbt_project.yml](airbnb_project/dbt_project.yml)
    - Set image path with `/assets/input_schema.png` in file [models/overview.md](airbnb_project/models/overview.md)
    - Executed command `dbt docs generate`
    - Start docs web-server `dbt docs serve`
66. The Linage Graph (Data Flow DAG)
    - Went on the docs web-server and saw the Linage Graph
    - Executed command `dbt run --select src_hosts+` for running only `src_hosts` branch activities.
- **Assignment 3**: Document the dim_hosts_cleansed table
  - Open `schema.yml` and add basic documentation to the `dim_hosts_cleansed` model.
  - Solution: [schema.yml](airbnb_project/models/schema.yml)
- **Quiz 10**: Documentation quiz

# Section 15: Analyses, Hooks and Exposures
67. Learning Objectives - Analyses, Hook and Exposures
68. Analyses
    - Added file [analyses/full_moon_no_sleep.sql](airbnb_project/analyses/full_moon_no_sleep.sql)
    - Executed command `dbt compile`
    - Saw `target/compiled/airbnb_project/analyses/full_moon_no_sleep.sql`
69. Hooks
    - Hooks are SQLs that are executed at predefined times
    - Hooks can be configured on the project, subfolder, or model level
    - Hook types:
      - **on_run_start**: executed at the start of dbt {run, seed, snapshot}
      - **on_run_end**: executed at the end of dbt {run, seed, snapshot}
      - **pre-hook**: executed before a model/seed/snapshot is built
      - **post-hook**: executed after a model/seed/snapshot is built
    - Created the `REPORTER` role and `PRESET` user in Snowflake 
      via [sql](course_resources/create_reporter_role_and_preset_user_in_snowflake.sql)
    - Set grants on `SELECT` to role `REPORTER` via post-hook at [dbt_project.yml](airbnb_project/dbt_project.yml)
    - Executed command `dbt run`
70. Setting up a BI Dashboard in Snowflake and Preset
    - Went to [preset.io](https://preset.io/)
      - singed up
      - created connection to Snowflake with `REPORTER` user
      - created dataset with mart `full_moon_reviews`
      - created a bar chart and then a simple dashboard
71. Exposures
    - Added file [models/dashboard.yml](airbnb_project/models/dashboard.yml)
    - Executed command `dbt docs generate`
    - Start docs web-server `dbt docs serve`
- **Quiz 11**: Hooks Quiz

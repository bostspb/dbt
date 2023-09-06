# Udemy: The Complete dbt Bootcamp
> https://www.udemy.com/course/complete-dbt-data-build-tool-bootcamp-zero-to-hero-learn-dbt/
> https://github.com/nordquant/complete-dbt-bootcamp-zero-to-hero/tree/main


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
    - Created [dim_listings_cleansed.sql](airbnb_project/models/dim/dim_listings_cleansed.sql) 
      and [dim_hosts_cleansed.sql](airbnb_project/models/dim/dim_hosts_cleansed.sql)
    - Executed command `dbt run`
41. Table type materialization & Project-level Materialization config
    - Added type materialization by default and for models at `models/dim` folder
      via - [dbt_project.yml](airbnb_project/dbt_project.yml), section `models`
42. Incremental materialization
    - Created model [fct_reviews.sql](airbnb_project/models/fct/fct_reviews.sql) with file-level materialization config
    - Executed command `dbt run` and find table `dev.fct_reviews`
    - Added a new record to the raw table: 
      `INSERT INTO "AIRBNB"."RAW"."RAW_REVIEWS" VALUES (3176, CURRENT_TIMESTAMP(), 'Zakhar', 'excellent stay!', 'positive');`
    - Executed command `dbt run` and make sure existing new row in `dev.fct_reviews`
43. Ephemeral materialization
- **Quiz 6**: Quiz - Materializations
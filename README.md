
# Airbnb Data Engineering Project | Snowflake + dbt + AWS

![Snowflake](https://img.shields.io/badge/Snowflake-Data%20Warehouse-29B5E8?logo=snowflake&logoColor=white)
![dbt](https://img.shields.io/badge/dbt-Data%20Transformation-FF694B?logo=dbt&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-Cloud%20Storage-232F3E?logo=amazonaws&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.x-3776AB?logo=python&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Analytics-4479A1?logo=postgresql&logoColor=white)

## Project Overview

This project demonstrates an end-to-end data engineering workflow using Airbnb-related datasets, Snowflake, dbt, Python, and AWS S3.

The project focuses on organizing raw datasets into structured analytical layers, applying data transformations, implementing incremental models and historical snapshots, and preparing analytics-ready data for reporting.

The repository contains the overall project documentation, source datasets, SQL scripts, Python configuration files, and a dedicated dbt project.

## Objectives

- Organize Airbnb-related source datasets for analytical processing.
- Use Snowflake as the cloud data warehouse.
- Transform raw data into structured Bronze, Silver, and Gold layers.
- Implement reusable SQL transformations using dbt.
- Apply incremental processing where configured.
- Track historical changes using dbt snapshots.
- Use Jinja and custom macros to reduce repetitive SQL.
- Apply data quality tests to important models.
- Maintain a modular, version-controlled project structure.

## Architecture

```text
Airbnb Source Data
       |
       v
CSV Files / Source Data
       |
       v
AWS S3 Storage
       |
       v
Snowflake Staging / Raw Data
       |
       v
Bronze Layer
       |
       v
Silver Layer
       |
       v
Gold Layer
       |
       v
Analytics and Reporting
```

**Note:** AWS S3 and Snowflake staging are part of the intended ingestion architecture. The exact loading mechanism and orchestration depend on the configured environment.

## Technology Stack

| Technology | Purpose |
|---|---|
| Snowflake | Cloud data warehouse |
| dbt Core | SQL-based data transformation |
| SQL | Data cleaning, joins, aggregations, and modelling |
| Jinja | Dynamic SQL generation |
| Python | Supporting scripts and project utilities |
| AWS S3 | Object storage for source data |
| Git and GitHub | Version control and project sharing |

## Data Modelling

### 1. Bronze Layer

The Bronze layer represents the raw or initial structured datasets loaded into Snowflake.

Primary datasets include:

- `bronze_bookings`
- `bronze_hosts`
- `bronze_listings`

The purpose of this layer is to preserve the source data in a structured form before applying downstream business transformations.

### 2. Silver Layer

The Silver layer contains cleaned and transformed datasets.

Expected model groups include:

- `silver_bookings`
- `silver_hosts`
- `silver_listings`

Transformations can include column standardization, data type handling, data cleaning, joins, and other preparation required for analytical modelling.

### 3. Gold Layer

The Gold layer contains models intended for downstream analytics and reporting.

The project includes fact-oriented and OBT-style modelling. The exact business logic is defined in the dbt model SQL files.

### 4. Ephemeral Models

Ephemeral models allow reusable SQL transformations to be incorporated into dependent models without creating a separate physical table or view in Snowflake.

## dbt Features

### Incremental Models

Incremental models can process new or changed records rather than rebuilding the entire dataset on every run, depending on the model configuration and incremental strategy.

### Snapshots and Historical Tracking

The project includes snapshots for:

- `dim_bookings`
- `dim_hosts`
- `dim_listings`

Snapshots can preserve historical versions of records using dbt's snapshot strategies and configured unique keys.

### Custom Macros

The project includes custom macros such as:

- `generate_schema_name.sql`
- `multiply.sql`
- `tag.sql`
- `trimmer.sql`

These macros support reusable SQL logic, schema naming, and transformation patterns.

### Jinja-Based SQL Generation

The OBT model uses Jinja templating to generate SQL dynamically from configuration defined in the model.

This reduces repetitive SQL and helps maintain consistent join and column-selection patterns.

### Data Quality

dbt tests can be used to validate important assumptions, such as uniqueness, non-null values, and relationships between models.

The configured tests can be found in the dbt project.

## Repository Structure

```text
Airbnb_Snowflake_DBT_Data_Engineer_Project/
│
├── README.md
├── .gitignore
├── .python-version
├── pyproject.toml
├── uv.lock
├── main.py
│
├── DDL/
│   ├── ddl.sql
│   └── resources.sql
│
├── SourceData/
│   ├── bookings.csv
│   ├── hosts.csv
│   └── listings.csv
│
├── Notes/
│
└── aws_dbt_snowflake_project/
    ├── README.md
    ├── dbt_project.yml
    ├── ExampleProfiles.yml
    ├── models/
    │   ├── Sources/
    │   ├── Bronze/
    │   ├── Silver/
    │   ├── Gold/
    │   └── ephemeral/
    ├── macros/
    ├── snapshots/
    ├── tests/
    ├── seeds/
    └── analyses/
```

*The structure above represents the intended repository layout. Keep directory and file names aligned with the actual project files.*

## Prerequisites

Install or configure the following:

- Python
- Git
- dbt Core
- The appropriate dbt adapter for Snowflake
- A Snowflake account with the required database, schema, warehouse, and permissions
- AWS credentials and S3 access, if using the S3 ingestion workflow

## Getting Started

### 1. Clone the Repository

```bash
git clone <YOUR_GITHUB_REPOSITORY_URL>
cd Airbnb_Snowflake_DBT_Data_Engineer_Project
```

Replace the placeholder with the actual repository URL.

### 2. Set Up the Python Environment

If the project uses `uv`:

```bash
uv sync
```

Alternatively, create a virtual environment and install the required dependencies according to `pyproject.toml`.

### 3. Configure Snowflake Credentials

Configure the dbt profile using the appropriate Snowflake account, user, authentication method, role, warehouse, database, and schema.

The profile should be stored in the appropriate local dbt configuration location.

**Security:** Never commit passwords, private keys, access tokens, or other secrets to GitHub.

### 4. Navigate to the dbt Project

```bash
cd aws_dbt_snowflake_project
```

### 5. Validate the dbt Connection

```bash
dbt debug
```

### 6. Install dbt Dependencies

```bash
dbt deps
```

### 7. Run Models and Tests

```bash
dbt run
dbt test
```

To execute the configured build resources together:

```bash
dbt build
```

Run snapshots separately when required:

```bash
dbt snapshot
```

### 8. Generate Documentation

```bash
dbt docs generate
dbt docs serve
```

These commands generate and serve dbt documentation based on the project configuration and available warehouse metadata.

## Configuration and Security

- Keep credentials outside version control.
- Use environment variables or an approved secrets-management approach.
- Do not commit local profile files containing credentials.
- Review `.gitignore` before pushing changes.
- Use separate development and production configurations when applicable.
- Ensure that AWS and Snowflake permissions follow the principle of least privilege.

## Future Enhancements

- Implement automated ingestion and scheduling.
- Improve incremental processing and change detection.
- Expand data quality checks and source freshness validation.
- Add documentation for business definitions and model lineage.
- Add CI/CD validation for dbt models and tests.
- Improve monitoring, logging, and failure notifications.
- Build analytics dashboards on top of Gold-layer models.

## Project Status

This repository is a data engineering project intended to demonstrate cloud data warehousing, SQL transformation, dbt modelling, historical tracking, and modular project organization.

Implementation details and execution status should be verified against the configured environment and the latest project run.

## Author

**Akash Kumar Jha**

GitHub: [Akash3405](https://github.com/Akash3405)
# Airbnb Data Engineering with AWS S3, Snowflake & dbt

## 📌 Project Overview

This project demonstrates an end-to-end data engineering pipeline built using **AWS S3, Snowflake, and dbt**.

Airbnb dataset files are first uploaded to **AWS S3** and loaded into Snowflake using a **Snowflake Stage and COPY INTO**. The data is then transformed using dbt following a layered **Bronze → Silver → Gold** architecture.

The project also implements **fact and dimension modeling, One Big Table (OBT), reusable Jinja macros, metadata-driven transformations, dbt data quality tests, and incremental models**.

---

## 🏗️ Architecture

```text
AWS S3
   │
   │  Data Files
   ▼
Snowflake Stage
   │
   │  COPY INTO
   ▼
Snowflake
   │
   ▼
Bronze Layer
   │
   │  dbt Transformations
   ▼
Silver Layer
   │
   ▼
Gold Layer
   ├── Fact Tables
   ├── Dimension Tables
   └── One Big Table (OBT)

   🔄 Data Pipeline
1. Data Ingestion
Airbnb dataset files are stored in AWS S3.
Snowflake is connected to the S3 data source.
A Snowflake Stage is used to access the files.
Data is loaded into Snowflake using COPY INTO.
2. Bronze Layer

The Bronze layer represents the initial data layer after ingestion.

Responsibilities include:

Maintaining the raw/initial dataset structure
Preparing data for downstream transformations
Providing the foundation for the dbt transformation layers
3. Silver Layer

The Silver layer contains transformed and cleaned datasets.

Transformations include:

Data cleaning
Column transformations
Data standardization
Business logic
Joining related datasets
4. Gold Layer

The Gold layer contains analytics-ready datasets designed for downstream analysis.

This layer includes:

Fact tables
Dimension tables
One Big Table (OBT)
Business-ready transformations
⭐ Key Features
Bronze / Silver / Gold Architecture

The project follows a layered data architecture to separate ingestion, transformation, and analytics-ready datasets.

Fact & Dimension Modeling

The Gold layer contains structured fact and dimension tables to support analytical use cases.

One Big Table (OBT)

An OBT model combines required attributes from multiple datasets into a single analytics-ready table.

Reusable Jinja Macros

Reusable dbt macros are used to reduce repetitive SQL logic and improve maintainability.

Metadata-Driven Transformations

The project uses configuration-driven Jinja logic to dynamically generate:

Selected columns
Table aliases
Join conditions
LEFT JOIN statements

This reduces hard-coded SQL and makes the transformation logic more reusable.

dbt Data Quality Tests

dbt tests are implemented to validate data quality and improve reliability of transformed models.

Incremental Model

An incremental dbt model is implemented to process data efficiently instead of rebuilding the complete dataset on every run.

🛠️ Technology Stack
Technology	Purpose
AWS S3	Source data storage
Snowflake	Cloud data warehouse
Snowflake Stage	Data ingestion from S3
COPY INTO	Loading data into Snowflake
dbt	Data transformation and modeling
SQL	Data transformation and analysis
Jinja	Dynamic and reusable dbt logic
Git	Version control
GitHub	Source code repository
📂 Project Structure
airbnb-data-engineering-snowflake-dbt-aws/
│
├── analyses/
│
├── macros/
│   └── Reusable Jinja macros
│
├── models/
│   ├── Bronze/
│   ├── Silver/
│   └── Gold/
│
├── seeds/
│
├── snapshots/
│
├── tests/
│   └── dbt data quality tests
│
├── dbt_project.yml
├── .gitignore
└── README.md
🔧 dbt Workflow

Typical dbt workflow for this project:

dbt debug
dbt run
dbt test

The dbt project connects to Snowflake and executes the transformation models inside Snowflake.

🔐 Security

Sensitive credentials are intentionally excluded from this repository.

The project uses environment variables for sensitive Snowflake authentication details, and files such as:

profiles.yml
.user.yml
.env

are excluded using .gitignore.

AWS credentials and Snowflake passwords should never be committed to source control.

🎯 Project Objectives

The main objectives of this project are to demonstrate practical experience with:

Cloud data ingestion
AWS S3
Snowflake data warehousing
dbt transformations
Layered data architecture
Dimensional modeling
OBT modeling
Jinja templating
Metadata-driven transformations
Data quality testing
Incremental data processing
Git/GitHub version control

👨‍💻 Author

Akash Kumar Jha

Analytics Engineer | Data Engineer

Skills: SQL | Python | Snowflake | AWS | dbt 

GitHub: [View Project](https://github.com/Akash3405/airbnb-data-engineering-snowflake-dbt-aws)
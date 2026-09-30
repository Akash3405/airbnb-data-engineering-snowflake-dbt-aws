
# Airbnb dbt Project | Snowflake Data Transformation

![dbt](https://img.shields.io/badge/dbt-Core-FF694B?logo=dbt&logoColor=white)
![Snowflake](https://img.shields.io/badge/Snowflake-Warehouse-29B5E8?logo=snowflake&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Transformation-4479A1?logo=postgresql&logoColor=white)
![Jinja](https://img.shields.io/badge/Jinja-Templating-B41717?logo=jinja&logoColor=white)

## Project Overview

This dbt project transforms Airbnb-related source datasets in Snowflake into structured, analytics-ready models.

It demonstrates modular SQL development, layered data modelling, incremental transformations, reusable macros, Jinja-based SQL generation, historical snapshots, and data quality testing.

This directory contains the dbt-specific configuration, models, macros, snapshots, tests, seeds, and analyses used by the broader Airbnb data engineering project.

## Objectives

- Organize transformations into Bronze, Silver, and Gold layers.
- Build modular and reusable SQL models.
- Apply incremental processing where configured.
- Use dbt snapshots to preserve historical changes.
- Create reusable custom macros.
- Generate SQL dynamically using Jinja templating.
- Validate model assumptions through data tests.
- Maintain clear model dependencies and documentation.

## Architecture

```text
Snowflake Source / Staging Tables
              |
              v
        Bronze Models
              |
              v
        Silver Models
              |
              v
         Gold Models
              |
              v
      Analytics-Ready Data
```

Ephemeral models can be used within dependent transformations without creating separate physical tables or views.

## Data Modelling Layers

### 1. Bronze Layer

The Bronze layer contains the initial structured representation of the source datasets.

Primary datasets include:

- `bronze_bookings`
- `bronze_hosts`
- `bronze_listings`

This layer provides the starting point for downstream transformations.

### 2. Silver Layer

The Silver layer applies data preparation and transformation logic to the Bronze datasets.

Primary models include:

- `silver_bookings`
- `silver_hosts`
- `silver_listings`

Depending on the model SQL, transformations may include data type handling, cleaning, column standardization, joins, and business-rule preparation.

### 3. Gold Layer

The Gold layer contains models designed for downstream analytical use cases.

This project includes fact-oriented modelling and an OBT-style model.

The exact columns, joins, and business logic are defined in the respective model SQL files.

### 4. Ephemeral Models

Ephemeral models allow intermediate SQL transformations to be reused by dependent models without materializing separate database objects.

They help keep model logic modular and reduce unnecessary intermediate tables.

## Key dbt Features

### Incremental Models

Incremental materialization can process new or changed data without rebuilding the entire target dataset.

The actual incremental behaviour depends on each model's configuration, unique key, filtering logic, and incremental strategy.

### Jinja-Based Dynamic SQL

The OBT model uses Jinja templating and configuration-driven logic to generate SQL dynamically.

This approach can reduce repetitive SELECT and JOIN statements and make model changes easier to maintain.

### Custom Macros

The project includes the following custom macros:

| Macro | Purpose |
|---|---|
| `generate_schema_name.sql` | Customizes schema naming behaviour |
| `multiply.sql` | Reusable multiplication logic |
| `tag.sql` | Reusable tagging-related SQL logic |
| `trimmer.sql` | Reusable trimming logic |

The exact implementation and parameters for each macro are defined in the corresponding files under `macros/`.

### Snapshots and Historical Tracking

The project contains snapshots for:

- `dim_bookings`
- `dim_hosts`
- `dim_listings`

Snapshots can preserve historical versions of records using configured unique keys and snapshot strategies.

Historical tracking behaviour depends on the configuration defined in the snapshot SQL files.

### Data Quality Testing

dbt tests help validate data quality assumptions.

Examples of commonly used checks include:

- Unique identifiers
- Non-null key columns
- Referential integrity
- Accepted values
- Custom business-rule validation

The actual tests configured for this project are maintained in the `tests/` directory and model YAML files.

## Project Structure

```text
aws_dbt_snowflake_project/
│
├── README.md
├── dbt_project.yml
├── ExampleProfiles.yml
├── .gitignore
│
├── models/
│   ├── Sources/
│   ├── Bronze/
│   ├── Silver/
│   ├── Gold/
│   └── ephemeral/
│
├── macros/
│   ├── generate_schema_name.sql
│   ├── multiply.sql
│   ├── tag.sql
│   └── trimmer.sql
│
├── snapshots/
│   ├── dim_bookings.sql
│   ├── dim_hosts.sql
│   └── dim_listings.sql
│
├── tests/
├── seeds/
├── analyses/
└── target/                 # Generated locally; normally ignored by Git
```

*This is the logical structure. Keep the names and paths consistent with the actual files in your project.*

## Technology Stack

| Technology | Purpose |
|---|---|
| dbt Core | SQL transformation framework |
| Snowflake | Cloud data warehouse |
| SQL | Data transformation and modelling |
| Jinja | Dynamic SQL generation |
| YAML | Project, source, and model configuration |
| Git | Version control |

## Prerequisites

Before running the project, ensure that you have:

- Python installed
- dbt Core installed
- The compatible dbt Snowflake adapter installed
- Access to the Snowflake account
- A configured dbt profile
- Required source tables and permissions

## Getting Started

### 1. Navigate to the Project Directory

```bash
cd aws_dbt_snowflake_project
```

If you are already inside this directory, skip this step.

### 2. Check the dbt Installation

```bash
dbt --version
```

### 3. Configure the Snowflake Profile

Configure your local dbt profile with the appropriate Snowflake account, user, authentication method, role, warehouse, database, and schema.

Use `ExampleProfiles.yml` as a reference if it matches your project configuration.

Do not copy real passwords, private keys, or access tokens into tracked files.

### 4. Validate the Connection

```bash
dbt debug
```

This checks the dbt project configuration and attempts to validate the configured connection.

### 5. Install Dependencies

```bash
dbt deps
```

This installs packages declared in `packages.yml`, if the project defines any.

### 6. Run Models

```bash
dbt run
```

This executes the configured dbt models.

### 7. Run Data Tests

```bash
dbt test
```

This executes the configured data tests.

### 8. Run Snapshots

```bash
dbt snapshot
```

This executes the configured snapshots.

### 9. Build Models and Tests Together

```bash
dbt build
```

This runs the applicable dbt resources according to their dependencies and configuration.

### 10. Generate dbt Documentation

```bash
dbt docs generate
dbt docs serve
```

The documentation site can display model information, dependencies, and available metadata.

## Development Practices

- Keep SQL transformations modular and readable.
- Use meaningful model and column names.
- Configure appropriate materializations for each model.
- Define sources and tests in YAML where applicable.
- Use incremental processing only when the model logic supports it.
- Review snapshot unique keys and strategies.
- Validate changes using `dbt build`.
- Review compiled SQL when debugging Jinja-generated queries.
- Keep secrets and local environment files out of version control.

## Security

- Never commit passwords or authentication tokens.
- Keep personal credentials in local configuration or an approved secrets manager.
- Review `.gitignore` before committing.
- Use least-privilege Snowflake roles and permissions.

## Future Enhancements

- Add source freshness checks.
- Expand data quality tests.
- Improve incremental filtering and late-arriving data handling.
- Add business documentation for Gold models.
- Automate dbt execution through a scheduler or CI/CD workflow.
- Add execution monitoring and failure notifications.
- Improve model lineage and documentation.

## Related Project

This dbt project is part of the larger Airbnb Snowflake Data Engineering project.

See the parent repository's `README.md` for the overall project architecture, source datasets, supporting files, and setup overview.

## Author

**Akash Kumar Jha**

GitHub: [Akash3405](https://github.com/Akash3405)
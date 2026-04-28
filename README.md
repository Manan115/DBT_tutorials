# DBT Tutorials

A beginner-friendly repository for learning **dbt (data build tool)** with the **Databricks** adapter. This project demonstrates how to build a medallion-architecture data pipeline (Bronze → Silver → Gold) entirely in dbt.

---

## Table of Contents

1. [Repository Structure](#repository-structure)
2. [Prerequisites](#prerequisites)
3. [Quickstart (Local Setup)](#quickstart-local-setup)
4. [dbt Setup](#dbt-setup)
5. [Databricks Adapter Notes](#databricks-adapter-notes)
6. [Medallion Architecture](#medallion-architecture)
7. [Common Commands](#common-commands)
8. [Contributing](#contributing)
9. [License](#license)

---

## Repository Structure

```
DBT_tutorials/
├── dbt_mann/                  # dbt project root
│   ├── dbt_project.yml        # Project configuration (name, profile, paths)
│   ├── models/
│   │   ├── bronze/            # Raw / ingested data (materialized as tables, schema: bronze)
│   │   ├── silver/            # Cleaned / transformed data (schema: silver)
│   │   ├── gold/              # Aggregated / business-ready data (schema: gold)
│   │   └── source/            # Source definitions
│   ├── seeds/                 # Static CSV files loaded into the bronze schema
│   ├── macros/                # Reusable Jinja/SQL macros
│   ├── analyses/              # Ad-hoc analysis SQL files
│   ├── snapshots/             # dbt snapshot definitions
│   └── tests/                 # Custom data tests
├── main.py                    # Entry-point helper script (optional)
├── pyproject.toml             # Python project metadata & dependencies
├── uv.lock                    # Lockfile for uv package manager
└── .gitignore                 # Excludes .venv and dbt_mann/profiles.yml
```

---

## Prerequisites

| Requirement | Version |
|-------------|---------|
| Python      | ≥ 3.13  |
| dbt-core    | ≥ 1.11.8 |
| dbt-databricks | ≥ 1.11.7 |
| Databricks workspace | any |

---

## Quickstart (Local Setup)

### Option A — using `uv` (recommended, faster)

```bash
# Install uv if you don't have it yet
pip install uv

# Create a virtual environment and install all dependencies from the lockfile
uv sync

# Activate the environment
source .venv/bin/activate   # macOS/Linux
# .venv\Scripts\activate    # Windows
```

### Option B — using plain `pip`

```bash
python -m venv .venv
source .venv/bin/activate   # macOS/Linux
# .venv\Scripts\activate    # Windows

pip install -e .
# Or install the adapters directly:
# pip install "dbt-core>=1.11.8" "dbt-databricks>=1.11.7"
```

---

## dbt Setup

### 1. Create `profiles.yml`

`dbt_mann/profiles.yml` is intentionally **gitignored** to prevent committing secrets.  
You can place your profile in either of two locations:

- **Project-local** (recommended for this repo): `dbt_mann/profiles.yml`
- **Global** (applies to all your dbt projects): `~/.dbt/profiles.yml`

Below is a template — fill in your own Databricks values:

```yaml
# dbt_mann/profiles.yml  (never commit this file!)
dbt_mann:
  target: dev
  outputs:
    dev:
      type: databricks
      catalog: "<unity_catalog_name>"        # e.g. main
      schema: "<default_schema>"             # e.g. dbt_dev
      host: "<databricks-workspace-host>"    # e.g. adb-xxxx.azuredatabricks.net
      http_path: "<sql-warehouse-http-path>" # e.g. /sql/1.0/warehouses/xxxx
      token: "{{ env_var('DATABRICKS_TOKEN') }}"
```

> **Tip:** Store sensitive values like `token` in environment variables and reference them with `env_var()` as shown above. Never hard-code credentials.

### 2. Verify the connection

```bash
cd dbt_mann
dbt debug
```

### 3. Install dbt packages

```bash
dbt deps
```

### 4. Load seed data

```bash
dbt seed
```

### 5. Run all models

```bash
dbt run
```

### 6. Run tests

```bash
dbt test
```

---

## Databricks Adapter Notes

This project uses [`dbt-databricks`](https://docs.getdbt.com/docs/core/connect-data-platform/databricks-setup), which connects dbt to Databricks SQL Warehouses or All-Purpose Clusters.

**Required configuration placeholders** (set as environment variables, not in code):

| Variable | Description |
|---|---|
| `DATABRICKS_TOKEN` | Personal Access Token (PAT) or service principal token |
| `DATABRICKS_HOST` | Workspace hostname (e.g. `adb-xxxx.azuredatabricks.net`) |
| `DATABRICKS_HTTP_PATH` | HTTP path of your SQL Warehouse or cluster |

You can export them in your shell before running dbt:

```bash
export DATABRICKS_TOKEN="dapi..."
export DATABRICKS_HOST="adb-xxxx.azuredatabricks.net"
export DATABRICKS_HTTP_PATH="/sql/1.0/warehouses/xxxx"
```

---

## Medallion Architecture

This repo implements the **medallion (lakehouse) architecture** — a design pattern that organises data into three quality layers:

| Layer | Schema | Description |
|-------|--------|-------------|
| 🥉 **Bronze** | `bronze` | Raw data ingested as-is from source systems. Seeds (CSV files) are loaded here. Minimal transformations applied. |
| 🥈 **Silver** | `silver` | Cleaned, deduplicated, and standardised data. Business rules start to be applied here. |
| 🥇 **Gold** | `gold` | Aggregated, business-ready tables designed for analytics, dashboards, and reporting. |

All three layers are materialised as **tables** in Databricks, each in its own schema.

---

## Common Commands

```bash
# Navigate to the dbt project first
cd dbt_mann

# Check connection and configuration
dbt debug

# Install packages listed in packages.yml
dbt deps

# Load CSV seed files into the bronze schema
dbt seed

# Run all models (bronze → silver → gold)
dbt run

# Run models for a specific layer only
dbt run --select bronze
dbt run --select silver
dbt run --select gold

# Run a single model
dbt run --select <model_name>

# Run all tests
dbt test

# Run tests for a specific model
dbt test --select <model_name>

# Compile SQL without executing
dbt compile

# Generate and serve documentation
dbt docs generate
dbt docs serve

# Delete compiled artifacts
dbt clean
```

---

## Contributing

Contributions, bug reports, and feature requests are welcome!

1. Fork the repository.
2. Create a feature branch: `git checkout -b feat/my-feature`.
3. Commit your changes: `git commit -m "feat: add my feature"`.
4. Push and open a Pull Request.

Please follow the existing code style and add tests where applicable.

---

## License

**TBD** — No license file has been added to this repository yet.

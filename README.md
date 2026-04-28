# DBT Tutorials

A collection of small, Python-focused tutorials and experiments for working with **dbt** (data build tool).

## What’s in this repo?

- Example dbt project(s) / snippets
- Helper Python scripts (as needed) to support dbt workflows
- Notes and references gathered while learning

> If you’re looking for a specific tutorial, start by browsing the folders at the repository root.

## Prerequisites

- Python 3.10+ (recommended)
- `dbt` installed for your target adapter (e.g., `dbt-core`, `dbt-postgres`, `dbt-bigquery`, etc.)

Install dbt (example):

```bash
python -m pip install --upgrade pip
pip install dbt-core
# then add the adapter you need, e.g.
# pip install dbt-postgres
```

## Getting started

1. Clone the repo

```bash
git clone https://github.com/Manan115/DBT_tutorials.git
cd DBT_tutorials
```

2. (Optional) Create a virtual environment

```bash
python -m venv .venv
source .venv/bin/activate  # macOS/Linux
# .venv\Scripts\activate   # Windows
```

3. Install Python dependencies (if a `requirements.txt` exists)

```bash
pip install -r requirements.txt
```

4. Run dbt commands inside the relevant dbt project directory (if present)

```bash
# example
cd path/to/your_dbt_project

dbt debug
dbt deps
dbt run
dbt test
```

## Resources

- dbt docs: https://docs.getdbt.com/docs/introduction
- dbt Discourse: https://discourse.getdbt.com/
- dbt Community Slack: https://community.getdbt.com/
- dbt Events: https://events.getdbt.com
- dbt Blog: https://blog.getdbt.com/

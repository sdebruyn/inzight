# in⚡️ight

A simple data project using [dbt](https://getdbt.com), [DuckDB](https://duckdb.org/) and [Superset](https://superset.apache.org/) to analyse your electricity data from Belgian smart meters.

## Usage

### Available models & documentation

The dbt documentation is available at [https://sdebruyn.github.io/inzight](https://sdebruyn.github.io/inzight).

### Requirements

* Python 3.8 or newer
* Docker (for Superset)
* Your source data (see below)

### Setup

1. Clone with all submodules: `git clone --recurse-submodules https://github.com/sdebruyn/inzight.git`
1. Install the dependencies: `pip install -r requirements.txt`
1. Create a profile named `inzight` in `~/.dbt/profiles.yml` with the following content:

    ```yaml
    inzight:
      target: dev
      outputs:
        dev:
          type: duckdb
          threads: 12 # should be the number of cores in your system (or double if you have hyperthreading)
          database: /tmp/inzight.duckdb # or any other path on your system
          external_root: /Users/Quack/code/inzight/assets # point to the assets folder in this repo
    ```

### Source data

The project expects an export from *Mijn Fluvius* with *Kwartierwaarden*. The export should go in `assets/fluvius.csv`.

My column names are in Dutch, I have no idea what you get if you have a different language setting for Fluvius. Please create an issue with your column names if yours are not in Dutch.

### Analyzing

1. Make sure your source data has been added as a file named `assets/fluvius.csv`
1. Run `dbt deps` to install the dbt package dependencies
1. Run `dbt build` to create all models
1. Run `docker compose up -d` to start Superset
1. Open `http://localhost:8088` in your browser to go to Superset
1. Log in with the default credentials: `admin` / `admin`
1. Create a new database (*Settings > Database Connections*) with the following settings:

    | Setting | Value |
    | --- | --- |
    | Display Name | `inzight` |
    | SQLAlchemy URI | `duckdb:///:memory:` |
1. Register the data marts in Superset as the following query: `select * from '/app/assets/name_of_the_mart.parquet';`

## Note

It's (like most hobby projects) a never-ending work in progress. Contributions are welcome!

## License

MIT License

Code under `superset/` is licensed under the Apache License 2.0 and taken from the [Superset repository](https://github.com/apache/superset)

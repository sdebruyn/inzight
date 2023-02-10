# in⚡️ight

A simple dbt project using duckdb to analyse your electricity usage data from Belgian smart meters.

## Usage

### Setup

1. Install the dependencies: `pip install -r requirements.txt`
1. Create a profile named `inzight` in your `~/.dbt/profiles.yml` file. See [the dbt-duckdb docs](https://github.com/jwills/dbt-duckdb) for more info.

### Source data

The project expects an export from *Mijn Fluvius* with *Kwartierwaarden*. The export should go in `assets/fluvius.csv`.

My column names are in Dutch, I have no idea what you get if you have a different language setting for Fluvius. Please create an issue with your column names if yours are not in Dutch.

## Note

It's a work in progress, do whatever you want with it.

## License

MIT License

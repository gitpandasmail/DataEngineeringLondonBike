Welcome to your new dbt project!

# How to use the project

## 1. Setup a Python Environment

You can use uv (https://docs.astral.sh/uv/) or whatever tool you like to create the environment.

Follow the guides there on how to set up an python env and then activate it.

Then install dbt using:

```
pip install dbt-core dbt-clickhouse
```

## 2. Setup dbt locally

You will need to create this file: ~\.dbt\profile.yml

and fill it with:

```
andmetehnika_clickhouse:
  target: dev
  outputs:
    dev:
      type: clickhouse
      schema: default          # ClickHouse “database” for your models
      host: localhost          # or your Docker host/IP
      port: 8123               # HTTP
      user: dbt
      password: supersecret             # if you set one, put it here
      secure: false            # true if you published HTTPS (8443)
```

### Using the starter project

Try running the following commands:
- dbt run
- dbt test

### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

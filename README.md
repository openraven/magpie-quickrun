# Magpie Quickrun

** This repo is a work in progress!  The instructions listed will not work until the main Magpie repository is updated. ** This will be announced in the Open Raven Research Slack channel.

## Run Open Raven's [Magpie CSPM](https://github.com/openraven/magpie) with only a few simple commands
This quickrun sets up PostgreSQL, PGAdmin (optional), and Magpie packaged together and ready to start discovering assets and applying policies.

This quickrun does not support advanced configurations (distributed discovery, additional plugins, etc).  If that's needed please see the [Magpie Configuration README](https://github.com/openraven/magpie#configuration)

## Prerequisites
- Docker (https://docs.docker.com/get-docker/)
- Docker Compose (https://docs.docker.com/compose/install/)


## Running Magpie
### Credentials
While Magpie uses the AWS CLI's credential loading pattern, this quickrun uses *only* environmental variables for simplicity.  This means you'll need to ensure the following values are set:
- AWS_SECRET_ACCESS_KEY
- AWS_ACCESS_KEY_ID
- AWS_REGION (`us-east-1` is a fine choice)
- AWS_SESSION_TOKEN (If using STS)

### Configuration
Edit `config.yaml` in the root of this project to your liking.  By default Magpie will discover *all* supported AWS services in all regions. If you have a large infrastructure the scan could take hours.

If you're unsure what services to start with, `iam` is a great service with a lot of [CIS Benchmark Rules](https://www.cisecurity.org/benchmark/amazon_web_services/) to validate against.

### Run!
From the root of this repository:
```bash
docker-compose build
docker-compose up
```
This will fire up the Docker infrastructure and start your discovery and policy scans. Scan reports and violations will show up in the output.

You only need to run the build step after you've modified `config.yaml` to ensure the Magpie image reflects your changes.


## Looking at the raw asset data
Magpie Discovery is configured to store asset information in PostgreSQL, which is read by Magpie Policy for discoverying violations.  If you'd like to see the raw asset data in PostgreSQL:
1. Open http://localhost:15432
2. Login with user `admin@example.com` and password `magpie`
3. Add a server in pgadmin with the following properties:
   - Host: pg
   - User: magpie
   - Password: magpie

The `magpie` database and the default schema will contain all discovery data.


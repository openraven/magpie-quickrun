# Magpie Quickrun

## East setup for [Magpie](https://github.com/openraven/magpie) from Docker Desktop
This quickrun sets up PostgreSQL, PGAdmin (optional), and Magpie packaged together.

This quick-run does not support advanced configurations (distributed discovery, additional plugins, etc.).  If that's needed please see the [Magpie Configuration README](https://github.com/openraven/magpie#configuration)

## Prerequisites
- Docker (https://docs.docker.com/get-docker/)
- Docker Compose (https://docs.docker.com/compose/install/)

## clone this repo 
```code git clone https://github.com/openraven/magpie-quickrun ```

## Running Magpie
### Credentials
#### AWS
While Magpie uses the AWS CLI's credential loading pattern, this quickrun uses *only* environmental variables for simplicity.  This means you'll need to ensure the following values are set:
- AWS_SECRET_ACCESS_KEY
- AWS_ACCESS_KEY_ID
- AWS_REGION (`us-east-1` is a fine choice)
- AWS_SESSION_TOKEN (If using STS)
#### GCP
Replace the content of *gcp-credentials.json* file by the one downloaded from the target GCP Account being discovered

### Configuration
Edit `config.yaml` in the root of this project to your liking.  By default, Magpie will discover *all* supported AWS services in all regions. If you have a large infrastructure the scan could take hours.

If you're unsure what services to start with, `iam` is a great service with a lot of [CIS Benchmark Rules](https://www.cisecurity.org/benchmark/amazon_web_services/) to validate against.

### Run
From the root of this repository:
```bash
./magpie.sh
```
This will fire shut down any previous Docker infrastructure, build a new Magpie image, and start your discovery and policy scans. Scan reports and violations will show up in the output.

### DMAP
Magpie Quickrun also attempts to map data servcies (non-native) running on EC2 instances. This requires credentials that have Lambda management capabilities.  If you'd like to disable DMAP set `MAGPIE_DMAP=false` in your environment prior to running `./magpie.sh`
## Looking at the raw asset data

You need to remove the `--exit-code-from magpie` from `magpie.sh` in order to utilize this feature. 

Magpie Discovery is configured to store asset information in PostgreSQL, which is read by Magpie Policy for discoverying violations.  If you'd like to see the raw asset data in PostgreSQL:
1. Open http://localhost:15432
2. Login with user `admin@example.com` and password `magpie`
3. Add a server in pgadmin with the following properties:
   - Host: pg
   - User: magpie
   - Password: magpie

The `magpie` database and the default schema will contain all discovery data.


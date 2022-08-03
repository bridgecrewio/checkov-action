[![Maintained by Bridgecrew.io](https://img.shields.io/badge/maintained%20by-bridgecrew.io-blueviolet)](https://bridge.dev/2WBms5Q)
[![slack-community](https://img.shields.io/badge/Slack-4A154B?style=plastic&logo=slack&logoColor=white)](https://slack.bridgecrew.io/)

# Checkov GitHub action

This GitHub Action runs [Checkov](https://github.com/bridgecrewio/checkov) against an Infrastructure-as-Code repository.
Checkov performs static security analysis of Terraform & CloudFormation Infrastructure code .

## Example usage for IaC and SCA

```yaml
on: [push]
jobs:
  checkov-job:
    runs-on: ubuntu-latest
    name: checkov-action
    steps:
      - name: Checkout repo
        uses: actions/checkout@master

      - name: Run Checkov action
        id: checkov
        uses: bridgecrewio/checkov-action@master
        with:
          directory: example/
          file: example/tfplan.json # optional: provide the path for resource to be scanned. This will override the directory if both are provided.
          check: CKV_AWS_1 # optional: run only a specific check_id. can be comma separated list
          skip_check: CKV_AWS_2 # optional: skip a specific check_id. can be comma separated list
          quiet: true # optional: display only failed checks
          soft_fail: true # optional: do not return an error code if there are failed checks
          framework: terraform # optional: run only on a specific infrastructure {cloudformation,terraform,kubernetes,all}
          output_format: sarif # optional: the output format, one of: cli, json, junitxml, github_failed_only, or sarif. Default: sarif
          download_external_modules: true # optional: download external terraform modules from public git repositories and terraform registry
          log_level: DEBUG # optional: set log level. Default WARNING
          config_file: path/this_file
          baseline: cloudformation/.checkov.baseline # optional: Path to a generated baseline file. Will only report results not in the baseline.
          container_user: 1000 # optional: Define what UID and / or what GID to run the container under to prevent permission issues
```

## Example usage for container images

```yaml
on: [push]

env:
  IMAGE_NAME: ${{ github.repository }}:${{ github.sha }}
  IMAGE_PATH: /path/DOCKERFILE

jobs:
  checkov-image-scan:
    runs-on: ubuntu-latest
    name: checkov-image-scan
    steps:
      - name: Checkout repo
        uses: actions/checkout@master

      - name: Build the image
        run: docker build -t $IMAGE_NAME $IMAGE_PATH

      - name: Run Checkov action
        id: checkov
        uses: bridgecrewio/checkov-action@master
        with:
          quiet: true # optional: display only failed checks
          soft_fail: true # optional: do not return an error code if there are failed checks
          log_level: DEBUG # optional: set log level. Default WARNING
          docker-image: $IMAGE_NAME # define the name of the image to scan
          dockerfile-path: $IMAGE_PATH # path to the Dockerfile
          container_user: 1000 # optional: Define what UID and / or what GID to run the container under to prevent permission issues
```

Note that this example uses the latest version (`master`) but you could also use a static version (e.g. `v3`).
Also, the check ids specified for '--check' and '--skip-check' must be mutually exclusive.

[![Maintained by Bridgecrew.io](https://img.shields.io/badge/maintained%20by-bridgecrew.io-blueviolet)](https://bridge.dev/2WBms5Q)
[![slack-community](https://slack.bridgecrew.io/badge.svg)](https://slack.bridgecrew.io/?utm_source=github&utm_medium=organic_oss&utm_campaign=checkov-action)

# Checkov GitHub action

This GitHub Action runs [Checkov](https://github.com/bridgecrewio/checkov) against an Infrastructure-as-Code repository.
Checkov performs static security analysis of Terraform & CloudFormation Infrastructure code .

## Example usage

```yaml
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
          check: CKV_AWS_1 # optional: run only a specific check_id. can be comma separated list
          skip_check: CKV_AWS_1 # optional: skip a specific check_id. can be comma separated list
          quiet: true # optional: display only failed checks
          soft_fail: true # optional: do not return an error code if there are failed checks
          framework: terraform # optional: run only on a specific infrastructure {cloudformation,terraform,kubernetes,all}
          output_format: json # optional: the output format, one of: cli, json, junitxml, github_failed_only
          download_external_modules: true # optional: download external terraform modules from public git repositories and terraform registry
          log_level: DEBUG # optional: set log level. Default WARNING
```

Note that this example uses the latest version (`master`) but you could also use a static version (e.g. `v3`).

# Checkov Github action

This Github Action runs [Checkov](https://github.com/bridgecrewio/checkov) against an Infrastructure-as-Code repository. 
Checkov performs static security analysis of Terraform & CloudFormation Infrastructure code .


## Example usage

```yaml
jobs:
  checkov-job:
    runs-on: ubuntu-latest
    name: checkov-action
    steps:
      - name: Checkout repo
        uses: actions/checkout@v2

      - name: Run Checkov action
        id: checkov
        uses: bridgecrewio/checkov-action@master
        with:
          directory: example/
          skip_check: CKV_AWS_1 # optional: skip a specific check_id
```
Note that this example uses the latest version (`master`) but you could also use a static version (e.g. `v3`).

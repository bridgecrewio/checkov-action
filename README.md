# Checkov IaC security scan action

This Github Action runs Checkov against an Infrastructure-as-Code repository. Checkov does static security analysis of Terraform & CloudFormation Iaac.

## Inputs

## Outputs

## Example usage

```yaml
steps:
  - uses: actions/checkout@v2
  - uses: cmavr8/checkov-action@v1
```
Note that this example uses a static version (`v1`).

[![Maintained by Bridgecrew.io](https://img.shields.io/badge/maintained%20by-bridgecrew.io-blueviolet)](https://bridge.dev/2WBms5Q)
[![slack-community](https://img.shields.io/badge/Slack-4A154B?style=plastic&logo=slack&logoColor=white)](https://slack.bridgecrew.io/)

# Checkov GitHub action

This GitHub Action runs [Checkov](https://github.com/bridgecrewio/checkov) against infrastructure-as-code,
open source packages, container images, and CI/CD configurations to identify misconfigurations, vulnerabilities, and license compliance issues.

## Example usage for IaC and SCA

```yaml
name: checkov

# Controls when the workflow will run
on:
  # Triggers the workflow on push or pull request events but only for the "main" branch
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

  # Allows you to run this workflow manually from the Actions tab
  workflow_dispatch:

# A workflow run is made up of one or more jobs that can run sequentially or in parallel
jobs:
  # This workflow contains a single job called "scan"
  scan:
    permissions:
      contents: read # for actions/checkout to fetch code
      security-events: write # for github/codeql-action/upload-sarif to upload SARIF results
      actions: read # only required for a private repository by github/codeql-action/upload-sarif to get the Action run status
      
    # The type of runner that the job will run on
    runs-on: ubuntu-latest

    # Steps represent a sequence of tasks that will be executed as part of the job
    steps:
      # Checks-out your repository under $GITHUB_WORKSPACE, so your job can access it
      - uses: actions/checkout@v3

      - name: Checkov GitHub Action
        uses: bridgecrewio/bridgecrew-action@master
        
      - name: Upload SARIF file
        uses: github/codeql-action/upload-sarif@v2
        
        # Results are generated only on a success or failure
        # this is required since GitHub by default won't run the next step
        # when the previous one has failed. Security checks that do not pass will 'fail'.
        # An alternative is to add `continue-on-error: true` to the previous step
        # Or 'soft_fail: true' to checkov.
        if: success() || failure()
        with:
          sarif_file: results.sarif
```

## Example usage for container images and 'with' block

```yaml
on: [push]

env:
  IMAGE_NAME: ${{ github.repository }}:${{ github.sha }}
  IMAGE_PATH: /path/

jobs:
  checkov-image-scan:
    runs-on: ubuntu-latest
    name: checkov-image-scan
    steps:
      - name: Checkout repo
        uses: actions/checkout@master

      - name: Build the image
        run: docker build -t ${{ env.IMAGE_NAME }} ${{ env.IMAGE_PATH }}

      - name: Run Checkov action
        id: checkov
        uses: bridgecrewio/checkov-action@master
        with:
          quiet: true # optional: display only failed checks
          soft_fail: true # optional: do not return an error code if there are failed checks
          log_level: DEBUG # optional: set log level. Default WARNING
          docker_image: ${{ env.IMAGE_NAME }} # define the name of the image to scan
          dockerfile_path: ${{ format('{0}/Dockerfile', env.IMAGE_PATH) }} # path to the Dockerfile
          container_user: 1000 # optional: Define what UID and / or what GID to run the container under to prevent permission issues
          api-key: ${{ secrets.BC_API_KEY }} # Bridgecrew API key stored as a GitHub secret
```

Note that this example uses the latest version (`master`) but you could also use a static version (e.g. `v3`).
Also, the check ids specified for '--check' and '--skip-check' must be mutually exclusive.

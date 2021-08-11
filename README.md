![cftest](https://github.com/theonestack/hl-component-synthetics-canary/actions/workflows/rspec.yaml/badge.svg)

# synthetics-canary CfHighlander component

Deploys CloudWatch Synthetics Canaries

```bash
kurgan add synthetics-canary
```

## Requirements

## Parameters

| Name | Use | Default | Global | Type | Allowed Values |
| ---- | --- | ------- | ------ | ---- | -------------- |
| BucketName | The location in Amazon S3 where Synthetics stores artifacts from the runs of this canary. Artifacts include the log file, screenshots, and HAR files. | None | false | string


## Configuration

### Canary Definition

```yaml
canaries:
  - name: website
    script_location: src/canary.py
    runtime_version: syn-python-selenium-1.0
    schedule_expression: rate(1 minute)
    run_config:
      EnvironmentVariables:
        URL:
          Fn::Sub: ${URL}
```

## Outputs/Exports

| Name | Value | Exported |
| ---- | ----- | -------- |
| ${canary}Id | The ID of the canary | true

## Development

```bash
gem install cfhighlander
```

or via docker

```bash
docker pull theonestack/cfhighlander
```

### Testing

```bash
gem install rspec
```

```bash
rspec
```
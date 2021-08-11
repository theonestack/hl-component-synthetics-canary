CloudFormation do

  tags = []
  tags << { Key: 'Environment', Value: Ref(:EnvironmentName) }
  tags << { Key: 'EnvironmentType', Value: Ref(:EnvironmentType) }

  extra_tags = external_parameters.fetch(:extra_tags, {})
  extra_tags.each { |key,value| tags << { Key: key, Value: value } }
  
  filter = /[^0-9a-z ]/i

  canaries = external_parameters.fetch(:canaries, [])
  canaries.each do |canary|
      
    name = canary['name']
    raise ArgumentError, "Canary is missing the required parameter 'name'" unless name
    logical_id = name.gsub(filter, '')
    start_canary_after_creation = canary.fetch('start_canary_after_creation', true)
    artifact_S3_location = canary.fetch('artifact_S3_location', "s3://${BucketName}/")
    schedule_expression = canary.fetch('schedule_expression', 'rate(1 minute)')
    schedule_duration_in_seconds = canary.fetch('schedule_duration_in_seconds', 0)
    schedule = { Expression: schedule_expression, DurationInSeconds: schedule_duration_in_seconds }
    runtime_version = canary['runtime_version']
    raise ArgumentError, "Canary #{name} is missing the required parameter 'runtime_version'" unless runtime_version
    script_location = canary['script_location']
    raise ArgumentError, "Canary #{name} is missing the required parameter 'script_location'" unless script_location
    code = { Handler: 'handler.handler', Script: IO.read(script_location) }

    Synthetics_Canary(logical_id) do
        ArtifactS3Location FnSub(artifact_S3_location)
        Code code
        ExecutionRoleArn FnGetAtt("#{logical_id}Role", 'Arn')
        FailureRetentionPeriod canary['failure_retention_period'] if canary.has_key?('failure_retention_period')
        Name FnJoin("-", [Ref('EnvironmentName'), name])
        RunConfig canary['run_config'] if canary.has_key?('run_config')
        RuntimeVersion runtime_version
        Schedule schedule
        StartCanaryAfterCreation start_canary_after_creation
        SuccessRetentionPeriod canary['success_retention_period'] if canary.has_key?('success_retention_period')
        VPCConfig canary['vpc_config'] if canary.has_key?('vpc_config')
        Tags tags + [{ Key: 'Name', Value: FnJoin('-', [ Ref(:EnvironmentName), name ]) }]
    end

    default_policy = external_parameters.fetch(:canary_iam_policies)
    custom_policies = canary.fetch('iam_policies', {})
    policies = default_policy.merge(custom_policies)

    IAM_Role("#{logical_id}Role") do
        AssumeRolePolicyDocument service_assume_role_policy('lambda')
        Path '/'
        Policies iam_role_policies(policies)
        ManagedPolicyArns canary['managed_policies'] if canary.has_key?('managed_policies')
    end

    Output("#{logical_id}Id") {
        Value(FnGetAtt(logical_id, 'Id'))
        Export FnSub("${EnvironmentName}-#{external_parameters[:component_name]}-#{logical_id}Id")
    }

  end
  
end
CfhighlanderTemplate do

  Name 'synthetics-canary'

  DependsOn 'lib-iam@0.1.0'
  
  ComponentVersion component_version
  Description "#{component_name} - #{component_version}"

  Parameters do
    ComponentParam 'EnvironmentName', 'dev', isGlobal: true
    ComponentParam 'EnvironmentType', 'development', isGlobal: true, allowedValues: ['development', 'production']
    ComponentParam 'BucketName'
  end
    
end
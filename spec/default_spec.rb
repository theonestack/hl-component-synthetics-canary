require 'yaml'

describe 'compiled component synthetics-canary' do
  
  context 'cftest' do
    it 'compiles test' do
      expect(system("cfhighlander cftest #{@validate} --tests tests/default.test.yaml")).to be_truthy
    end      
  end
  
  let(:template) { YAML.load_file("#{File.dirname(__FILE__)}/../out/tests/default/synthetics-canary.compiled.yaml") }
  
  context "Resource" do

    
    context "canary1" do
      let(:resource) { template["Resources"]["canary1"] }

      it "is of type AWS::Synthetics::Canary" do
          expect(resource["Type"]).to eq("AWS::Synthetics::Canary")
      end
      
      it "to have property ArtifactS3Location" do
          expect(resource["Properties"]["ArtifactS3Location"]).to eq({"Fn::Sub"=>"s3://${BucketName}/"})
      end
      
      it "to have property Code" do
          expect(resource["Properties"]["Code"]).to eq({"Handler"=>"handler.handler", "Script"=>"# code"})
      end
      
      it "to have property ExecutionRoleArn" do
          expect(resource["Properties"]["ExecutionRoleArn"]).to eq({"Fn::GetAtt"=>["canary1Role", "Arn"]})
      end
      
      it "to have property Name" do
          expect(resource["Properties"]["Name"]).to eq({"Fn::Join"=>["-", [{"Ref"=>"EnvironmentName"}, "canary1"]]})
      end
      
      it "to have property RuntimeVersion" do
          expect(resource["Properties"]["RuntimeVersion"]).to eq("syn-python-selenium-1.0")
      end
      
      it "to have property Schedule" do
          expect(resource["Properties"]["Schedule"]).to eq({"Expression"=>"rate(1 minute)", "DurationInSeconds"=>0})
      end
      
      it "to have property StartCanaryAfterCreation" do
          expect(resource["Properties"]["StartCanaryAfterCreation"]).to eq(true)
      end
      
      it "to have property Tags" do
          expect(resource["Properties"]["Tags"]).to eq([{"Key"=>"Environment", "Value"=>{"Ref"=>"EnvironmentName"}}, {"Key"=>"EnvironmentType", "Value"=>{"Ref"=>"EnvironmentType"}}, {"Key"=>"Name", "Value"=>{"Fn::Join"=>["-", [{"Ref"=>"EnvironmentName"}, "canary1"]]}}])
      end
      
    end
    
    context "canary1Role" do
      let(:resource) { template["Resources"]["canary1Role"] }

      it "is of type AWS::IAM::Role" do
          expect(resource["Type"]).to eq("AWS::IAM::Role")
      end
      
      it "to have property AssumeRolePolicyDocument" do
          expect(resource["Properties"]["AssumeRolePolicyDocument"]).to eq({"Version"=>"2012-10-17", "Statement"=>[{"Effect"=>"Allow", "Principal"=>{"Service"=>"lambda.amazonaws.com"}, "Action"=>"sts:AssumeRole"}]})
      end
      
      it "to have property Path" do
          expect(resource["Properties"]["Path"]).to eq("/")
      end
      
      it "to have property Policies" do
          expect(resource["Properties"]["Policies"]).to eq([{"PolicyName"=>"default_canary_policy", "PolicyDocument"=>{"Statement"=>[{"Sid"=>"defaultcanarypolicy", "Action"=>["s3:PutObject", "s3:GetBucketLocation", "s3:ListAllMyBuckets", "cloudwatch:PutMetricData", "logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"], "Resource"=>["*"], "Effect"=>"Allow"}]}}])
      end
      
    end
    
    context "canary2" do
      let(:resource) { template["Resources"]["canary2"] }

      it "is of type AWS::Synthetics::Canary" do
          expect(resource["Type"]).to eq("AWS::Synthetics::Canary")
      end
      
      it "to have property ArtifactS3Location" do
          expect(resource["Properties"]["ArtifactS3Location"]).to eq({"Fn::Sub"=>"s3://${BucketName}/"})
      end
      
      it "to have property Code" do
          expect(resource["Properties"]["Code"]).to eq({"Handler"=>"handler.handler", "Script"=>"// code"})
      end
      
      it "to have property ExecutionRoleArn" do
          expect(resource["Properties"]["ExecutionRoleArn"]).to eq({"Fn::GetAtt"=>["canary2Role", "Arn"]})
      end
      
      it "to have property Name" do
          expect(resource["Properties"]["Name"]).to eq({"Fn::Join"=>["-", [{"Ref"=>"EnvironmentName"}, "canary2"]]})
      end
      
      it "to have property RuntimeVersion" do
          expect(resource["Properties"]["RuntimeVersion"]).to eq("syn-nodejs-puppeteer-3.2")
      end
      
      it "to have property Schedule" do
          expect(resource["Properties"]["Schedule"]).to eq({"Expression"=>"rate(1 minute)", "DurationInSeconds"=>0})
      end
      
      it "to have property StartCanaryAfterCreation" do
          expect(resource["Properties"]["StartCanaryAfterCreation"]).to eq(true)
      end
      
      it "to have property Tags" do
          expect(resource["Properties"]["Tags"]).to eq([{"Key"=>"Environment", "Value"=>{"Ref"=>"EnvironmentName"}}, {"Key"=>"EnvironmentType", "Value"=>{"Ref"=>"EnvironmentType"}}, {"Key"=>"Name", "Value"=>{"Fn::Join"=>["-", [{"Ref"=>"EnvironmentName"}, "canary2"]]}}])
      end
      
    end
    
    context "canary2Role" do
      let(:resource) { template["Resources"]["canary2Role"] }

      it "is of type AWS::IAM::Role" do
          expect(resource["Type"]).to eq("AWS::IAM::Role")
      end
      
      it "to have property AssumeRolePolicyDocument" do
          expect(resource["Properties"]["AssumeRolePolicyDocument"]).to eq({"Version"=>"2012-10-17", "Statement"=>[{"Effect"=>"Allow", "Principal"=>{"Service"=>"lambda.amazonaws.com"}, "Action"=>"sts:AssumeRole"}]})
      end
      
      it "to have property Path" do
          expect(resource["Properties"]["Path"]).to eq("/")
      end
      
      it "to have property Policies" do
          expect(resource["Properties"]["Policies"]).to eq([{"PolicyName"=>"default_canary_policy", "PolicyDocument"=>{"Statement"=>[{"Sid"=>"defaultcanarypolicy", "Action"=>["s3:PutObject", "s3:GetBucketLocation", "s3:ListAllMyBuckets", "cloudwatch:PutMetricData", "logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"], "Resource"=>["*"], "Effect"=>"Allow"}]}}])
      end
      
    end
    
    context "canary3" do
      let(:resource) { template["Resources"]["canary3"] }

      it "is of type AWS::Synthetics::Canary" do
          expect(resource["Type"]).to eq("AWS::Synthetics::Canary")
      end
      
      it "to have property ArtifactS3Location" do
          expect(resource["Properties"]["ArtifactS3Location"]).to eq({"Fn::Sub"=>"s3://${BucketName}/"})
      end
      
      it "to have property Code" do
          expect(resource["Properties"]["Code"]).to eq({"Handler"=>"handler.handler", "Script"=>"// code"})
      end
      
      it "to have property ExecutionRoleArn" do
          expect(resource["Properties"]["ExecutionRoleArn"]).to eq({"Fn::GetAtt"=>["canary3Role", "Arn"]})
      end
      
      it "to have property Name" do
          expect(resource["Properties"]["Name"]).to eq({"Fn::Join"=>["-", [{"Ref"=>"EnvironmentName"}, "canary3"]]})
      end
      
      it "to have property RuntimeVersion" do
          expect(resource["Properties"]["RuntimeVersion"]).to eq("syn-nodejs-puppeteer-3.1")
      end
      
      it "to have property Schedule" do
          expect(resource["Properties"]["Schedule"]).to eq({"Expression"=>"rate(1 minute)", "DurationInSeconds"=>0})
      end
      
      it "to have property StartCanaryAfterCreation" do
          expect(resource["Properties"]["StartCanaryAfterCreation"]).to eq(true)
      end
      
      it "to have property Tags" do
          expect(resource["Properties"]["Tags"]).to eq([{"Key"=>"Environment", "Value"=>{"Ref"=>"EnvironmentName"}}, {"Key"=>"EnvironmentType", "Value"=>{"Ref"=>"EnvironmentType"}}, {"Key"=>"Name", "Value"=>{"Fn::Join"=>["-", [{"Ref"=>"EnvironmentName"}, "canary3"]]}}])
      end
      
    end
    
    context "canary3Role" do
      let(:resource) { template["Resources"]["canary3Role"] }

      it "is of type AWS::IAM::Role" do
          expect(resource["Type"]).to eq("AWS::IAM::Role")
      end
      
      it "to have property AssumeRolePolicyDocument" do
          expect(resource["Properties"]["AssumeRolePolicyDocument"]).to eq({"Version"=>"2012-10-17", "Statement"=>[{"Effect"=>"Allow", "Principal"=>{"Service"=>"lambda.amazonaws.com"}, "Action"=>"sts:AssumeRole"}]})
      end
      
      it "to have property Path" do
          expect(resource["Properties"]["Path"]).to eq("/")
      end
      
      it "to have property Policies" do
          expect(resource["Properties"]["Policies"]).to eq([{"PolicyName"=>"default_canary_policy", "PolicyDocument"=>{"Statement"=>[{"Sid"=>"defaultcanarypolicy", "Action"=>["s3:PutObject", "s3:GetBucketLocation", "s3:ListAllMyBuckets", "cloudwatch:PutMetricData", "logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"], "Resource"=>["*"], "Effect"=>"Allow"}]}}])
      end
      
    end
    
  end

end
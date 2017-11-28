
include_recipe 'aws-ssm'

puts "Property found: #{AwsSsmProperty.get_property('test-data', true, 'us-east-1', node['aws-ssm-test']['aws_access_key_id'], node['aws-ssm-test']['aws_secret_access_key'])}"

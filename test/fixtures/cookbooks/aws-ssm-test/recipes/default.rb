
include_recipe 'aws-ssm'

puts "Property found: #{AwsSsmParameterStore.get_parameter('test-data', true, 'us-east-1', node['aws-ssm-test']['aws_access_key_id'], node['aws-ssm-test']['aws_secret_access_key'])}"
puts "Property not found: #{AwsSsmParameterStore.get_parameter('no-test-data', true, 'us-east-1', node['aws-ssm-test']['aws_access_key_id'], node['aws-ssm-test']['aws_secret_access_key'])}"

puts "Properties found: #{AwsSsmParameterStore.get_parameters_by_path('/test-path/testing', true, true, 'us-east-1', node['aws-ssm-test']['aws_access_key_id'], node['aws-ssm-test']['aws_secret_access_key'])}"

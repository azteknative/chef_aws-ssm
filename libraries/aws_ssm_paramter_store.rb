require 'aws-sdk'

class Chef::Recipe::AwsSsmParameterStore
  def self.get_parameter(name, with_decryption=false, region, aws_access_key_id, aws_secret_access_key)
    if aws_access_key_id.nil? && aws_secret_access_key.nil?
      client = Aws::SSM::Client.new(region: region)
    else
      client = Aws::SSM::Client.new(credentials: Aws::Credentials.new(aws_access_key_id, aws_secret_access_key), region: region)
    end

    begin
      result = client.get_parameter({ name: name, with_decryption: with_decryption})
    rescue Aws::SSM::Errors::ServiceError => e
      Chef::Log.fatal('Error querying SSM API!')
      Chef::Log.debug("Exception is: #{e}")
      raise e
    end
    result.parameter.value
  end
end


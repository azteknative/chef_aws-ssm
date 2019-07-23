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
    rescue Aws::SSM::Errors::ParameterNotFound
      Chef::Log.debug("Parameter with name #{name} not found.")
      return nil
    rescue Aws::SSM::Errors::ServiceError => e
      Chef::Log.fatal('Error querying SSM API!')
      Chef::Log.debug("Exception is: #{e}")
      raise e
    end
    result.parameter.value
  end

  def self.get_parameters(names, with_decryption=false, region, aws_access_key_id, aws_secret_access_key)
    if aws_access_key_id.nil? && aws_secret_access_key.nil?
      client = Aws::SSM::Client.new(region: region)
    else
      client = Aws::SSM::Client.new(credentials: Aws::Credentials.new(aws_access_key_id, aws_secret_access_key), region: region)
    end

    begin
      result = client.get_parameters({ names: Array(names), with_decryption: with_decryption})
    rescue Aws::SSM::Errors::ServiceError => e
      Chef::Log.fatal('Error querying SSM API!')
      Chef::Log.debug("Exception is: #{e}")
      raise e
    end

    if result.parameters.length < 1
      nil
    else
      result.parameters
    end
  end

  def self.get_parameters_by_path(path, recursive=false, with_decryption=false, region, aws_access_key_id, aws_secret_access_key, next_token)
    if aws_access_key_id.nil? && aws_secret_access_key.nil?
      client = Aws::SSM::Client.new(region: region)
    else
      client = Aws::SSM::Client.new(credentials: Aws::Credentials.new(aws_access_key_id, aws_secret_access_key), region: region)
    end

    begin
      result = client.get_parameters_by_path({ path: path, recursive: recursive, with_decryption: with_decryption, next_token: next_token})
    rescue Aws::SSM::Errors::ParameterNotFound
      Chef::Log.debug("Parameter with name #{name} not found.")
      return nil
    rescue Aws::SSM::Errors::ServiceError => e
      Chef::Log.fatal('Error querying SSM API!')
      Chef::Log.debug("Exception is: #{e}")
      raise e
    end
    parameters = {}
    result.parameters.each { |p|  parameters[p.name] = p.value }

    unless result.next_token.nil?
      parameters.merge!(get_parameters_by_path(path, recursive, with_decryption, region, aws_access_key_id, aws_secret_access_key, result.next_token))
    end

    parameters
  end
end


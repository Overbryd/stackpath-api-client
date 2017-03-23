require 'oauth'
require 'json'

module StackpathApi
  class Client

    def initialize(consumer_key:, consumer_secret:, company_alias: nil, default_site_id: nil)
      @default_site_id = default_site_id
      @company_alias = company_alias
      @consumer = OAuth::Consumer.new(consumer_key, consumer_secret, site: 'https://api.stackpath.com')
    end

    def purge(files:, site_id: @default_site_id, company_alias: @company_alias)
      response = request(:delete, "/v1/#{company_alias}/sites/#{site_id}/cache",
        files: files
      )
      response.code == "200"
    end

    def request(method, path, data, headers = {})
      @consumer.request(method, path, nil, {}, data.to_json, headers)
    end

  end
end


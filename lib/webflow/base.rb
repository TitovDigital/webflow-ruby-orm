require 'json'
require 'net/http'

module Webflow
  class Base
    include ActiveSupport::Inflector

    attr_accessor :attributes
    attr_accessor :parent
    
    def initialize(a)
      @attributes = a
    end

    # Create a child object of the type `name`
    def create_assoc(name, data)
      klass = Webflow.const_get(name.to_s.singularize.camelize)
      klass.new(self.class.request("/#{id}/#{name.to_s.pluralize}", data))
    end

    def load_assoc(name)
      klass = Webflow.const_get(name.to_s.singularize.camelize)
      response = self.class.request("/#{self.id}/#{name}")
      puts response.inspect
      response[name.to_s].map do |attributes|
        obj = klass.new(attributes)
        obj.parent = self
        obj
      end
    end

    def method_missing(name, *args, &block)
      @attributes[camelize(name, false)]
    end

    def self.set_token(api_token)
      @@api_token = api_token
    end

    def self.all
      request[resource_name].map do |attributes|
        new(attributes)
      end
    end

    def self.find(id)
      new(request("/#{id}"))
    end

    protected
    def self.api_prefix
      '/v2'
    end

    def self.resource_name
      name.demodulize.underscore.pluralize
    end

    def self.request(resource_path = '', data = nil)
      full_path = "https://api.webflow.com#{self.api_prefix}/#{self.resource_name}#{resource_path}"
      puts "Fetching #{full_path}"
      uri = URI.parse(full_path)

      req = nil
      if data
        req = Net::HTTP::Post.new(uri)
        req['Content-Type'] = 'application/json'
        req.body = data.to_json
      else
        req = Net::HTTP::Get.new(uri)
      end
      req['Accept'] = 'application/json'

      auth_header = "Bearer #{@@api_token}"
      req['Authorization'] = auth_header
      
      # begin
        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) {|http|
          http.request(req)
        }

        if res.is_a?(Net::HTTPSuccess)
          JSON.parse(res.body)
        else
          # Handle non-success responses (like 403, 404, 500, etc.)
          raise Webflow::ClientError, "(#{res.code}): #{res.body}"
        end
      # rescue Net::HTTPExceptions => e
      #   raise e.response.body
      # end
    end
  end
end

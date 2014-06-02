# require 'faraday_middleware/response_middleware'

module FaradayMiddleware
  class ParseOj < ResponseMiddleware
    dependency 'oj'
    
    define_parser do |body|
      begin
        body.gsub!(/\0/, '')
        body.strip!
        Oj.load(body, mode: :compat) unless body.empty?
      rescue
        nil
      end
    end
    
    VERSION = '0.3.0'
  end
end

Faraday::Response.register_middleware oj: FaradayMiddleware::ParseOj

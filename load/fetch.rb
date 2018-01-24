require 'net/http'
require 'open-uri'
require 'uri'

def fetch(uri_str, limit = 10)
  # You should choose better exception.
  raise ArgumentError, 'HTTP redirect too deep' if limit == 0

  url = URI.parse(URI.encode(uri_str.to_s))
  path = url.path
  path = '/' if path == ''
  path += '?' + url.query unless url.query.nil?
  req = Net::HTTP::Get.new(path, { 'User-Agent' => 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0' })
  response = Net::HTTP.start(url.host, url.port, use_ssl: url.scheme == 'https') { |http| http.request(req) }
  case response
  when Net::HTTPSuccess     then response
  when Net::HTTPRedirection then fetch(response['location'], limit - 1)
  else
    response['location']
  end
  response['location']
end

#puts fetch('http://goo.gl/Wzh9i3')
require 'net/http'
require 'uri'

def fetch(uri_str, limit = 10)
  raise ArgumentError, 'HTTP redirect too deep' if limit == 0
  
  url = URI.parse(uri_str.to_s)
  path = url.path
  path = '/' if path == ''
  path += '?' + url.query unless url.query.nil?
  req = Net::HTTP::Get.new(path, { 'User-Agent' => 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0'})
  response = Net::HTTP.start(url.host, url.port, use_ssl: url.scheme == 'https') { |http| http.request(req) }
  case response
  when Net::HTTPSuccess     then response.code
  when Net::HTTPRedirection
    location = response.header['location']
    if location =~ URI::REGEXP
      fetch(location, limit - 1)
    elsif location =~ /cafe.icook.tw/
    else
      fetch(URI.join(uri_str, location).to_s, limit - 1)
    end
  else
    response.code
  end
end
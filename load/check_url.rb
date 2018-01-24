require 'net/http'
require 'open-uri'
require 'uri'

def check_url(url)
  begin
    url = URI.parse(url)
    req = Net::HTTP.new(url.host, url.port)
    req.use_ssl = true if url.scheme == 'https'
    @res = req.request_head(url.path)
    if @res.code == "301"
      response = open(url).read
      @res = Net::HTTP.get_response(URI.parse(@res.header['location']))
    end
    puts @res.code
  rescue => e
    puts "Exception: #{e}"
  end
end
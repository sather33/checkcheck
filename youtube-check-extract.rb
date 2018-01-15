require 'yt'
require 'uri'
require 'pp'
require 'net/http'

Yt.configure do |config|
  config.log_level = :debug
end

def check_url(url)
  begin
    url = URI.parse(url)
    req = Net::HTTP.new(url.host, url.port)
    req.use_ssl = true
    res = req.request_head(url.path)
    puts res.code
  rescue => e
    puts "Exception: #{e}"
  end
end

Yt.configuration.api_key = 'AIzaSyD4yxJVdNhsKJiPtXCPv6-2xqTRQ0cjyq4'
channel = Yt::Channel.new id: 'UCReIdTavsve16EJlilnTPNg'
videos=channel.videos
array_video=[]
videos.each do |video|
  urls = URI.extract(video.description, ['http', 'https'])
  array_video.concat(urls)
end

# array_video.each do |video|
#   print "#{video}  "
#   check_url(video)
# end
pp array_video
p array_video.count
p videos.count

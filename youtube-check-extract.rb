require 'yt'
require 'uri'
require 'pp'
require 'net/http'
require 'open-uri'

Yt.configure do |config|
  config.log_level = :debug
end

def check_url(url)
  begin
    url = URI.parse(url)
    req = Net::HTTP.new(url.host, url.port)
    req.use_ssl = true if url.scheme == 'https'
    res = req.request_head(url.path)
    if res.code == "301"
      response = open(url).read
      res = Net::HTTP.get_response(URI.parse(res.header['location']))
    end
    puts res.code
  rescue => e
    puts "Exception: #{e}"
  end
end

Yt.configuration.api_key = 'AIzaSyD4yxJVdNhsKJiPtXCPv6-2xqTRQ0cjyq4'
items = Yt::Playlist.new(id: 'UUReIdTavsve16EJlilnTPNg').playlist_items
array_video=[]
items.each do |item|
  urls = URI.extract(item.description, ['http', 'https'])
  urls.each do |url|
    @item_array=[]
    print "#{url}  "
    unless check_url(url)==200
      if @item_array.empty?
        @item_array << item.title
      end
      @item_array << url
    end
  end
  return if @item_array.empty?
  array_video.concat(@item_array)
end

# array_video.each do |video|
#   print "#{video}  "
#   check_url(video)
# end

pp array_video
p array_video.count
#p items.count

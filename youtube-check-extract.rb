require 'pp'
require 'csv'
load '/load/check_url.rb'
load '/load/API.rb'
load '/load/check-302.rb'

array_video=[]
@items.each do |item|
  @item_array=[]
  urls = URI.extract(item.description, ['http', 'https'])
  urls.each do |url|
    print "#{url}  "
    check_url(url)
    unless url == "http://goo.gl/f3ZGJ8"
    if @res.code == "302"
      url = UrlResolver.resolve(url)
      check_url(url)
    end
    unless @res.code == "200"
      if @item_array.empty?
        @item_array << item.title
        @item_array << "https://www.youtube.com/watch?v=#{item.video_id}"
      end
      @item_array << url
      @item_array << @res.code
    end
    end
  end
  unless @item_array.empty?
    array_video.concat(@item_array)
  end
end

CSV.open('/csv/check.csv', 'w') do |csv|
  csv << array_video
end
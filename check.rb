require 'csv'
load 'load/API.rb'
load 'load/fetch.rb'

File.open('csv/get-url.csv', 'w') {|file| file.truncate(0) }

@items.each do |item|
  item_array=[]
  urls = URI.extract(item.description, ['http', 'https'])
  urls.each do |url|
    puts "#{url}  "
    unless fetch(url) == "200"
      if item_array.empty?
        item_array << item.title
        item_array << "https://www.youtube.com/watch?v=#{item.video_id}"
      end
      item_array << url
      puts "bad"
    end
  end
  unless item_array.empty?
    item_array << " "
    CSV.open('csv/get-url.csv', 'a') do |csv|
      csv << item_array
    end
  end
end

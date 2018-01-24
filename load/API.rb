require 'yt'

Yt.configure do |config|
  config.log_level = :debug
end
Yt.configuration.api_key = 'AIzaSyD4yxJVdNhsKJiPtXCPv6-2xqTRQ0cjyq4'
@items = Yt::Playlist.new(id: 'UUReIdTavsve16EJlilnTPNg').playlist_items
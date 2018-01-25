require 'yt'

Yt.configure do |config|
  config.log_level = :debug
  # config.client_id = '453217783389-h4hb658fgoo4ci04vmp8lu42v75f63p9.apps.googleusercontent.com'
  # config.client_secret = '3GxCHOr30HMvNhdMnXJg9_y_'
  config.api_key = 'AIzaSyD4yxJVdNhsKJiPtXCPv6-2xqTRQ0cjyq4'
end

#account = Yt::Account.new(scopes: scopes, redirect_uri: redirect_uri).authentication_url
@items = Yt::Playlist.new(id: 'UUReIdTavsve16EJlilnTPNg').playlist_items
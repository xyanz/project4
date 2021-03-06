require 'igdb_api'
require 'httparty'
# require 'httplog'
class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @post = current_user.posts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
  def help
    puts "APIII KEYE #{Igdb.connect(Figaro.env.igdb_api_key)}"
    # Igdb.connect(Figaro.env.igdb_api_key)
    # @game = Igdb::Game.all(limit: 10)
  # headers = {"user-key" => Figaro.env.igdb_api_key,
  #   "Accept" => "application/json"
  # }
  # url = 'https://api-2445582011268.apicast.io'
  url = 'https://api-2445582011268.apicast.io/platforms/41'
  response = HTTParty.get(url, headers: {"user-key" => Figaro.env.igdb_api_key, "Accept": "application/json"})
  @pr = response.parsed_response
  puts "RESPONSE 111111 #{response}"
  puts "RESPONSE 111111 #{response.parsed_response}"
  end
  def about
  end
end

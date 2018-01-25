class Api::FollowersController < ApplicationController
  before_action :client

  def index
    followers = @client.followers.take(150).collect do |follower|
      { 
        id: follower.id, 
        name: follower.screen_name, 
        img: follower.profile_image_url.to_s
      }
    end

    render json: followers
  end

  private
    def client
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['CONSUMER_KEY']
        config.consumer_secret = ENV['CONSUMER_SECRET']
        config.access_token = ENV['ACCESS_TOKEN']
        config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
      end
    end
end

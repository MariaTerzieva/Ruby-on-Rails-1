class TwittersController < ApplicationController
  def index
    @tweets = TwitterClient.get_home
  end
end
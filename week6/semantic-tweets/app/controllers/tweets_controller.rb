class TweetsController < ApplicationController
  def index
    @tweets = TwitterClient.get_home
    @positive_tweets = SemantriaApi.analize(@tweets)
  end
end
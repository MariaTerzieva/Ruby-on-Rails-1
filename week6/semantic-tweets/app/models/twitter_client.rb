class TwitterClient

  def self.get_home
    access_token = self.prepare_access_token(Rails.configuration.twitter_token, Rails.configuration.twitter_token_secret)
    response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/user_timeline.json")
    JSON.parse(response.body)
  end

  private

  def self.prepare_access_token(oauth_token, oauth_token_secret)
    consumer = OAuth::Consumer.new(Rails.configuration.api_key, Rails.configuration.api_secret, { :site => "https://api.twitter.com", :scheme => :header })
     
    # now create the access token object from passed values
    token_hash = { :oauth_token => oauth_token, :oauth_token_secret => oauth_token_secret }
    access_token = OAuth::AccessToken.from_hash(consumer, token_hash )
 
    access_token
  end
end
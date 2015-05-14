class SemantriaApi
  def self.analize(tweets)
    session = self.new_session
    prepared_tweets = self.prepare_doc(session, tweets)
    result = self.filter(session, prepared_tweets.length)
  end

  private

  def self.new_session
    session = Semantria::Session.new(Rails.configuration.semantria_key, Rails.configuration.semantria_secret, 'TestApp', true)
  end

  def self.prepare_doc(session, tweets)
    queued_tweets = []
    tweets.each do |key|
      doc = {'id' => rand(10 ** 10).to_s.rjust(10, '0'), 'text' => key["text"]}
      status = session.queueDocument(doc)
      if status == 202
        queued_tweets << doc
      end
    end
    queued_tweets
  end

  def self.filter(session, length)
    results = []
    while results.length < length
      print "Please wait 2 seconds for documents...", "\r\n"
      sleep(2)
      status = session.getProcessedDocuments()
      results = results + status
    end
    positive_tweets = results.select {|result| result["sentiment_polarity"] == "positive"}
  end
end
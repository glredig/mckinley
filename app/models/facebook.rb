class Facebook < AuthProvider
  belongs_to :user

  def self.user_json(token)
    graph = Koala::Facebook::API.new(token)
    graph.get_object('me', {})
  end

  def exchange_access_token(old_access_token)
    update!(token: oauth.exchange_access_token(old_access_token), expiration: 60.days.from_now)
  end


  private

  def oauth
    @oauth ||= Koala::Facebook::OAuth.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'])
  end
end

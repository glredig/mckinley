class FacebookSignUp
  include Interactor

  def perform
    assert_correct_facebook_info unless failure?
    return if failure?

    user = build_user_from_facebook

    if user.save
      user.facebook.exchange_access_token(token)
      context[:user] = user
    else
      errors = user.errors.full_messages
      fail!(errors: errors)
    end
  end

  def setup
    fail!(errors: ['Missing Facebook access token']) unless context[:token].present?
  end

  def build_user_from_facebook
    user = User.new(auth_token: 'fake_token', email: facebook_info['email'],
                    first_name: facebook_info['first_name'], last_name: facebook_info['last_name'],
                    gender: facebook_info['gender'], locale: facebook_info['locale'],
                    birthday: facebook_info['birthday'])

    user.build_facebook(provider_user_id: facebook_info['id'], token: token,
                        expiration: 1.hour.from_now, link: facebook_info['link'],
                        verified: facebook_info['verified'])
    user
  end

  def assert_correct_facebook_info
    return unless facebook_info.present?

    fail!(errors: ['Facebook email is required.'])       unless facebook_info['email'].present?
    fail!(errors: ['Facebook birthday is required.'])    unless facebook_info['birthday'].present?
    fail!(errors: ['Facebook id is required.'])          unless facebook_info['id'].present?
    fail!(errors: ['Facebook first name is required.'])  unless facebook_info['first_name'].present?
    fail!(errors: ['Facebook last name is required.'])   unless facebook_info['last_name'].present?
    fail!(errors: ['Facebook gender is required.'])      unless facebook_info['gender'].present?
    fail!(errors: ['Facebook link is required.'])        unless facebook_info['link'].present?
    fail!(errors: ['Facebook locale is required.'])      unless facebook_info['locale'].present?
    fail!(errors: ['Facebook verified is required.'])    if facebook_info['verified'].nil?
  end

  # Facebook Information
  #
  # {
  #   id: "1521070431458816"
  #   birthday: "08/08/1980"
  #   email: "open_iqtpqqa_user@tfbnw.net"
  #   first_name: "Open"
  #   gender: "female"
  #   last_name: "User"
  #   link: "https://www.facebook.com/app_scoped_user_id/1521070431458816/"
  #   locale: "en_US"
  #   middle_name: "Graph Test"
  #   name: "Open Graph Test User"
  #   timezone: -7
  #   updated_time: "2014-08-04T06:25:05+0000"
  #   verified: false
  # }

  def facebook_info
    @facebook_info ||= Facebook.user_json(token)
  rescue Koala::Facebook::AuthenticationError
    Rails.logger.info "Invalid or Expired Facebook Access Token #{token}"
    fail!(errors: ["Invalid or Expired Facebook Access Token #{token}"])
    {}
  end
end

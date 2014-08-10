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
    user = User.new(auth_token: User.generate_authentication_token,
                    email:      facebook_info['email'],
                    first_name: facebook_info['first_name'],
                    last_name:  facebook_info['last_name'],
                    gender:     facebook_info['gender'],
                    locale:     facebook_info['locale'],
                    birthday:   facebook_info['birthday'])

    user.build_facebook(provider_user_id: facebook_info['id'],
                        token:            token,
                        expiration:       1.hour.from_now,
                        link:             facebook_info['link'],
                        verified:         facebook_info['verified'])
    user
  end

  def assert_correct_facebook_info
    return unless facebook_info.present?
    facebook_attributes = %w(email birthday id first_name last_name gender link locale)
    facebook_attributes.each do |attribute|
      if facebook_info[attribute].blank?
        fail!(errors: ["Facebook #{attribute.humanize.downcase} is required."])
        break
      end
    end
    fail!(errors: ['Facebook verified is required.']) if facebook_info['verified'].nil?
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

class CurrentUserSerializer < ActiveModel::Serializer
  attributes  :id, :auth_token, :first_name, :last_name,
              :gender, :locale, :profile_picture, :age

  def profile_picture
    "https://graph.facebook.com/#{object.facebook.provider_user_id}/picture"
  end

  def age
    now = Time.now.utc.to_date
    calculate_age(now, object.birthday)
  end

  private

  def calculate_age(now, birth_date)
    now.year - birth_date.year - ((now.month > birth_date.month || (now.month == birth_date.month && now.day >= birth_date.day)) ? 0 : 1)
  end
end

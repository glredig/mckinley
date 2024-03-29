# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :auth_provider do
    type ""
    user_id "fake-id"
    provider_user_id "MyString"
    token "MyString"
    expiration "2014-08-05 21:34:25"
    link "MyString"
    verified "false"
  end

  factory :facebook do
    type "Facebook"
    user_id "fake-id"
    provider_user_id "MyString"
    token "MyString"
    expiration "2014-08-05 21:34:25"
    link "MyString"
    verified "false"
  end
end

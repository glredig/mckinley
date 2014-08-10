# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    auth_token "MyString"
    email "MyString"
    first_name "MyString"
    last_name "MyString"
    gender "MyString"
    locale "MyString"
    birthday "2014-08-05"
  end
end

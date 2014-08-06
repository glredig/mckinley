require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.build(:user) }

  describe "validations" do
    it { should validate_presence_of :email }
    it { should validate_presence_of :auth_token }
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :gender }
    it { should validate_presence_of :locale }
    it { should validate_presence_of :birthday }
  end
end

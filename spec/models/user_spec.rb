require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.build(:user) }

  describe "associations" do
    it { should have_one(:facebook).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of :email }
    it { should validate_presence_of :auth_token }
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :gender }
    it { should validate_presence_of :locale }
    it { should validate_presence_of :birthday }
    # it { should validate_uniqueness_of :auth_token }
  end
end

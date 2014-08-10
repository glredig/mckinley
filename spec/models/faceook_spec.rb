require 'rails_helper'

RSpec.describe Facebook, type: :model do
  let(:auth_provider) { FactoryGirl.build(:auth_provider) }

  describe "associations" do
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should validate_presence_of :type }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :provider_user_id }
    it { should validate_presence_of :token }
    it { should validate_presence_of :expiration }
    it { should validate_presence_of :link }
    # it { should validate_inclusion_of(:verified).in_array([true, false]) }
  end
end

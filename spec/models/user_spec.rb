require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
    
    before(:all) do
        @user = User.create(email: "coder@skillcrush", password: "password")
    end
 
    after(:all) do
      if !@user.destroyed?
        @user.destroy
      end
    end

    it 'authenticates and returns a user when valid email and password passed in' do

    end
    
    it { should validate_presence_of(:first_name) }

end

FactoryGirl.define do
  factory :user do 
    sequence(:email) { |n| "coder#{n}@skillcrush.com" }
    first_name "Skillcrush"
    last_name "Coder"
    password "secret"
  end
end 


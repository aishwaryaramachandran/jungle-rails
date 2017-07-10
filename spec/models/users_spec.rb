require 'rails_helper'

RSpec.describe "Users", type: :model do
  describe 'Validations' do
    before(:each) do
      @user = User.new(name:'userName', email:'userEmail@email', password:'some_password', password_confirmation: 'some_password')
    end

    it 'is valid with valid parameters' do
      expect(@user).to be_valid
    end

    it 'is not valid without presence of a password equal to the password confirmation' do
      @user.password = "lkjhlkjhlkh"
      expect(@user).to_not be_valid
    end

    it 'is not valid without a password less than 6 chars' do
      @user.password = "short"
      expect(@user).to_not be_valid
    end

    it 'is not valid without presence of a name' do
      @user.name = nil
      expect(@user).to_not be_valid
    end

    it 'is not valid without presence of an email' do
      @user.email = nil
      expect(@user).to_not be_valid
    end

    it 'is not valid without presence of a unique email' do
      old_user = User.create! name: 'oldUser', email: 'me@old.com', password: 'password', password_confirmation: 'password'
      expect(@user).to be_valid
      @user.email = 'ME@OLD.com'
      expect(@user).to_not be_valid
    end
  end
  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.new(name:'userName', email:'userEmail@email', password:'some_password', password_confirmation: 'some_password')
    end
    it 'is not valid without valid credentials' do
    @user.save
      expect(User.authenticate_with_credentials('userEmail@email', 'some_password')).to_not eql(nil)
    end

    it 'should not care about case when searching  email' do
      @user.save
      expect(User.ignore_case('useREmail@emAiL')).to_not eql(nil)
    end

  end
end

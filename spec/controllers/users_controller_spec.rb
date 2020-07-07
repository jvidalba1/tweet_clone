require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before(:each) do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user, username: "test2", email: "test2@sample.com")
    @user3 = FactoryBot.create(:user, username: "test3", email: "test3@sample.com")
    @user4 = FactoryBot.create(:user, username: "test4", email: "test4@sample.com")

    sign_in @user
  end

  describe 'GET show' do
    it "returns all my tweets" do
      FactoryBot.create_list(:tweet, 5, user: @user)
      get :show, params: { username: 'test' }
      expect(assigns(:tweets).count).to eq 5
    end
  end

  describe 'GET finder' do
    it "create user instance" do
      get :finder, params: { username: "test" }

      expect(response).to be_successful
      expect(assigns(:user)).to eq @user
    end
  end

  describe 'POST follow_finder' do
    context 'valid finder user' do
      it "redirect to finder user path with notice message" do
        allow_any_instance_of(Finder).to receive(:call).and_return(OpenStruct.new(success?: true, user: @user2, error: nil))
        post :follow_finder, params: { finder: { username: "test2"}, username: 'test' }

        expect(response).to redirect_to(user_path(@user2.username))
        expect(flash[:notice]).to eq "You're following #{@user2.username} now."
      end
    end

    context 'finder user does not exist' do
      it "renders to finder and show error message" do
        allow_any_instance_of(Finder).to receive(:call).and_return(OpenStruct.new(success?: false, user: nil, error: 'User not found.'))
        post :follow_finder, params: { finder: { username: "testnoexist"}, username: 'test' }

        expect(response).to render_template(:finder)
        expect(flash[:alert]).to eq "User not found."
      end
    end

    context 'already following user' do
      it "renders to finder and show error message" do
        allow_any_instance_of(Finder).to receive(:call).and_return(OpenStruct.new(success?: false, user: @user2, error: "You're already following this user."))
        post :follow_finder, params: { finder: { username: "test2"}, username: 'test' }

        expect(response).to render_template(:finder)
        expect(flash[:alert]).to eq "You're already following this user."
      end
    end
  end

  describe 'POST follow' do
    it 'follows the user sent' do
      expect(@user.following?(@user2)).to eq false

      post :follow, params: { username: 'test2'}

      expect(@user.following?(@user2)).to eq true
    end
  end

  describe 'POST unfollow' do
    it 'unfollows the user sent' do
      @user.follow(@user2)
      expect(@user.following?(@user2)).to eq true

      post :unfollow, params: { username: 'test2'}

      expect(@user.following?(@user2)).to eq false
    end
  end

  describe 'GET following' do
    it 'returns the following users list' do

      @user.follow(@user2)
      @user.follow(@user3)

      get :following, params: { username: 'test' }
      expect(assigns(:following).count).to eq 2
      expect(assigns(:following)).to eq [@user3, @user2]
    end
  end

  describe 'GET followers' do
    it 'returns the followers users list' do
      @user2.follow(@user)
      @user3.follow(@user)
      @user4.follow(@user)

      get :followers, params: { username: 'test' }
      expect(assigns(:followers).count).to eq 3
    end
  end
end

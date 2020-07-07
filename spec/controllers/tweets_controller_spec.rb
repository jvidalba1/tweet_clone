require 'rails_helper'

RSpec.describe TweetsController, type: :controller do
  describe "GET new" do

    context "without authentication" do
      it "returns an unsuccessful response" do
        get :new, params: { user_username: "oelo" }

        expect(response).to_not be_successful
      end
    end

    context "with authentication" do

      before(:each) do
        user = FactoryBot.create(:user)
        sign_in user
      end

      context "with invalid username" do
        it "returns an unsuccessful response" do
          get :new, params: { user_username: "test22" }
          expect(response).to_not be_successful
        end
      end

      context "with valid username" do
        it 'returns a successful response' do
          get :new, params: { user_username: "test" }

          expect(response).to be_successful
        end
      end
    end
  end

  describe "POST create" do

    before(:each) do
      user = FactoryBot.create(:user)
      sign_in user
    end

    context "with valid body" do
      subject { post :create, params: { tweet: { body: "Creating a new tweet from tests."}, user_username: 'test' } }

      it "redirects to users tweets and creates tweet" do
        expect(subject).to redirect_to(user_tweets_url)
        expect(flash["notice"]).to eq "Tweet created successfully."
      end
    end

    context "with invalid body" do
      subject { post :create, params: { tweet: { body: "a"*281}, user_username: 'test' } }

      it "redirects to users tweets and creates tweet" do
        expect(subject).to render_template("new")
        expect(flash["alert"]).to eq "Error posting tweet."
        expect(assigns(:tweet).errors.messages[:body].first).to eq "is too long (maximum is 280 characters)"
      end
    end
  end

  describe "GET index" do
    before(:each) do
      @user = FactoryBot.create(:user)
      sign_in @user
    end

    context "only my tweets" do
      it 'returns all my tweets' do
        FactoryBot.create_list(:tweet, 5, user: @user)

        get :index, params: { user_username: 'test' }
        expect(assigns(:tweets).count).to eq 5
      end
    end

    context "with more tweets from other users" do

      it 'returns all my tweets + tweets from users that Im following' do
        FactoryBot.create_list(:tweet, 5, user: @user)

        user2 = FactoryBot.create(:user, username: "test2", email: "test2@sample.com")
        user3 = FactoryBot.create(:user, username: "test3", email: "test3@sample.com")

        FactoryBot.create_list(:tweet, 2, user: user2)
        FactoryBot.create_list(:tweet, 1, user: user3)

        @user.follow(user2)

        get :index, params: { user_username: 'test' }
        expect(assigns(:tweets).count).to eq 7
      end
    end
  end
end

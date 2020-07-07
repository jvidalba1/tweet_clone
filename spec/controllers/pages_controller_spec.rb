require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe "GET home" do
    it 'returns a successful response' do
      get :home
      expect(response).to be_successful
    end

    # it "assigns @users" do
    #   user = User.create(name: “Test user”)
    #   get :index
    #   expect(assigns(:users)).to eq([user])
    # end

    # it "renders the index template" do
    #   get :index
    #   expect(response).to render_template("index")
    # end
  end
end

require 'spec_helper'

describe SessionsController do

  describe "#create" do
    before(:each) do
      Rails.application.routes.draw do
        resource :sessions, :only => [:create, :destroy]
        root to: 'site#index'
      end
    end

    after(:each) do
      Rails.application.reload_routes!
    end

    it "logs in a new user" do
      @request.env["omniauth.auth"] = {
        'provider' => 'github',
        'info' => {'name' => 'Alice Smith'},
        'uid' => 'abc123'
      }

      post :create
      user = User.find_by_uid_and_provider('abc123', 'github')
      expect(controller.current_user.id).to eq(user.id)
    end

    it "logs in an existing user" do
      @request.env["omniauth.auth"] = {
        'provider' => 'github',
        'info' => {'name' => 'Bob Jones'},
        'uid' => 'xyz456'
      }
      user = User.create(provider: 'github', uid: 'xyz456', name: 'Bob Jones')

      post :create
      expect(controller.current_user.id).to eq(user.id)
    end  

    it 'redirects to the root page' do
      @request.env["omniauth.auth"] = {
        'provider' => 'twitter',
        'info' => {'name' => 'Charlie Allen'},
        'uid' => 'prq987'
      }
      user = User.create(provider: 'twitter', uid: 'prq987', name: 'Charlie Allen')
      post :create
      expect(response).to redirect_to(root_path)
    end

    it "log out" do
      @request.env["omniauth.auth"] = {
        'provider' => 'github',
        'info' => {'name' => 'Bob Jones'},
        'uid' => 'xyz456'
      }
      user = User.create(provider: 'github', uid: 'xyz456', name: 'Bob Jones')

      post :create
      delete :destroy
      expect(session[:user_id]).to eq(nil)     
    end 

    it "redirects to the root page" do
            @request.env["omniauth.auth"] = {
        'provider' => 'github',
        'info' => {'name' => 'Bob Jones'},
        'uid' => 'xyz456'
      }
      user = User.create(provider: 'github', uid: 'xyz456', name: 'Bob Jones')

      post :create
      delete :destroy
      expect(response).to redirect_to(root_path)
    end
  end

end
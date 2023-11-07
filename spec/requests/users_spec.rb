require "rails_helper"

RSpec.describe Devise::RegistrationsController, type: :request do
  let!(:user) { create(:user) }
  let(:valid_params) { attributes_for(:user) }
  let(:invalid_params) { attributes_for(:user, :empty_first_name) }

  describe "GET users/sign_up" do
    it "is successful registration" do
      get new_user_registration_path

      expect(response).to be_successful
    end
  end

  describe "POST users/sign_in" do
    it "is successful login" do
      post user_session_path, params: { user: { email: user.email, password: user.password } }

      expect(response).to be_redirect
      expect(flash[:notice]).to eq("Signed in successfully.")
    end
  end

  describe "POST /users" do
    it "create a new user with valid parameters" do
      expect do
        post user_registration_path, params: { user: valid_params }
      end.to change(User, :count).by(1)

      expect(response).to be_redirect
      expect(flash[:notice]).to eq("Welcome! You have signed up successfully.")
    end

    it "create a new user with invalid attributes)" do
      expect do
        post user_registration_path, params: { book: invalid_params }
      end.to_not change(User, :count)

      expect(response).to be_unprocessable
    end
  end

  describe "DELETE users/sign_out" do
    it "user log out" do
      sign_in user

      delete destroy_user_session_path

      expect(response).to be_redirect
      expect(flash[:notice]).to eq("Signed out successfully.")
    end
  end
end

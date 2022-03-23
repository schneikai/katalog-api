require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  # authenticate_user! Tests
  class AuthenticateUserTest < ApplicationControllerTest
    setup do
      class ::TestingController < ApplicationController
        before_action :authenticate_user!

        def index
          head :ok
        end
      end

      # If disable_clear_and_finalize is set to true, Rails will not clear other routes when calling again the draw method. Look at the source code at: http://apidock.com/rails/v4.0.2/ActionDispatch/Routing/RouteSet/draw
      Rails.application.routes.disable_clear_and_finalize = true

      Rails.application.routes.draw do
        get '/index', to: 'testing#index'
      end
    end

    teardown do
      Object.send(:remove_const, :TestingController)
      Rails.application.routes.disable_clear_and_finalize = false
      Rails.application.reload_routes!
    end

    test 'it should redirect user to login if not authenticated' do
      get '/index'
      assert_redirected_to 'http://www.example.com/users/sign_in'
    end

    test 'it should not redirect user to login if authenticated' do
      user = create(:user)
      sign_in user
      get '/index'
      assert_response :success
    end
  end

  # authenticate_admin_user! Test
  class AuthenticateAdminUserTest < ApplicationControllerTest
    setup do
      class ::TestingController < ApplicationController
        before_action :authenticate_admin_user!

        def index
          head :ok
        end
      end

      # If disable_clear_and_finalize is set to true, Rails will not clear other routes when calling again the draw method. Look at the source code at: http://apidock.com/rails/v4.0.2/ActionDispatch/Routing/RouteSet/draw
      Rails.application.routes.disable_clear_and_finalize = true

      Rails.application.routes.draw do
        get '/index', to: 'testing#index'
      end
    end

    teardown do
      Object.send(:remove_const, :TestingController)
      Rails.application.routes.disable_clear_and_finalize = false
      Rails.application.reload_routes!
    end

    test 'it should redirect user to login if not authenticated' do
      get '/index'
      assert_redirected_to 'http://www.example.com/users/sign_in'
    end

    test 'it should respond with forbidden if user is not admin' do
      user = create(:user)
      sign_in user
      get '/index'
      assert_response :forbidden
    end

    test 'it should respond with success if user is admin' do
      user = create(:user, is_admin: true)
      sign_in user
      get '/index'
      assert_response :success
    end
  end
end

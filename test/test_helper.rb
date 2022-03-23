ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  include JsonCompareWithoutTimestamps::TestHelper

  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # Using Factory Bot instead of Fixtures
  # fixtures :all

  # Add more helper methods to be used by all tests here...

  class ActionDispatch::IntegrationTest
    require 'devise/jwt/test_helpers'
    include Devise::Test::IntegrationHelpers

    # Returns authentication headers to access protected routes in integration tests
    # https://github.com/waiting-for-dev/devise-jwt#testing
    #   get '/api/v1/assets', headers: auth_headers(user)
    #   assert_response :success
    def auth_headers(user)
      Devise::JWT::TestHelpers.auth_headers({}, user)
    end
  end
end

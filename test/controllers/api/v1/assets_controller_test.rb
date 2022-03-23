require 'test_helper'

class AssetsControllerTest < ActionDispatch::IntegrationTest
  test 'it requires authenticated user for index' do
    get '/api/v1/assets'
    assert_response :unauthorized
  end

  test 'it gets index' do
    user = create(:user)
    create :asset, title: 'Foo', user: user
    create :asset, title: 'Bar', user: user
    create :asset, title: 'Bar'

    get '/api/v1/assets', headers: auth_headers(user)
    assert_response :success
    assert_equal_json '[{"id":1,"title":"Foo","created_at":"2022-03-22T16:22:06.623Z","updated_at":"2022-03-22T16:22:06.623Z"},{"id":2,"title":"Bar","created_at":"2022-03-22T16:22:06.624Z","updated_at":"2022-03-22T16:22:06.624Z"}]',
                      response.body
  end
end

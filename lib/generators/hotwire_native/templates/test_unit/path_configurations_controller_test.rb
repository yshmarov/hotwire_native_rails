require "test_helper"

class PathConfigurationsControllerTest < ActionDispatch::IntegrationTest
  test 'android' do
    get '/hotwire_native/v1/android/path_configuration'
    assert_response :success
  end

  test 'ios' do
    get '/hotwire_native/v1/ios/path_configuration'
    assert_response :success
  end
end

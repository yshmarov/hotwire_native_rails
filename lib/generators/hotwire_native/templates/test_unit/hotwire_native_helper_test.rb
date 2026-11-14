require 'test_helper'

class HotwireNativeHelperTest < ActionView::TestCase
  setup do
    def root_url
      'http://test.host/'
    end
  end

  test 'link_to removes target for internal links in hotwire native app' do
    def hotwire_native_app?
      true
    end

    result = link_to('Home', '/foo/bar', target: '_blank', rel: 'noopener')
    assert_no_match(/target="_blank"/, result)
  end

  test 'link_to keeps target for external links in hotwire native app' do
    def hotwire_native_app?
      true
    end

    result = link_to('External', 'http://external.com', target: '_blank', rel: 'noopener')
    assert_match(/target="_blank"/, result)
  end

  test 'link_to keeps target for internal links when not in hotwire native app' do
    def hotwire_native_app?
      false
    end

    result = link_to('Home', root_url, target: '_blank', rel: 'noopener')
    assert_match(/target="_blank"/, result)
  end

  test 'link_to keeps target for external links when not in hotwire native app' do
    def hotwire_native_app?
      false
    end

    result = link_to('External', 'http://external.com', target: '_blank', rel: 'noopener')
    assert_match(/target="_blank"/, result)
  end

  test 'link_to with a block removes target for internal links in hotwire native app' do
    def hotwire_native_app?
      true
    end

    result = link_to('/foo/bar', target: '_blank') { 'Home' }
    assert_no_match(/target=/, result)
    assert_match(%r{href="/foo/bar"}, result)
  end

  test 'link_to with a block keeps target for external links in hotwire native app' do
    def hotwire_native_app?
      true
    end

    result = link_to('http://external.com', target: '_blank') { 'External' }
    assert_match(/target="_blank"/, result)
  end

  test 'link_to does not modify the html options passed in' do
    def hotwire_native_app?
      true
    end

    html_options = { target: '_blank' }
    link_to('Home', '/foo/bar', html_options)
    assert_equal({ target: '_blank' }, html_options)
  end

  test 'internal_url? returns true for internal links' do
    assert internal_url?('http://test.host/some_path')
    assert internal_url?('/some_path')
  end

  test 'internal_url? returns false for external links' do
    assert_not internal_url?('http://external.com')
    assert_not internal_url?('mailto:hello@test.host')
  end
end
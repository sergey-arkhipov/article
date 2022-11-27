require 'test_helper'

class TextsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = articles(:one)
    @text = @article.texts.create(text: 'BlaBla')
  end
  test 'should get edit' do
    get edit_text_url(@text)
    assert_response :success
  end
end

require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = articles(:one)
    @article.texts.create(text: 'BlaBla')
  end

  test 'should get index' do
    get articles_url
    assert_response :success
  end

  test 'should get new' do
    get new_article_url
    assert_response :success
  end

  test 'should create article' do
    assert_difference('Article.count') do
      post articles_url, params: { article: { author: 'Test', title: 'Test' } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test 'should show article' do
    get article_url(@article)
    assert_response :success
  end

  test 'should get edit' do
    get edit_article_url(@article)
    assert_response :success
  end

  test 'No routes match when update article' do
    assert_not(patch(article_url(@article), params: { article: {} }))
  rescue ActionController::RoutingError => e
    assert e.message.start_with? 'No route matches [PATCH]'
  end

  test 'should destroy article' do
    assert_difference('Article.count', -1) do
      delete article_url(@article)
      # assert_raises(Elasticsearch::Transport::Transport::Errors::NotFound) { delete article_url(@article) }
    end
  end
end

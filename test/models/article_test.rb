# frozen_string_literal: true

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  ARTICLE_TITLE_MIN_LENGTH = 2
  ARTICLE_TITLE_MAX_LENGTH = 50
  ARTICLE_DESCRIPTION_MIN_LENGTH = 10
  ARTICLE_DESCRIPTION_MAX_LENGTH = 300

  def setup
    @user = User.create(username: 'john', email: 'john@example.com', password: 'password', admin: false)
    @article = Article.new(
      title: 'This is a test article',
      description: 'This is the description for a test article',
      user: @user
    )
  end

  test 'article title should be present' do
    @article.title = nil
    assert_not @article.valid?
  end

  test 'article description should be present' do
    @article.description = nil
    assert_not @article.valid?
  end

  test 'article user should not be blank' do
    @article.user = nil
    assert_not @article.valid?
  end

  test 'article title should not exceed 50 characters' do
    @article.title = '0' * (ARTICLE_TITLE_MAX_LENGTH + 1)
    assert_not @article.valid?
  end

  test 'article title should not be less than 3 characters' do
    @article.title = 'a' * (ARTICLE_TITLE_MIN_LENGTH - 1)
    assert_not @article.valid?
  end

  test 'article description should not be less than 10 characters' do
    @article.description = '0' * (ARTICLE_DESCRIPTION_MIN_LENGTH - 1)
    assert_not @article.valid?
  end

  test 'article description should not exceed 300 characters' do
    @article.description = '0' * (ARTICLE_DESCRIPTION_MAX_LENGTH + 1)
    assert_not @article.valid?
  end
end

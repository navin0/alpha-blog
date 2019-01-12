# frozen_string_literal: true

require "test_helper"

class CreateArticlesTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: false)
  end

  test "get new article form and create article" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template "articles/new"
    assert_difference "Article.count", 1 do
      post articles_path, params: {
                       article: {
                         title: "This article was created using automated test",
                         description: "This is the description for the article created automatically by the test",
                         user: @user,
                       },
                     }
      follow_redirect!
    end
  end

  test "invalid article submission results in error" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template "articles/new"
    assert_no_difference "Article.count" do
      post articles_path, params: {
                       article: {
                         title: "",
                         description: "",
                         user: @user,
                       },
                     }
    end
    assert_template "articles/new"
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end
end

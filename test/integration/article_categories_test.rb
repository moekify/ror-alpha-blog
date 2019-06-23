require 'test_helper'

class ArticleCategoriesTest < ActionDispatch::IntegrationTest

def setup
  @user = User.create(username: "John", email: "john@example.com", password: "password", admin: true)
  @category = Category.create(name: "sports")
end

test "creating an article with a category will add it to that categories listing page" do
  sign_in_as(@user, "password")
  get new_article_path
  assert_template 'articles/new'
  assert_difference 'Article.count', 1 do
    post articles_path, params: {article: {title: "Gude Laune", description: "This is an amazing test article", user: @user, categories: "#{@category.name}"}}
  end
  get category_path(@category)
  assert_template 'categories/show'
  assert_match "Gude Laune", response.body
end 

end

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "#GET /users/:user_id/posts" do
    before(:each) do
      @user = User.create(name: 'User 1')
      @post = Post.create(title: 'Post 1', text: 'Post 1 text', author_id: @user.id)
      @post2 = Post.create(title: 'Post 2', text: 'Post 2 text', author_id: @user.id)
      @post3 = Post.create(title: 'Post 3', text: 'Post 3 text', author_id: @user.id)
      get 'index', params: {user_id: @post.author_id}
    end

    it 'returns 200 code' do
      expect(response).to have_http_status(200)
    end

    it 'render correct page' do
      expect(response).to render_template(:index)
    end

    it 'return correct text' do
      expect(response.body).to include('This is posts page')
    end

    it 'has three posts' do
      html = Nokogiri::HTML(response.body)
      expect(html.css('.post').count).to eq(3)
    end
  end

  describe "/users/:user_id/posts/:id" do
    before(:each) do
      @user = User.create(name: 'User 1')
      @post = Post.create(title: 'Post 1', text: 'Post 1 text', author_id: @user.id)
      @post2 = Post.create(title: 'Post 2', text: 'Post 2 text', author_id: @user.id)
      @post3 = Post.create(title: 'Post 3', text: 'Post 3 text', author_id: @user.id)
      get :show, params: { user_id: @user.id, id: @post.id}
    end

    it 'returns 200 code' do
      expect(response).to have_http_status(200)
    end

    it 'render correct page' do
      expect(response).to render_template(:show)
    end

    it 'return correct text' do
      expect(response.body).to include('This is post page')
    end

    it 'has one post' do
      expect(response.body).to include(@post.title)
    end
  end
end

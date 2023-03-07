require 'rails_helper'

describe '# / or /users/:user_id/posts', type: :feature do
  before :each do
    @user = User.create(name: 'User 1', bio: 'This is user page', photo: 'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png')
    @post = Post.create(title: 'Post 1', text: 'This is post 1', author_id: @user.id)
    @post2 = Post.create(title: 'Post 2', text: 'This is post 2', author_id: @user.id)
    @post3 = Post.create(title: 'Post 3', text: 'This is post 3', author_id: @user.id)
    @post4 = Post.create(title: 'Post 4', text: 'This is post 4', author_id: @user.id)
    @comment = Comment.create(text: 'This is comment 1', author_id: @user.id, post_id: @post2.id)
    @comment2 = Comment.create(text: 'This is comment 2', author_id: @user.id, post_id: @post2.id)
    @comment3 = Comment.create(text: 'This is comment 3', author_id: @user.id, post_id: @post.id)
    @comment4 = Comment.create(text: 'This is comment 4', author_id: @user.id, post_id: @post3.id)
    @comment5 = Comment.create(text: 'This is comment 5', author_id: @user.id, post_id: @post4.id)

    @like = Like.create(author_id: @user.id, post_id: @post2.id)
    @like = Like.create(author_id: @user.id, post_id: @post2.id)
    @like = Like.create(author_id: @user.id, post_id: @post2.id)
    @like = Like.create(author_id: @user.id, post_id: @post2.id)
    @like = Like.create(author_id: @user.id, post_id: @post2.id)
    @like = Like.create(author_id: @user.id, post_id: @post2.id)

    @like = Like.create(author_id: @user.id, post_id: @post.id)
    @like = Like.create(author_id: @user.id, post_id: @post.id)
    @like = Like.create(author_id: @user.id, post_id: @post.id)
    @like = Like.create(author_id: @user.id, post_id: @post.id)

    @like = Like.create(author_id: @user.id, post_id: @post3.id)
    @like = Like.create(author_id: @user.id, post_id: @post3.id)

    visit user_posts_path(@user)
  end

  it 'can see the user profile picture, username,the number of posts the user has written, posts title, posts body' do
    expect(page).to have_css(
      'img[src*="https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png"]'
    )
    expect(page).to have_content('User 1')
    expect(page).to have_content('Total Posts: 4')
    expect(page).to have_content('Post 2')
    expect(page).to have_content('This is post 2')
  end

  it 'I can see the first comments on a post, how many comments a post has., how many likes a post has' do
    comments = ['This is comment 1', 'This is comment 2', 'This is comment 3', 'This is comment 4', 'This is comment 5']
    comments.each do |comment|
      expect(page).to have_content(comment)
    end

    counts = ['Comments: 2', 'Comments: 1', 'Comments: 1', 'Comments: 1']
    counts.each do |count|
      expect(page).to have_content(count)
    end

    expect(page).to have_content('Likes: 6').and have_content('Likes: 4').and have_content('Likes: 2')
  end

  it 'When I click a user post, it redirects me to that post show page.' do
    post_link = find('a', text: 'Post 2')
    post_link.click
    expect(page).to have_current_path(user_post_path(@user, @post2))
  end
end

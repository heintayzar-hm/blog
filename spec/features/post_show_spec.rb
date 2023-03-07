require 'rails_helper'

describe '# / or /users/:user_id/posts/:post_id', type: :feature do
  before :each do
    @user = User.create(name: 'User 1', bio: 'This is user page', photo: 'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png')
    @user2 = User.create(name: 'User 2', bio: 'This is user page', photo: 'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png')
    @user3 = User.create(name: 'User 3', bio: 'This is user page', photo: 'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png')

    @post = Post.create(title: 'Post 1', text: 'This is post 1', author_id: @user.id)
    @post2 = Post.create(title: 'Post 2', text: 'This is post 2', author_id: @user.id)
    @comment = Comment.create(text: 'This is comment 1', author_id: @user2.id, post_id: @post2.id)
    @comment2 = Comment.create(text: 'This is comment 2', author_id: @user3.id, post_id: @post2.id)

    @like = Like.create(author_id: @user.id, post_id: @post2.id)
    @like = Like.create(author_id: @user2.id, post_id: @post2.id)
    @like = Like.create(author_id: @user3.id, post_id: @post2.id)
    @like = Like.create(author_id: @user3.id, post_id: @post2.id)
    @like = Like.create(author_id: @user2.id, post_id: @post2.id)
    @like = Like.create(author_id: @user3.id, post_id: @post2.id)
    visit user_post_path(@user, @post2)
  end
  it 'I  can see can see posts title, posts body,  who wrote the post' do
    expect(page).to have_content('Post 2')
    expect(page).to have_content('This is post 2')
    expect(page).to have_content('User 1')
  end
  it 'I can see  how many comments it has., how many likes it has' do
    expect(page).to have_content('Comments: 2')
    expect(page).to have_content('Likes: 6')
  end
  it 'I can see username of each commenter, can see their comment' do
    expect(page).to have_content('User 2').and have_content('User 3').and have_content('User 1')
    expect(page).to have_content('This is comment 1').and have_content('This is comment 2')
  end
end

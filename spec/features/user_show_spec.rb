require 'rails_helper'

describe '# / or /users/:user_id', type: :feature do
  before :each do
    @user = User.create(name: 'User 1', bio: 'This is user page', photo: 'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png')
    @post = Post.create(title: 'Post 1', text: 'This is post 1', author_id: @user.id)
    @post2 = Post.create(title: 'Post 2', text: 'This is post 2', author_id: @user.id)
    @post3 = Post.create(title: 'Post 3', text: 'This is post 3', author_id: @user.id)
    @post4 = Post.create(title: 'Post 4', text: 'This is post 4', author_id: @user.id)
    visit user_path(@user)
  end

  it 'I can see the user profile picture., usernamen number of posts, bio, first 3 posts.' do
    expect(page).to have_css(
      'img[src*="https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png"]', count: 1
    )
    expect(page).to have_content('User 1')
    expect(page).to have_content('Total Posts: 4')
    expect(page).to have_content('This is user page')
    expect(page).to have_content('Post 2').and have_content('Post 3').and have_content('Post 4') # post is updated so the order will be in reverse.
  end

  it 'I can see a button that lets me view all of a user posts.' do
    expect(page).to have_link('See All Posts')
  end

  it 'When I click a user post, it redirects me to that post show page.' do
    post_link = find('a', text: 'Post 2')
    post_link.click
    expect(page).to have_current_path(user_post_path(@user, @post2))
  end

  it 'when I click to see all posts, it redirects me to the user posts index page.' do
    posts_link = find('a', text: 'See All Posts')
    posts_link.click
    expect(page).to have_current_path(user_posts_path(@user))
  end
end

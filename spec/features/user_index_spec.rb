require 'rails_helper'

describe '# / or /users', type: :feature do
  before :each do
    @user = User.create(name: 'User 1', bio: 'This is user page', posts_counter: 10, photo: 'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png')
    @user1 = User.create(name: 'User 2', bio: 'This is user page', posts_counter: 3, photo: 'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png')
    @user2 = User.create(name: 'User 3', bio: 'This is user page', posts_counter: 0, photo: 'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png')

    visit '/'
  end
  it 'I can see, user names,  the profile picture for each user.' do
    expect(page).to have_content('User 1').and have_content('User 2').and have_content('User 3')

    expect(page).to have_css(
      'img[src*="https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png"]', count: 3
    )
  end

  it 'I can see the number of posts each user has written.' do
    totals = ['Total Posts: 10', 'Total Posts: 3', 'Total Posts: 0']
    totals.each do |total|
      expect(page).to have_content(total)
    end
  end

  it "When I click on a user, I am redirected to that user's show page." do
    user_link = find('a', text: 'User 1')
    user_link.click
    expect(page).to have_current_path(user_path(@user))
  end
end

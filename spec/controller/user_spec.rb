require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#GET /' do
    before(:each) do
      @user = User.create(name: 'User 1', bio: 'This is user page', photo: 'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png')
      @user1 = User.create(name: 'User 2', bio: 'This is user page', photo: 'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png')
      @user2 = User.create(name: 'User 3', bio: 'This is user page', photo: 'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png')

      get 'index'
    end
    it 'returns 200 code' do
      expect(response).to have_http_status(200)
    end
    it 'returns correct page' do
      expect(response).to render_template(:index)
    end

    it 'contains a user' do
      expect(response.body).to include(@user.name)
    end

    it 'contains three users' do
      html = Nokogiri::HTML(response.body)
      expect(html.css('.user-test').count).to eq(3)
    end
  end

  describe '#GET /users/:id' do
    before(:each) do
      @user = User.create(name: 'User 1')
      @user2 = User.create(name: 'User 2')
      get 'show', params: { id: @user.id }
    end

    it 'returns 200 code' do
      expect(response).to have_http_status(200)
    end

    it 'returns correct page' do
      expect(response).to render_template(:show)
    end

    it 'returns correct user' do
      expect(response.body).to include(@user.name)
    end

    it 'has one user' do
      expect(response.body.scan(/User/).count).to eq(1)
    end
  end
end

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#GET /' do
    before(:each) do
      @user = User.create(name: 'User 1')
      @user1 = User.create(name: 'User 2')
      @user2 = User.create(name: 'User 3')

      get 'index'
    end
    it 'returns 200 code' do
      expect(response).to have_http_status(200)
    end
    it 'returns correct page' do
      expect(response).to render_template(:index)
    end

    ### delete in update
    it 'contains the correct text' do
      expect(response.body).to include('This is user page')
    end

    it 'contains a user' do
      expect(response.body).to include(@user.name)
    end

    it 'contains three users' do
      html = Nokogiri::HTML(response.body)
      expect(html.css('.user').count).to eq(3)
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
    ### delete on update

    it 'returns correct text' do
      expect(response.body).to include('USER: ')
    end

    it 'returns correct user' do
      expect(response.body).to include(@user.name)
    end

    it 'has one user' do
      expect(response.body.scan(/User/).count).to eq(1)
    end
  end
end

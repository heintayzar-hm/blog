require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'John', photo: 'https://www.google.com', bio: 'I am a user') }
  before { subject.save }

  it 'has name' do
    expect(subject.name).to eq('John')
  end

  it 'has photo' do
    expect(subject.photo).to eq('https://www.google.com')
  end

  it 'has bio' do
    expect(subject.bio).to eq('I am a user')
  end

  it 'has posts_counter' do
    expect(subject.posts_counter).to eq(0)
  end

  it 'method recent_posts returns the 3 most recent posts' do
    expect(subject.recent_posts).to eq(subject.posts.order(updated_at: :desc).limit(3))
  end
end

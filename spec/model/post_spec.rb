require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.new(name: 'John', photo: 'https://www.google.com', bio: 'I am a user')}
  subject { Post.new(title: 'Title', text: 'Text', author: user) }
  before { subject.save }

  it 'has title' do
    expect(subject.title).to eq('Title')
  end

  it 'has text' do
    expect(subject.text).to eq('Text')
  end

  it "title has a maximum length of 250 characters" do
    expect(subject.title.length).to be <= 250
  end

  it 'likes_counter must be 0 or greater' do
    expect(subject.likes_counter).to be >= 0
  end

  it 'method recent_comments returns the 5 most recent comments' do
    expect(subject.recent_comments).to eq(subject.comments.order(updated_at: :desc).limit(5))
  end

  it 'method update_posts_counter increments posts_counter by 1' do
    expect(subject.send(:update_posts_counter)).to eq(subject.author.increment!(:posts_counter))
  end
end

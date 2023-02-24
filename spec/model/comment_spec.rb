require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.new(name: 'John', photo: 'https://www.google.com', bio: 'I am a user')}
  let(:post) { Post.new(title: 'Title', text: 'Text', author: user) }
  subject { Comment.new(text: 'Text', author: user, post: post) }
  before { subject.save }

  it 'has post' do
    expect(subject.post).to eq(post)
  end

  it 'has User' do
    expect(subject.author).to eq(user)
  end

  it 'method update_comments_counter increments comments_counter by 1' do
    expect(subject.send(:update_comments_counter)).to eq(subject.post.increment!(:comments_counter))
  end
end

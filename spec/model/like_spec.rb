require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user1) { User.new(name: 'John', photo: 'https://www.google.com', bio: 'I am a user')}
  let(:post1) { Post.new(title: 'Title', text: 'Text', author: user1) }
  subject { Like.new(posts: post1, author: user1 )  }
  before { subject.save }

  it 'has post' do
    expect(subject.posts).to eq(post1)
  end

  it 'method update_likes_counter increments likes_counter by 1' do
    expect(subject.send(:update_likes_counter)).to eq(subject.posts.increment!(:likes_counter))
  end

  it 'belongs to author' do
    expect(subject.author).to eq(user1)
  end
end

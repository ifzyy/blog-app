require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.create(name: 'Harry', photo: 'https://unsplash.com/photos/pHPzdEHN6Os', bio: 'Web Designer')
  describe 'Validation' do
    it 'Post should be valid' do
      post = Post.new(author: user, title: 'Full Stack Tutorial', text: 'This is complete tutorial',
                      comments_counter: 3, likes_counter: 2)
      expect(post).to be_valid
    end

    it 'Post should not be valid' do
      Post.new(author: user, title: 'Full Stack Tutorial', text: 'This is complete tutorial',
               comments_counter: 3, likes_counter: 'two')
      expect(subject).to_not be_valid
    end

    it 'should not accept more than 250 character' do
      subject.title = "
      Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula
      eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient
      montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque
      eu, pretium quis,"
      expect(subject).to_not be_valid
    end
  end

  describe 'Method Update post counter' do
    before { user.posts_counter = 3 }
    it 'should increment the post counter' do
      post = Post.new(author: user, title: 'Full Stack Tutorial', text: 'This is complete tutorial',
                      comments_counter: 3, likes_counter: 2)
      post.update_posts_counter
      expect(user.posts_counter).to eq(4)
    end
    it 'post_counter should be a greater than or equal to 0' do
      expect(user.posts_counter).to be >= 0
    end
  end

  describe 'Method recent comment should return latest 5 comments' do
    post = Post.create(author_id: user.id, title: 'Full stack Tutorial', text: 'This is complete tutorial',
                       comments_counter: 3, likes_counter: 2)
    before { 6.times { |n| Comment.create(post_id: post.id, author_id: user.id, text: "Hi comment #{n}") } }
    it 'should return 5 recent comments' do
      expect(post.recent_comments).to eq(post.comments.last(5))
    end
  end

  describe 'get comments counter and like counter' do
    post = Post.create(author_id: user.id, title: 'Full stack Tutorial', text: 'This is complete tutorial',
                       comments_counter: 3, likes_counter: 2)
    before { 6.times { |n| Comment.create(post_id: post.id, author_id: user.id, text: "Hi comment #{n}") } }

    it 'likes_counter should be a greater than or equal to 0' do
      expect(post.likes_counter).to be >= 0
    end

    it 'comments_counter should be a greater than or equal to 0' do
      expect(post.comments_counter).to be >= 0
    end
  end
end

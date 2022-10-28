require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  subject { User.create(name: 'Johnson Emmanuel', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from nigeria.', posts_counter: 0) }

  describe 'GET /index' do
    before(:each) do
      get "/users/#{subject.id}/posts"
    end

    it 'Users index is successful' do
      expect(response).to have_http_status(:ok)
    end
    it 'Renders template correctly' do
      expect(response).to render_template(:index)
    end

    it 'Response should include right placeholder text' do
      expect(response.body).to include('List of all post for a given user')
    end
  end

  describe 'Show single user details' do
    before(:each) do
      user = User.create(name: 'Johnson emmanuel', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                         bio: 'Teacher from nigeria.', posts_counter: 0)

      new_post = Post.create(author: user, title: 'Hello', text: 'This is my first post', likes_counter: 0,
                             comments_counter: 0)
      get "/users/#{user.id}/posts/#{new_post.id}"
    end

    it 'Response will be successful.' do
      expect(response).to have_http_status(:ok)
    end
    it 'Template render correctly' do
      expect(response).to render_template(:show)
    end
    it 'Response should include right placeholder text.' do
      expect(response.body).to include('Post details will be shown here')
    end
  end
end

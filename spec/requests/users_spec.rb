require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    before(:each) do
      get '/users'
    end

    it 'Users index is successful' do
      expect(response).to have_http_status(:ok)
    end
    it 'Renders template correctly' do
      expect(response).to render_template(:index)
    end

    it 'Response should include right placeholder text' do
      expect(response.body).to include('List of Users')
    end
  end

  describe 'Show single user details' do
    before(:each) do
      user = User.create(name: 'Johnson', photo: 'https://unsplash.com/photos/fF_-0BxGuVvo',
                         bio: 'Teacher from nigeria.', posts_counter: 0)
      get "/users/#{user.id}"
    end
    it 'Response will be successful.' do
      expect(response).to have_http_status(:ok)
    end
    it 'Template render correctly' do
      expect(response).to render_template(:show)
    end
    it 'Response should include right placeholder text.' do
      expect(response.body).to include('User details will be shown here')
    end
  end
end

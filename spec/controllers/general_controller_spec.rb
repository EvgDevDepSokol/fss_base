require 'rails_helper'

include GeneralControllerHelper

describe GeneralController, type: :controller do
  describe 'GET #index' do
    let(:project) { FactoryGirl.create(:pds_project) }

    TableList.each do |table_name, _title|
      it "responds successfully with an HTTP 200 status code for #{table_name}" do
        get :index, model: table_name, pds_project_id: project.id
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET #index' do
    before { pending }
    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'loads all of the posts into @posts' do
      post1 = Post.create!
      post2 = Post.create!
      get :index

      expect(assigns(:posts)).to match_array([post1, post2])
    end
  end
end

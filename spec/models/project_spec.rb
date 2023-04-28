require "rails_helper"

describe "Project Attribute Requirements on Create", :type => :model do
  context "validation tests" do
    it "ensures the title and description are present when creating project" do
      project = Project.new(title: "Title")
      expect(project.valid?).to eq(false)
    end

    it "should not be able to save project when title and description missing" do
      project = Project.new
      expect(project.save).to eq(false)
    end

    it "should not be able to save project when description missing" do
      project = Project.new(title: "Title")
      expect(project.save).to eq(false)
    end

    it "should be able to save project when have description and title" do
      project = Project.new(title: "Title", description: "Content of the description")
      expect(project.save).to eq(true)
    end
  end
end

describe "Project Attribute Requirements on Edit", :type => :model do
  context "Edit project" do 
    before(:each) do
      @project = Project.create(title: "Title", description: "Content of the description")
    end

    it "ensures the title and description are present when editing project" do
      @project.update(title: "New Title")
      expect(@project.valid?).to eq(true)
    end

    it "should not be able to update project when title and description missing" do
      @project.update(title: nil, description: nil)
      expect(@project.valid?).to eq(false)
    end

    it "should not be able to update project when description missing" do
      @project.update(description: nil)
      expect(@project.valid?).to eq(false)
    end

    it "should be able to update project when have description and title" do
      @project.update(title: "New Title", description: "New content of the description")
      expect(@project.valid?).to eq(true)
    end
  end
end


RSpec.describe ProjectsController, type: :controller do
    let(:user) { create(:user) }
    let(:project) { create(:project) }
  
    describe 'GET #index' do
      it 'returns http success' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  
    describe 'GET #show' do
      it 'returns http success' do
        get :show, params: { id: project.id }
        expect(response).to have_http_status(:success)
      end
    end
  
    describe 'GET #new' do
      context 'when user is not authenticated' do
        it 'redirects to the login page' do
          get :new
          expect(response).to redirect_to(new_user_session_path)
        end
      end
  
      context 'when user is authenticated' do
        before { sign_in user }
  
        it 'returns http success' do
          get :new
          expect(response).to have_http_status(:success)
        end
      end
    end
  
    describe 'POST #create' do
      context 'when user is not authenticated' do
        it 'redirects to the login page' do
          post :create, params: { project: attributes_for(:project) }
          expect(response).to redirect_to(new_user_session_path)
        end
      end
  
      context 'when user is authenticated' do
        before { sign_in user }
  
        context 'with valid parameters' do
          it 'creates a new project' do
            expect {
              post :create, params: { project: attributes_for(:project) }
            }.to change(Project, :count).by(1)
          end
  
          it 'redirects to the project page' do
            post :create, params: { project: attributes_for(:project) }
            expect(response).to redirect_to(Project.last)
          end
        end
  
        context 'with invalid parameters' do
          it 'does not create a new project' do
            expect {
              post :create, params: { project: attributes_for(:project, title: '') }
            }.not_to change(Project, :count)
          end
  
          it 'renders the new template' do
            post :create, params: { project: attributes_for(:project, title: '') }
            expect(response).to render_template(:new)
          end
        end
      end
    end
  
    describe 'GET #edit' do
      context 'when user is not authenticated' do
        it 'redirects to the login page' do
          get :edit, params: { id: project.id }
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end
end

RSpec.describe CommentsController, type: :controller do
    let(:project) { FactoryBot.create(:project) }
    
    describe "POST #create" do
      context "with valid params" do
        let(:valid_attributes) { { content: "Test comment" } }
        
        it "creates a new comment" do
          expect {
            post :create, params: { project_id: project.id, comment: valid_attributes }
          }.to change { project.comments.count }.by(1)
        end
  
        it "redirects to the project" do
          post :create, params: { project_id: project.id, comment: valid_attributes }
          expect(response).to redirect_to(project)
        end
      end
      
      context "with invalid params" do
        let(:invalid_attributes) { { content: "" } }
        
        it "does not create a new comment" do
          expect {
            post :create, params: { project_id: project.id, comment: invalid_attributes }
          }.not_to change { Comment.count }
        end
  
        it "re-renders the project page" do
          post :create, params: { project_id: project.id, comment: invalid_attributes }
          expect(response).to render_template("projects/show")
        end
      end
    end
end

RSpec.feature "Projects", type: :feature do
    context "Update project" do
      let(:project) { Project.create(title: "Test title", description: "Test content") }
      before(:each) do
        visit edit_project_path(project)
      end
 
 
      scenario "should be successful" do
        within("form") do
          fill_in "Description", with: "New description content"
        end
        click_button "Update Project"
        expect(page).to have_content("Project was successfully updated")
      end
 
 
      scenario "should fail" do
        within("form") do
          fill_in "Description", with: ""
        end
        click_button "Update Project"
        expect(page).to have_content("Description can't be blank")
      end
    end
end


  

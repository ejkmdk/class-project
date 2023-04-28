require "rails_helper"

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

    scenario "should fail if title is missing" do
      within("form") do
        fill_in "Title", with: ""
      end

      click_button "Update Project"

      expect(page).to have_content("Title can't be blank")
    end

    scenario "should fail if description is missing" do
      within("form") do
        fill_in "Description", with: ""
      end

      click_button "Update Project"

      expect(page).to have_content("Description can't be blank")
    end
  end

  context "Create project" do
    before(:each) do
      visit new_project_path
    end

    scenario "should be successful" do
      within("form") do
        fill_in "Title", with: "New project title"
        fill_in "Description", with: "New project description"
      end

      click_button "Create Project"

      expect(page).to have_content("Project was successfully created")
    end

    scenario "should fail if title is missing" do
      within("form") do
        fill_in "Title", with: ""
        fill_in "Description", with: "New project description"
      end

      click_button "Create Project"

      expect(page).to have_content("Title can't be blank")
    end

    scenario "should fail if description is missing" do
      within("form") do
        fill_in "Title", with: "New project title"
        fill_in "Description", with: ""
      end

      click_button "Create Project"

      expect(page).to have_content("Description can't be blank")
    end
  end
end

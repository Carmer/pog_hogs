require 'rails_helper'

  describe "User can edit their account" do
    context "when they click on edit account" do
      scenario "and change fields" do
        user = User.create(
                           first_name: "John",
                           last_name: "Doe",
                           email: "johndoe@gmail.com",
                           password: "password"
                           )
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit dashboard_path
        click_on "Edit My Profile"
        expect(current_path).to eq edit_user_path(user)

        fill_in "user[first_name]", with: "Jonathan"
        fill_in "user[email]", with: "jonathandoe@gmail.com"
        fill_in "user[password]", with: "newpassword"
        fill_in "user[password_confirmation]", with: "newpassword"
        click_on "Update User"

        expect(page).to have_content "Your Profile has been updated."
        expect(page).to have_content "Your Profile"
        expect(current_path).to eq '/dashboard'
      end
    end
  end

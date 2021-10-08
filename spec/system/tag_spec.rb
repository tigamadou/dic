require 'rails_helper'
require 'date'
RSpec.describe 'Tag management function', type: :system do
    describe 'administarion tests one' do
        before(:each) do
            @user= FactoryBot.create(:user)
            @user2= FactoryBot.create(:admin)
            visit login_path
        end
        context 'access test' do
            it 'admin user should access the tags adminarea' do
                fill_in('session[email]', with: @user2.email)
                fill_in('session[password]', with: @user2.password)
                click_button 'Log in'
                expect(current_path).to eq root_path
                expect(page).to have_content 'Connected'
                expect(page).to have_content 'Tasks'
                visit admin_tags_path
                expect(page).to have_content 'Tags'
            end
    
            it 'default user should not access the tags adminarea' do
                fill_in('session[email]', with: @user.email)
                fill_in('session[password]', with: @user.password)
                click_button 'Log in'
                expect(current_path).to eq root_path
                expect(page).to have_content 'Connected'
                expect(page).to have_content 'Tasks'
                visit admin_tags_path
                expect(current_path).to eq root_path
                expect(page).to have_content 'Area access restricted to Administrator.!'
            end
    
        end
    end

    describe 'administration tests 2' do
        before(:each) do
            @user= FactoryBot.create(:admin)
            visit login_path
            fill_in('session[email]', with: @user.email)
            fill_in('session[password]', with: @user.password)
            click_button 'Log in'
            expect(current_path).to eq root_path
            expect(page).to have_content 'Connected'
            expect(page).to have_content 'Tasks'
            visit admin_tags_path
            expect(page).to have_content 'Tags'
        end
    
        context 'tag creation' do 
    
            it 'create a new tag' do
            
                click_link 'New Tag'
                expect(current_path).to eq new_admin_tag_path
                title = Faker::Lorem.word
                fill_in('tag[title]', with: title)
                
                click_button 'Create Tag'
                visit admin_tags_path
                expect(page).to have_content title
            end
    
            it 'access the tag details page' do
                tag = FactoryBot.create(:tag)
                visit admin_tag_path tag
                expect(page).to have_content tag.title
            end
    
            it 'edit the tag details' do
                tag = FactoryBot.create(:tag)
                visit edit_admin_tag_path tag
                expect(page).to have_content 'Editing Tag'
                new_title =  Faker::Lorem.word
                fill_in('tag[title]', with: new_title)
                click_button 'Update Tag'
                expect(current_path).to eq admin_tag_path tag
                expect(page).to have_content new_title
            end
    
            it 'delete the tag' do 
                tag = FactoryBot.create(:tag)
                visit admin_tags_path
                click_link('Destroy', :match => :first)
                page.driver.browser.switch_to.alert.accept
                expect(page).to have_content 'Tag was successfully destroyed.'
            end
        end
    end
end
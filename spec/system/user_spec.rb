require 'rails_helper'
require 'date'
RSpec.describe 'User integration tests', type: :system do
    
  
  describe 'Registration tests' do 
    context 'success' do

        it 'creates a new user' do
         visit register_path
         expect(page).to have_content 'Registration'
         fill_in('user[name]', with: 'Test User')
         fill_in('user[email]', with: 'testemail@test.com')
         fill_in('user[password]', with: '123456')
         fill_in('user[password_confirmation]', with: '123456')
         click_button 'Create User'
         expect(page).to have_content 'Connected'
         expect(page).to have_content 'Tasks'
        end
    end

    context 'errors' do
        it 'should fails if name not provided' do
            visit register_path
            expect(page).to have_content 'Registration'
            fill_in('user[email]', with: 'testemail@test.com')
            fill_in('user[password]', with: '123456')
            fill_in('user[password_confirmation]', with: '123456')
            click_button 'Create User'
            expect(current_path).to eq users_path
            expect(page).to have_content '1 error prohibited this user from being saved:'
            expect(page).to have_content 'Name can\'t be blank'
        end

        it 'should fails if email not provided' do
            visit register_path
            expect(page).to have_content 'Registration'
            fill_in('user[name]', with: 'My name')
            fill_in('user[password]', with: '123456')
            fill_in('user[password_confirmation]', with: '123456')
            click_button 'Create User'
            expect(current_path).to eq users_path
            expect(page).to have_content '2 errors prohibited this user from being saved:'
            expect(page).to have_content 'Email can\'t be blank'
            expect(page).to have_content 'Email is invalid'
        end

        it 'should fails if password is not provided' do
            visit register_path
            expect(page).to have_content 'Registration'
            fill_in('user[name]', with: 'My name')
            fill_in('user[email]', with: 'email.domain.com')
            fill_in('user[password]', with: '')
            fill_in('user[password_confirmation]', with: '')
            click_button 'Create User'
            expect(current_path).to eq users_path
            expect(page).to have_content 'Password can\'t be blank'
            expect(page).to have_content 'Password is too short (minimum is 6 characters)'
        end

        it 'should fails if password_confirmation don\'t match' do
            visit register_path
            expect(page).to have_content 'Registration'
            fill_in('user[name]', with: 'My name')
            fill_in('user[email]', with: 'email.domain.com')
            fill_in('user[password]', with: '123456')
            fill_in('user[password_confirmation]', with: '654321')
            click_button 'Create User'
            expect(current_path).to eq users_path
            expect(page).to have_content 'Password confirmation doesn\'t match Password'
        end
    end
    
  end

  describe 'Session tests' do
    user= FactoryBot.create(:user)
    before(:each) do
        visit login_path
    end
    context 'Connect the user' do
        it 'logs in the user' do
            
            fill_in('session[email]', with: user.email)
            fill_in('session[password]', with: user.password)
            click_button 'Log in'
            expect(current_path).to eq root_path
            expect(page).to have_content 'Connected'
            expect(page).to have_content 'Tasks'
        end

        it 'logs out the user' do
            visit login_path
            fill_in('session[email]', with: user.email)
            fill_in('session[password]', with: user.password)
            click_button 'Log in'
            expect(current_path).to eq root_path
            expect(page).to have_content 'Connected'
            expect(page).to have_content 'Tasks'
            click_link 'Logout'
            expect(current_path).to eq logout_path
            expect(page).to have_content 'Logged out'
        end
    end
    
    context 'Show error the user' do
        it 'fails to log in the user' do
            fill_in('session[email]', with: user.email)
            fill_in('session[password]', with: '9774565')
            click_button 'Log in'
            expect(current_path).to eq sessions_path
            expect(page).to have_content 'Wrong credentials.!'
            
        end
    end

    
  end

  describe 'user account tests' do
    before(:each) do
        @user= FactoryBot.create(:user)
        @user2= FactoryBot.create(:user)
        visit login_path
        fill_in('session[email]', with: @user.email)
        fill_in('session[password]', with: @user.password)
        click_button 'Log in'
        expect(current_path).to eq root_path
        expect(page).to have_content 'Connected'
        expect(page).to have_content 'Tasks'
    end
    context 'browse my page' do
        it 'shows current user page' do 
            click_link 'My page'
            expect(current_path).to eq mypage_path
            expect(page).to have_content @user.name
        end

        it 'redirect to task list if not the current user' do
            visit user_path(@user2)
            expect(current_path).to eq root_path
        end


    end
  end

  describe 'administarion tests one' do
    before(:each) do
        @user= FactoryBot.create(:user)
        @user2= FactoryBot.create(:admin)
        visit login_path
    end
    context 'access test' do
        it 'admin user should access the adminarea' do
            fill_in('session[email]', with: @user2.email)
            fill_in('session[password]', with: @user2.password)
            click_button 'Log in'
            expect(current_path).to eq root_path
            expect(page).to have_content 'Connected'
            expect(page).to have_content 'Tasks'
            visit admin_users_path
            expect(page).to have_content 'Users'
        end

        it 'default user should not access the adminarea' do
            fill_in('session[email]', with: @user.email)
            fill_in('session[password]', with: @user.password)
            click_button 'Log in'
            expect(current_path).to eq root_path
            expect(page).to have_content 'Connected'
            expect(page).to have_content 'Tasks'
            visit admin_users_path
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
        visit admin_users_path
        expect(page).to have_content 'Users'
    end

    context 'user creation' do 

        it 'create a new user' do
        
            click_link 'New User'
            expect(current_path).to eq new_admin_user_path
            testUser = {
                name: Faker::Games::Pokemon.name, 
                email: Faker::Internet.email,
                password: Faker::Internet.password,
            }
            fill_in('user[name]', with: testUser[:name])
            fill_in('user[email]', with: testUser[:email])
            fill_in('user[password]', with: testUser[:password])
            fill_in('user[password_confirmation]', with: testUser[:password])
            select "Default", :from => "user[role]"
            click_button 'Create User'
            expect(current_path).to eq admin_users_path
            expect(page).to have_content testUser[:name]
        end

        it 'access the user details page' do
            user = FactoryBot.create(:user)
            visit admin_user_path user
            expect(page).to have_content user.name
        end

        it 'edit the user details' do
            user = FactoryBot.create(:user)
            visit edit_admin_user_path user
            expect(page).to have_content 'Editing User'
            new_name =  Faker::Games::Pokemon.name
            fill_in('user[name]', with: new_name)
            click_button 'Update User'
            expect(current_path).to eq admin_user_path user
            expect(page).to have_content new_name
        end

        it 'delete the user' do 
        
            click_link('Destroy', :match => :first)
            page.driver.browser.switch_to.alert.accept
            expect(page).to have_content 'User was successfully destroyed.'
        end
    end
  end

end
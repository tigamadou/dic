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
         expect(page).to have_content 'Conected'
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
    context 'Connect the user' do
        it 'logs in the user' do
            visit login_path
            fill_in('session[email]', with: user.email)
            fill_in('session[password]', with: user.password)
            click_button 'Log in'
            expect(current_path).to eq root_path
            expect(page).to have_content 'Conected'
            expect(page).to have_content 'Tasks'
        end
    end
    
    context 'Show error the user' do
        it 'fails to log in the user' do
            visit login_path
            fill_in('session[email]', with: user.email)
            fill_in('session[password]', with: '9774565')
            click_button 'Log in'
            expect(current_path).to eq sessions_path
            expect(page).to have_content 'Wrong credentials.!'
            
        end
    end
  end

end
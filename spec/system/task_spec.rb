require 'rails_helper'
require 'date'
RSpec.describe 'Task management function', type: :system do
    
  
  describe 'Task display function' do
    
    context 'When transitioning to the list screen' do
      task1 = FactoryBot.create(:task)
      it 'displays the task list' do
        visit tasks_path
        expect(current_path).to eq tasks_path
        expect(page).to have_content 'Tasks'
      end

      it 'doesn\'t display the tasks list' do
        expect(current_path).not_to eq tasks_path
      end

      
    end

    context 'When transitioning to the task details page' do
        task1 = FactoryBot.create(:task)
        it 'show the details of the created task' do 
            visit tasks_path
            expect(current_path).to eq tasks_path
            expect(page).to have_content 'Tasks'
            click_link('Show', :match => :first)
            expect(page).to have_content task1.name
        end
    end

    context 'When tasks are arranged in descending order of creation date and time' do
      it 'New task is displayed at the top' do
        task4 = FactoryBot.create(:task, name: 'The last Task')
        visit tasks_path
        expect(current_path).to eq tasks_path
        expect(page).to have_content task4.name
        expect(page.first('tbody > tr')).to have_content task4.name
      end
    end

    
  end

  describe "Task creation and edition actions" do
    
    context 'When creating a task' do
        it 'Create a new task' do
            visit tasks_path
            click_link 'New Task'
            expect(current_path).to eq new_task_path
            expect(page).to have_content 'New Task'
            name = 'My Test Task'
            content = 'This is a simple content'
            status = 'awaiting'

            fill_in('Name', :with => name)
            fill_in('Content', :with => content)
            select "Completed", :from => "task[status]"
            click_button 'Create Task'

            expect(current_path).to eq task_path Task.last

            expect(page).to have_content name
        end

        it 'doesn\' create a new task if the name is not provided' do
            visit tasks_path
            click_link 'New Task'
            expect(current_path).to eq new_task_path
            expect(page).to have_content 'New Task'

            content = 'This is a simple content'
            status = 'awaiting'

            fill_in('Content', :with => content)
            select "Completed", :from => "task[status]"
            click_button 'Create Task'

            expect(current_path).to eq tasks_path
            expect(page).to have_content 'Name can\'t be blank'
        end

        
    end

    context ' when editing a task' do
        task1 = FactoryBot.create(:task)
        it 'edits the task' do
            visit tasks_path
            expect(current_path).to eq tasks_path
            expect(page).to have_content 'Tasks'
            click_link('Edit', :match => :first)
            expect(page).to have_content 'Edit Task'
            editedName = 'Edited Task Name'
            fill_in('Name', :with => editedName)
            select "Completed", :from => "task[status]"
            click_button 'Update Task'
            
            expect(page).to have_content editedName
        end

        it 'doesn\' edit the task if the name is empty' do
            visit tasks_path
            expect(current_path).to eq tasks_path
            expect(page).to have_content 'Tasks'
            click_link('Edit', :match => :first)
            expect(page).to have_content 'Edit Task'
            fill_in('Name', :with => '')
            click_button 'Update Task'
            
            expect(page).to have_content 'Name can\'t be blank'
        end
    end

  end
  
  describe "Task deletion" do
    it 'delete the task' do 
        
        visit tasks_path
        expect(current_path).to eq tasks_path
        expect(page).to have_content 'Tasks'
        click_link('Destroy', :match => :first)
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'Task was successfully destroyed.'
    end

    
  end

  describe 'Deadline tests' do
    context 'Order the task ' do
      
      it 'orders the task by the deadlines ' do 
        visit tasks_path(sort_expired: "true")
        
      end
    end
  end

  describe 'Search function' do
    before do
      FactoryBot.create(:task, name: "First Task")
      FactoryBot.create(:task, name: "Second Task",status:'completed')
    end
    context 'If you do a fuzzy search by Title' do
      it "Filter by tasks that include search keywords" do
        visit tasks_path
        fill_in(:search, with: 'First')
        click_button 'Search'
        expect(current_path).to eq tasks_path
        expect(page).to have_content 'First Task'
        expect(page).not_to have_content 'Second Task'
      end
    end
    context 'When you search for status' do
      it "Tasks that exactly match the status are narrowed down" do
        visit tasks_path
        select "Completed", :from => "status"
        click_button 'Search'
        expect(current_path).to eq tasks_path
        expect(page).to have_content 'Second Task'
        expect(page).not_to have_content 'First Task'
      end
    end
    context 'Title performing fuzzy search of title and status search' do
      it "Narrow down tasks that include search keywords in the Title and exactly match the status" do
        # Implement here
        visit tasks_path
        fill_in(:search, with: 'Second')
        select "Completed", :from => "status"
        click_button 'Search'
        expect(current_path).to eq tasks_path
        expect(page).to have_content 'Second Task'
        expect(page).not_to have_content 'First Task'
      end
    end
  end

end
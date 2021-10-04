require 'rails_helper'

RSpec.describe Task, type: :model do


  describe 'Validation tests' do
    context 'presence of task name and content' do
      it 'creates the task if provided' do
        task = Task.new(name: '', content: 'Failure test')
        expect(task).not_to be_valid
      end

      it 'not creating the task if not provided' do
        task = Task.new(name: 'not empty', content: '')
        expect(task).not_to be_valid
      end

      it 'create the task if both are provided' do
        task = FactoryBot.create(:task)
        expect(task).to be_valid
      end
    end

    
  end

end

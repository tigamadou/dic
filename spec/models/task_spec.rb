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

  describe 'Search tests' do 
    let!(:task1){ FactoryBot.create(:task)}
    let!(:task2) {FactoryBot.create(:task, name: 'Second Task', status: 'completed')}
    context 'filter the result with the search' do
      it 'return one task' do
        result = Task.search('Second')
        expect(result).to include(task2)
        expect(result).not_to include(task1)
        expect(result.count).to eq(1)
      end
    end

    context 'filter the result by status' do
      it ' returns the macthed elements' do
        result = Task.filter_by_status('completed')
        expect(result).to include(task2)
        expect(result).not_to include(task1)
        expect(result.count).to eq(1)
      end
    end

    context 'filter by search and status' do 
      it 'returns the element macthed both status and name' do
        result = Task.filter_by_status('completed').search('Second')
        expect(result).to include(task2)
        expect(result).not_to include(task1)
        expect(result.count).to eq(1)
      end
    end

  end

  
end

require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'Validation tests' do
    context 'presence of tag title ' do
      it 'creates the tag if not provided' do
        tag = Tag.new(title: '')
        expect(tag).not_to be_valid
      end

      it 'creates the tag if  provided' do
        task = Tag.new(title: 'not empty')
        expect(task).to be_valid
      end

     
    end

    
  end
end

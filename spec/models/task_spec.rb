require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'associations' do
    it 'belongs to teacher' do
      expect(Task.reflect_on_association(:teacher).macro).to eq(:belongs_to)
      expect(Task.reflect_on_association(:teacher).options[:class_name]).to eq('User')
    end

    it 'belongs to student' do
      expect(Task.reflect_on_association(:student).macro).to eq(:belongs_to)
      expect(Task.reflect_on_association(:student).options[:class_name]).to eq('User')
    end

    it 'belongs to instrument' do
      expect(Task.reflect_on_association(:instrument).macro).to eq(:belongs_to)
    end
  end

  describe 'enums' do
    it 'defines enum for status' do
      expect(Task.statuses).to eq({"todo"=>0, "pending"=>1, "completed"=>2})
    end
  end

  describe '#deadline_day_this_week' do
    context 'when deadline is within the current week' do
      it 'returns the day of the week' do
        task = create(:task, deadline: Date.current.beginning_of_week(:monday))
        expect(task.deadline_day_this_week).to eq('Monday')
      end
    end

    context 'when deadline is not within the current week' do
      it 'returns nil' do
        task = create(:task, deadline: Date.current.next_week(:monday))
        expect(task.deadline_day_this_week).to be_nil
      end
    end
  end

  describe '#deadline_readable' do
    it 'returns the formatted deadline' do
      task = create(:task, deadline: Date.new(2023, 6, 15))
      expect(task.deadline_readable).to eq('15 June 2023')
    end
  end
end
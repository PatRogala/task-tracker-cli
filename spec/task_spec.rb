require 'rspec'
require_relative '../lib/task'
require 'timecop'
RSpec.describe Task do
  let(:task_id) { 1 }
  let(:task_description) { 'Complete the project' }

  describe '#initialize' do
    it 'creates a task with default status' do
      task = Task.new(task_id, description: task_description)
      expect(task.id).to eq(task_id)
      expect(task.description).to eq(task_description)
      expect(task.status).to eq(Task::STATUSES[:todo])
      expect(task.created_at).to be_within(1).of(Time.now)
      expect(task.updated_at).to be_within(1).of(Time.now)
    end

    it 'creates a task with custom status' do
      task = Task.new(task_id, description: task_description, status: Task::STATUSES[:in_progress])
      expect(task.status).to eq(Task::STATUSES[:in_progress])
    end
  end

  describe '#update_description' do
    it 'updates the description and timestamp' do
      task = Task.new(task_id, description: task_description)
      new_description = 'Updated description'
      
      Timecop.freeze(Time.now + 1) do
        task.update_description(new_description)
        expect(task.description).to eq(new_description)
        expect(task.updated_at).to be_within(0.1).of(Time.now)
      end
    end
  end

  describe '#update_status' do
    it 'updates the status and timestamp' do
      task = Task.new(task_id, description: task_description)
      new_status = Task::STATUSES[:done]
      
      Timecop.freeze(Time.now + 1) do
        task.update_status(new_status)
        expect(task.status).to eq(new_status)
        expect(task.updated_at).to be_within(0.1).of(Time.now)
      end
    end
  end
end
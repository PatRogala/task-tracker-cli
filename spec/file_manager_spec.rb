require 'spec_helper'
require_relative '../lib/file_manager'
require_relative '../lib/task'

RSpec.describe FileManager do
  let(:test_file_path) { 'test_tasks.json' }
  let(:file_manager) { FileManager.new(test_file_path) }

  before(:each) do
    File.delete(test_file_path) if File.exist?(test_file_path)
  end

  after(:each) do
    File.delete(test_file_path) if File.exist?(test_file_path)
  end

  describe '#initialize' do
    it 'creates a new file if it does not exist' do
      expect(File.exist?(test_file_path)).to be false
      FileManager.new(test_file_path)
      expect(File.exist?(test_file_path)).to be true
    end
  end

  describe '#read' do
    it 'returns an empty array when the file is empty' do
      expect(file_manager.read).to eq([])
    end

    it 'returns an array of Task objects' do
      task = Task.new(1, description: 'Test task', status: 'pending')
      file_manager.write(task)

      tasks = file_manager.read
      expect(tasks).to be_an(Array)
      expect(tasks.first).to be_a(Task)
      expect(tasks.first.id).to eq(1)
      expect(tasks.first.description).to eq('Test task')
      expect(tasks.first.status).to eq('pending')
    end
  end

  describe '#write' do
    it 'adds a new task to the file' do
      task = Task.new(1, description: 'New task', status: 'pending')
      file_manager.write(task)

      tasks = file_manager.read
      expect(tasks.length).to eq(1)
      expect(tasks.first.id).to eq(1)
      expect(tasks.first.description).to eq('New task')
    end

    it 'updates an existing task' do
      task = Task.new(1, description: 'Original task', status: 'pending')
      file_manager.write(task)

      updated_task = Task.new(1, description: 'Updated task', status: 'completed')
      file_manager.write(updated_task)

      tasks = file_manager.read
      expect(tasks.length).to eq(1)
      expect(tasks.first.id).to eq(1)
      expect(tasks.first.description).to eq('Updated task')
      expect(tasks.first.status).to eq('completed')
    end
  end
end
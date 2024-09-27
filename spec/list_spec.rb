require 'rspec'
require_relative '../lib/list'
require_relative '../lib/task'
require_relative '../lib/file_manager'

RSpec.describe List do
  let(:file_manager) { instance_double(FileManager) }
  let(:list) { List.new }

  before do
    allow(FileManager).to receive(:new).and_return(file_manager)
    allow(file_manager).to receive(:read).and_return([])
    allow(file_manager).to receive(:write)
  end

  describe '#initialize' do
    it 'creates a new FileManager instance' do
      expect(FileManager).to receive(:new)
      List.new
    end

    it 'reads items from the file manager' do
      expect(file_manager).to receive(:read)
      List.new
    end
  end

  describe '#add' do
    it 'adds a new task to the list' do
      list.add('New task')
      expect(list.list_all.size).to eq(1)
      expect(list.list_all.first.description).to eq('New task')
    end

    it 'writes the new task to the file manager' do
      expect(file_manager).to receive(:write)
      list.add('New task')
    end
  end

  describe '#update' do
    let(:task) { Task.new(1, description: 'Old task') }

    before do
      allow(file_manager).to receive(:read).and_return([task])
      list.instance_variable_set(:@items, [task])
    end

    it 'updates the description of an existing task' do
      list.update(1, 'Updated task')
      expect(list.list_all.first.description).to eq('Updated task')
    end

    it 'writes the updated task to the file manager' do
      expect(file_manager).to receive(:write)
      list.update(1, 'Updated task')
    end

    it 'does nothing if the task is not found' do
      expect(file_manager).not_to receive(:write)
      list.update(2, 'Non-existent task')
    end
  end

  describe '#delete' do
    let(:task) { Task.new(1, description: 'Task to delete') }

    before do
      allow(file_manager).to receive(:read).and_return([task])
      list.instance_variable_set(:@items, [task])
    end

    it 'removes the task from the list' do
      list.delete(1)
      expect(list.list_all).to be_empty
    end

    it 'writes the deleted task to the file manager' do
      expect(file_manager).to receive(:write)
      list.delete(1)
    end

    it 'does nothing if the task is not found' do
      expect(file_manager).not_to receive(:write)
      list.delete(2)
    end
  end

  describe '#mark_as_in_progress' do
    let(:task) { Task.new(1, description: 'Task') }

    before do
      allow(file_manager).to receive(:read).and_return([task])
      list.instance_variable_set(:@items, [task])
    end

    it 'marks the task as in progress' do
      list.mark_as_in_progress(1)
      expect(list.list_all.first.status).to eq(Task::STATUSES[:in_progress])
    end

    it 'writes the updated task to the file manager' do
      expect(file_manager).to receive(:write)
      list.mark_as_in_progress(1)
    end
  end

  describe '#mark_as_done' do
    let(:task) { Task.new(1, description: 'Task') }

    before do
      allow(file_manager).to receive(:read).and_return([task])
      list.instance_variable_set(:@items, [task])
    end

    it 'marks the task as done' do
      list.mark_as_done(1)
      expect(list.list_all.first.status).to eq(Task::STATUSES[:done])
    end

    it 'writes the updated task to the file manager' do
      expect(file_manager).to receive(:write)
      list.mark_as_done(1)
    end
  end

  describe '#list_all' do
    it 'returns all tasks' do
      tasks = [
        Task.new(1, description: 'Task 1'),
        Task.new(2, description: 'Task 2')
      ]
      allow(file_manager).to receive(:read).and_return(tasks)
      list = List.new
      expect(list.list_all).to eq(tasks)
    end
  end

  describe '#list_done' do
    it 'returns only done tasks' do
      done_task = Task.new(1, description: 'Done task', status: Task::STATUSES[:done])
      not_done_task = Task.new(2, description: 'Not done task')
      allow(file_manager).to receive(:read).and_return([done_task, not_done_task])
      list = List.new
      expect(list.list_done).to eq([done_task])
    end
  end

  describe '#list_not_done' do
    it 'returns only not done tasks' do
      done_task = Task.new(1, description: 'Done task', status: Task::STATUSES[:done])
      not_done_task = Task.new(2, description: 'Not done task')
      allow(file_manager).to receive(:read).and_return([done_task, not_done_task])
      list = List.new
      expect(list.list_not_done).to eq([not_done_task])
    end
  end

  describe '#list_in_progress' do
    it 'returns only in progress tasks' do
      in_progress_task = Task.new(1, description: 'In progress task', status: Task::STATUSES[:in_progress])
      not_in_progress_task = Task.new(2, description: 'Not in progress task')
      allow(file_manager).to receive(:read).and_return([in_progress_task, not_in_progress_task])
      list = List.new
      expect(list.list_in_progress).to eq([in_progress_task])
    end
  end
end
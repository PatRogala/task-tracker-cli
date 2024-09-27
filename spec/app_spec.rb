require_relative '../lib/app'

RSpec.describe App do
  let(:app) { App.new }
  let(:list) { instance_double('List') }

  before do
    allow(List).to receive(:new).and_return(list)
    allow(app).to receive(:puts)
    allow(app).to receive(:print)
  end

  describe '#run' do
    it 'runs the application loop until exit command is given' do
      allow(app).to receive(:get_user_input).and_return('list', 'exit')
      expect(list).to receive(:list_all).and_return([])
      app.run
    end
  end

  describe '#process_command' do
    context 'when adding a task' do
      it 'adds a new task to the list' do
        expect(list).to receive(:add).with('New task')
        app.send(:process_command, 'add New task')
      end
    end

    context 'when listing tasks' do
      it 'lists all tasks' do
        expect(list).to receive(:list_all).and_return([])
        app.send(:process_command, 'list')
      end
    end

    context 'when updating a task' do
      it 'updates the task description' do
        expect(list).to receive(:update).with(1, 'Updated task')
        app.send(:process_command, 'update 1 Updated task')
      end
    end

    context 'when deleting a task' do
      it 'deletes the task' do
        expect(list).to receive(:delete).with(1)
        app.send(:process_command, 'delete 1')
      end
    end

    context 'when marking a task as in progress' do
      it 'marks the task as in progress' do
        expect(list).to receive(:mark_as_in_progress).with(1)
        app.send(:process_command, 'mark_in_progress 1')
      end
    end

    context 'when marking a task as done' do
      it 'marks the task as done' do
        expect(list).to receive(:mark_as_done).with(1)
        app.send(:process_command, 'mark_done 1')
      end
    end

    context 'when listing done tasks' do
      it 'lists completed tasks' do
        expect(list).to receive(:list_done).and_return([])
        app.send(:process_command, 'list_done')
      end
    end

    context 'when listing not done tasks' do
      it 'lists tasks not completed' do
        expect(list).to receive(:list_not_done).and_return([])
        app.send(:process_command, 'list_not_done')
      end
    end

    context 'when listing in progress tasks' do
      it 'lists tasks in progress' do
        expect(list).to receive(:list_in_progress).and_return([])
        app.send(:process_command, 'list_in_progress')
      end
    end

    context 'when given an invalid command' do
      it 'displays an error message' do
        expect(app).to receive(:puts).with("Invalid command. Please try again.")
        app.send(:process_command, 'invalid_command')
      end
    end
  end
end
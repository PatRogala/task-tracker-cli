require_relative 'task'
require_relative 'file_manager'

class List
  def initialize
    @file_manager = FileManager.new
    @items = @file_manager.read
  end

  def add(description)
    new_task_id = @items.empty? ? 1 : @items.map(&:id).max + 1
    task = Task.new(new_task_id, description: description)
    @items << task
    @file_manager.write(task)
  end

  def update(id, description)
    task = find_task(id)
    return unless task
    task.update_description(description)
    @file_manager.write(task)
  end

  def delete(id)
    task = find_task(id)
    return unless task
    @items.delete(task)
    @file_manager.write(task)
  end

  def mark_as_in_progress(id)
    update_status(id, Task::STATUSES[:in_progress])
  end

  def mark_as_done(id)
    update_status(id, Task::STATUSES[:done])
  end

  def list_all
    @items
  end

  def list_done
    @items.select { |task| task.status == Task::STATUSES[:done] }
  end

  def list_not_done
    @items.reject { |task| task.status == Task::STATUSES[:done] }
  end

  def list_in_progress
    @items.select { |task| task.status == Task::STATUSES[:in_progress] }
  end

  private

  def find_task(id)
    @items.find { |task| task.id == id }
  end

  def update_status(id, status)
    task = find_task(id)
    return unless task
    task.update_status(status)
    @file_manager.write(task)
  end
end

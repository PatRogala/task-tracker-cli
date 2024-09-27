require "json"

class FileManager
  def initialize(file_path = "tasks.json")
    @file_path = file_path
    create_file_if_not_exists
  end

  def read
    tasks = JSON.parse(File.read(@file_path))
    tasks.map do |task_data|
      Task.new(
        task_data['id'],
        description: task_data['description'],
        status: task_data['status']
      )
    end
  end

  def write(task)
    tasks = read
    existing_task = tasks.find { |t| t.id == task.id }
    if existing_task
      existing_task.description = task.description
      existing_task.status = task.status
      existing_task.updated_at = task.updated_at
    else
      tasks << task
    end
    save_tasks(tasks)
  end

  private

  def create_file_if_not_exists
    unless File.exist?(@file_path)
      File.write(@file_path, JSON.dump([]))
    end
  end

  def save_tasks(tasks)
    tasks_data = tasks.map do |task|
      {
        'id' => task.id,
        'description' => task.description,
        'status' => task.status,
        'created_at' => task.created_at,
        'updated_at' => task.updated_at
      }
    end
    File.write(@file_path, JSON.dump(tasks_data))
  end
end

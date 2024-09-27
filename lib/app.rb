require_relative 'list'

class App
  def initialize
    @list = List.new
  end

  def run
    puts "Welcome to the Todo List App!"
    loop do
      print_menu
      command = get_user_input
      process_command(command)
      break if command == 'exit'
    end
    puts "Thank you for using the Todo List App. Goodbye!"
  end

  private

  def print_menu
    puts "\nAvailable commands:"
    puts "add <description> - Add a new task"
    puts "list - List all tasks"
    puts "update <id> <new description> - Update a task's description"
    puts "delete <id> - Delete a task"
    puts "mark_in_progress <id> - Mark a task as in progress"
    puts "mark_done <id> - Mark a task as done"
    puts "list_done - List completed tasks"
    puts "list_not_done - List tasks not completed"
    puts "list_in_progress - List tasks in progress"
    puts "exit - Exit the application"
    print "\nEnter a command: "
  end

  def get_user_input
    gets.chomp.strip
  end

  def process_command(command)
    case command
    when /^add (.+)$/
      @list.add($1)
      puts "Task added successfully."
    when 'list'
      list_tasks(@list.list_all)
    when /^update (\d+) (.+)$/
      @list.update($1.to_i, $2)
      puts "Task updated successfully."
    when /^delete (\d+)$/
      @list.delete($1.to_i)
      puts "Task deleted successfully."
    when /^mark_in_progress (\d+)$/
      @list.mark_as_in_progress($1.to_i)
      puts "Task marked as in progress."
    when /^mark_done (\d+)$/
      @list.mark_as_done($1.to_i)
      puts "Task marked as done."
    when 'list_done'
      list_tasks(@list.list_done)
    when 'list_not_done'
      list_tasks(@list.list_not_done)
    when 'list_in_progress'
      list_tasks(@list.list_in_progress)
    when 'exit'
      # Do nothing, the main loop will handle this
    else
      puts "Invalid command. Please try again."
    end
  end

  def list_tasks(tasks)
    if tasks.empty?
      puts "No tasks found."
    else
      tasks.each do |task|
        puts "#{task.id}. [#{task.status}] #{task.description}"
      end
    end
  end
end
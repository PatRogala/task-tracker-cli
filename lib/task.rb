class Task
  STATUSES = {
    todo: 'todo',
    in_progress: 'in-progress',
    done: 'done'
  }

  attr_reader :id, :created_at
  attr_accessor :description, :status, :updated_at

  def initialize(id, description:, status: STATUSES[:todo])
    @id = id
    @description = description
    @status = status
    @created_at = Time.now
    @updated_at = Time.now
  end

  def update_description(description)
    @description = description
    update_timestamp
  end

  def update_status(status)
    @status = status
    update_timestamp
  end

  private

  def update_timestamp
    @updated_at = Time.now
  end
end

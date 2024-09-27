# Task Tracker

This is a simple command-line Todo List application written in Ruby.

[Link to project on roadmap.sh](https://roadmap.sh/projects/task-tracker)

## Features

- Add new tasks
- List all tasks
- Update task descriptions
- Delete tasks
- Mark tasks as in progress or done
- List tasks by status (all, done, not done, in progress)

## Requirements

- Ruby 3.3.2 (as specified in `.tool-versions`) (but any version above 2.7 should do the trick)

## Installation

1. Clone this repository
2. Navigate to the project directory
3. Run `bundle install` to install dependencies (if any)

## Usage

To start the application, run:

```
ruby lib/start.rb
```

## Commands

- `add <description>`: Add a new task
- `list`: List all tasks
- `update <id> <new description>`: Update a task's description
- `delete <id>`: Delete a task
- `mark_in_progress <id>`: Mark a task as in progress
- `mark_done <id>`: Mark a task as done
- `list_done`: List completed tasks
- `list_not_done`: List tasks not completed
- `list_in_progress`: List tasks in progress
- `exit`: Exit the application

## Running tests

```
rspec
```

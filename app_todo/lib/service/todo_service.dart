import 'package:app_todo/models/todo.dart';

import 'package:app_todo/database/repository.dart';

class TodoService {
  Repository _repository;

  TodoService() {
    _repository = Repository();
  }

  saveTodo(Todo todo) async {
    return await _repository.insertData("todos", todo.todoMap());
  }

  readTodo() async {
    return await _repository.readData('todos');
  }

  readTodoByCategory(category) async {
    return await _repository.readDataByColumnName(
        'todos', 'category', category);
  }
}

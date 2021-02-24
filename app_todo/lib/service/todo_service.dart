import 'package:app_todo/models/todo.dart';

import 'package:app_todo/database/repository.dart';

class TodoService {
  Repository _repository;

  TodoService() {
    _repository = Repository();
  }

  saveCategory(Todo todo) async {
    return await _repository.insertData("categories", todo.todoMap());
  }
}

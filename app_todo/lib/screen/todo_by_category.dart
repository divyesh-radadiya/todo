import 'package:flutter/material.dart';
import 'package:app_todo/models/todo.dart';
import 'package:app_todo/service/todo_service.dart';

class TodoByCategory extends StatefulWidget {
  final String category;
  TodoByCategory(this.category);

  @override
  _TodoByCategoryState createState() => _TodoByCategoryState();
}

class _TodoByCategoryState extends State<TodoByCategory> {
  List<Todo> _allTodo = List<Todo>();
  _getData() async {
    var allData = await TodoService().readTodoByCategory(widget.category);
    for (var data in allData) {
      _allTodo.add(Todo(
          title: data['title'],
          description: data['description'],
          id: data['id'],
          todoDate: data['todoDate'],
          isFinished: data['isFinished'],
          category: data['category']));
    }
    setState(() {});
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category - ${widget.category}'),
      ),
      body: ListView.builder(
          itemCount: _allTodo.length,
          itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0),
                child: Card(
                  elevation: 5.0,
                  child: ListTile(
                    title: Text(_allTodo[index].title ?? 'no'),
                    subtitle: Text(_allTodo[index].category ?? 'no'),
                    trailing: Text(_allTodo[index].todoDate ?? 'no'),
                  ),
                ),
              )),
    );
  }
}

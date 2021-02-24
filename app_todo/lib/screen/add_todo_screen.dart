import 'package:intl/intl.dart';
import 'package:app_todo/service/category_service.dart';
import 'package:flutter/material.dart';
import 'package:app_todo/models/todo.dart';
import 'package:app_todo/service/todo_service.dart';

class AddTodoScreen extends StatefulWidget {
  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  TextEditingController _todoTitleController = TextEditingController();
  TextEditingController _todoDescriptionController = TextEditingController();
  TextEditingController _todoDateController = TextEditingController();
  var _categories = List<DropdownMenuItem>();
  var _selectedValue;

  _loadCategories() async {
    var allData = await CategoryService().readCategory();
    for (var data in allData) {
      _categories.add(DropdownMenuItem(
        child: Text(data['name']),
        value: data['name'],
      ));
    }
    setState(() {});
  }

  DateTime _dateTime = DateTime.now();
  _selectedTodoDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (_pickedDate != null) {
      setState(() {
        _dateTime = _pickedDate;

        _todoDateController.text = DateFormat('yyyy-mm-dd').format(_pickedDate);
      });
    }
  }

  @override
  void initState() {
    _loadCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Todo')),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: _todoTitleController,
              decoration: InputDecoration(
                  labelText: 'Title', hintText: 'Write Todo Title'),
            ),
            TextField(
              controller: _todoDescriptionController,
              decoration: InputDecoration(
                  labelText: 'Description', hintText: 'Write Todo Description'),
            ),
            TextField(
              controller: _todoDateController,
              decoration: InputDecoration(
                  labelText: 'Date',
                  hintText: 'Pick a Date',
                  prefixIcon: InkWell(
                    onTap: () {
                      _selectedTodoDate(context);
                    },
                    child: Icon(Icons.calendar_today),
                  )),
            ),
            SizedBox(
              height: 10.0,
            ),
            DropdownButtonFormField(
                value: _selectedValue,
                hint: Text('Categories'),
                items: _categories,
                onChanged: (newValue) {
                  _selectedValue = newValue;
                }),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  color: Colors.blue,
                ),
                child: MaterialButton(
                  onPressed: () async {
                    var result = await TodoService().saveCategory(Todo(
                        title: _todoTitleController.text,
                        description: _todoDescriptionController.text,
                        category: _selectedValue.toString(),
                        isFinished: 0,
                        todoDate: _todoDateController.text));
                    print(result);
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:app_todo/models/category.dart';

import 'package:app_todo/service/category_service.dart';
import 'package:app_todo/screen/categories_screen.dart';
import 'package:flutter/material.dart';

class CategoriesForm extends StatefulWidget {
  @override
  _CategoriesFormState createState() => _CategoriesFormState();
}

class _CategoriesFormState extends State<CategoriesForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
          color: Colors.red,
        ),
        FlatButton(
          onPressed: () async {
            var result = await CategoryService().saveCategory(Category(
                description: _descriptionController.text,
                name: _nameController.text));
            print(result.toString());
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CategoriesScreen()));
          },
          child: Text('Save'),
          color: Colors.blue,
        )
      ],
      title: Text('Categories Form'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                  labelText: 'Categorise', hintText: 'Write a categorise'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                  labelText: 'Description', hintText: 'Write a description'),
            )
          ],
        ),
      ),
    );
  }
}

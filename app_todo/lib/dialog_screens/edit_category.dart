import 'package:app_todo/models/category.dart';
import 'package:app_todo/screen/home_screen.dart';
import 'package:app_todo/service/category_service.dart';

import 'package:flutter/material.dart';

class EditCategory extends StatefulWidget {
  final id;

  EditCategory({Key key, @required this.id}) : super(key: key);

  @override
  _EditCategoryState createState() => _EditCategoryState(id);
}

class _EditCategoryState extends State<EditCategory> {
  var id;
  _EditCategoryState(this.id);
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  setData() async {
    print(id.toString());
    var data = await CategoryService().readCategoryById(id);
    _nameController.text = data[0]['name'];
    _descriptionController.text = data[0]['description'];
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

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
            // var result = await CategoryService().saveCategory(Category(
            //     description: _descriptionController.text,
            //     name: _nameController.text));
            // print(result.toString());
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (context) => HomeScreen()));
          },
          child: Text('Save'),
          color: Colors.blue,
        )
      ],
      title: Text('Edit Category'),
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

import 'package:app_todo/models/category.dart';
import 'package:app_todo/dialog_screens/categories_form.dart';
import 'package:app_todo/dialog_screens/edit_category.dart';
import 'package:app_todo/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_todo/service/category_service.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Category> _allCategories = List<Category>();
  _getData() async {
    var allData = await CategoryService().readCategory();
    for (var data in allData) {
      _allCategories.add(Category(
          name: data['name'],
          description: data['description'],
          id: data['id']));
    }
    setState(() {});
  }

  _deleteDialog(int index) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(actions: [
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
                color: Colors.blue,
              ),
              FlatButton(
                onPressed: () {
                  CategoryService().deleteCategory(_allCategories[index].id);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CategoriesScreen()));
                },
                child: Text('Delete'),
                color: Colors.red,
              )
            ], title: Text('Are you want to delete ?')));
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen()));
              setState(() {});
            },
          ),
          title: Text('TodoList'),
        ),
        body: Container(
          child: ListView.builder(
              itemCount: _allCategories.length,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 8.0),
                    child: Card(
                      elevation: 5.0,
                      child: ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            return showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) =>
                                    EditCategory(id: _allCategories[index].id));
                          },
                        ),
                        title: Text(_allCategories[index].name),
                        subtitle: Text(_allCategories[index].description),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              _deleteDialog(index);
                            });
                          },
                        ),
                      ),
                    ),
                  )),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            return showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) => CategoriesForm());
          },
        ),
      ),
    );
  }
}

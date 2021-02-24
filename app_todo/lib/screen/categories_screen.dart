import 'package:app_todo/models/category.dart';
import 'package:app_todo/screen/categories_form.dart';
import 'package:app_todo/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_todo/service/category_service.dart';
import 'package:app_todo/models/category.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Category> _allCategories = List<Category>();
  getData() async {
    var allData = await CategoryService().readCategory();
    for (var data in allData) {
      _allCategories
          .add(Category(name: data['name'], description: data['description']));
    }
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
        title: Text('TodoList'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: _allCategories.length,
            itemBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0),
                  child: Card(
                    elevation: 5.0,
                    child: ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {},
                      ),
                      title: Text(_allCategories[index].name),
                      subtitle: Text(_allCategories[index].description),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {},
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
    );
  }
}

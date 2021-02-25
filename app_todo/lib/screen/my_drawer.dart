import 'package:flutter/material.dart';
import 'package:app_todo/screen/categories_screen.dart';
import 'package:app_todo/service/category_service.dart';
import 'package:app_todo/screen/home_screen.dart';
import 'package:app_todo/screen/todo_by_category.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  List<Widget> _allCategories = List<Widget>();
  _getData() async {
    var allData = await CategoryService().readCategory();
    for (var data in allData) {
      _allCategories.add(
        ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TodoByCategory(data['name'])));
          },
          title: Text(data['name']),
          leading: Icon(Icons.arrow_forward_ios_outlined),
        ),
      );
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
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.cyanAccent,
              ),
              accountName: Text('Divyesh'),
              accountEmail: Text('divyesh@gmail.com')),
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            title: Text('Home'),
            leading: Icon(Icons.home),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CategoriesScreen()));
            },
            title: Text('Categories'),
            leading: Icon(Icons.view_list),
          ),
          Divider(),
          Column(
            children: _allCategories,
          )
        ],
      ),
    );
  }
}

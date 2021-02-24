import 'package:flutter/material.dart';
import 'package:app_todo/screen/categories_screen.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
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
          )
        ],
      ),
    );
  }
}

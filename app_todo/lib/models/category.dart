class Category {
  int id;
  String name;
  String description;
  Category({this.description, this.name, this.id});

  categoryMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['description'] = description;
    return mapping;
  }
}

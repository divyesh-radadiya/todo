import 'package:moor_flutter/moor_flutter.dart';

part 'todos.g.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get category => text()();
  TextColumn get todoDate => text()();
  IntColumn get isFinished => integer()();
}

@UseMoor(tables: [Todos])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "db.sqlite", logStatements: true));

  int get schemaVersion => 1;

  Future<List<Todo>> getAllTodo() => select(todos).get();
  Future insertTodo(Todo todo) => into(todos).insert(todo);
}

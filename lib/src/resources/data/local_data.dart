import 'package:sqflite/sqflite.dart';

class LocalData {
  LocalData._();

  initLocalDB() async {
    final path = await getDatabasesPath();
    return openDatabase((path + 'messanger.db'),
        onCreate: (database, version) async {
      await database.execute('CREATE TABLE messanger(' ')');
    });
  }

  static final db = LocalData._();
}

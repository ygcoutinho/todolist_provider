import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:synchronized/synchronized.dart';

class SqliteConnectionFactory {
  static const _dbName = 'todo_list_database';
  static const _version = 1;
  static SqliteConnectionFactory? _instance;
  Database? _db;
  final _lock = Lock();

  SqliteConnectionFactory._();

  factory SqliteConnectionFactory() {
    _instance ??= SqliteConnectionFactory._();
    return _instance!;
  }

  Future<Database> openConnection() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, _dbName);

    if (_db == null) {
      await _lock.synchronized(() async {
        _db ??= await openDatabase(
          databasePath,
          version: _version,
          onConfigure: _onConfigure,
          onCreate: _onCreate,
          onUpgrade: _onUpgrade,
          onDowngrade: _onDowngrade,
        );
      });
    }
    return _db!;
  }

  void closeConnection() {
    _db?.close();
    _db == null;
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onCreate(Database db, int version) async {}
  Future<void> _onUpgrade(Database db, int oldVersion, int version) async {}
  Future<void> _onDowngrade(Database db, int oldVersion, int version) async {}
}
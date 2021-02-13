import 'package:queritel_demo_app/src/models/item.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String cartTable = 'cart_table';

  String colRefId = 'ref_id';
  String colCategory = 'category';
  String colBrand = 'brand';
  String colTitle = 'title';
  String colWeight = 'weight';
  String colWeightLabel = 'weight_label';
  String colPicUrl = 'pic_url';
  String colLiderPrice = 'lider_price';
  String colNewFileName = 'new_file_name';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {

    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'queritel_demo_app.db';

    // Open/create the database at a given path
    var queritelDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return queritelDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE '
        '$cartTable('
        '$colRefId INTEGER PRIMARY KEY AUTOINCREMENT, '
        '$colCategory TEXT, '
        '$colBrand TEXT, '
        '$colTitle TEXT, '
        '$colWeight TEXT, '
        '$colWeightLabel TEXT, '
        '$colPicUrl TEXT, '
        '$colLiderPrice TEXT, '
        '$colNewFileName TEXT)'
    );
  }

  // Fetch Operation: Get all todo objects from database
  Future<List<Map<String, dynamic>>> getItemMapList() async {
    Database db = await this.database;

    //var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
    var result = await db.query(
        cartTable,
        orderBy: '$colRefId ASC'
    );
    return result;
  }

  // Insert Operation: Insert a item object to database
  Future<int> insertItem(Item item) async {
    Database db = await this.database;
    var result = await db.insert(cartTable, item.toMap());
    return result;
  }

  /*// Insert Operation: Insert a item object to database
  Future<int> insertTodo(Todo todo) async {
    Database db = await this.database;
    var result = await db.insert(todoTable, todo.toMap());
    return result;
  }

  // Update Operation: Update a todo object and save it to database
  Future<int> updateTodo(Todo todo) async {
    var db = await this.database;
    var result = await db.update(todoTable, todo.toMap(), where: '$colId = ?', whereArgs: [todo.id]);
    return result;
  }


  // Delete Operation: Delete a todo object from database
  Future<int> deleteTodo(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $todoTable WHERE $colId = $id');
    return result;
  }

  // Get number of todo objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $todoTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }*/

  // Delete Operation: Delete a item object from database
  Future<int> deleteAllItems() async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $cartTable');
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'todo List' [ List<Todo> ]
  Future<List<Item>> getItemList() async {

    var itemMapList = await getItemMapList(); // Get 'Map List' from database
    int count = itemMapList.length;           // Count the number of map entries in db table

    List<Item> itemList = List<Item>();
    // For loop to create a 'todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      itemList.add(Item.fromMapObject(itemMapList[i]));
    }

    return itemList;
  }

  /*Future<List<Item>> getItemList() async {
    var todoMapList = await getTodoMapList(); // Get 'Map List' from database
    int count = todoMapList.length;         // Count the number of map entries in db table

    List<Todo> todoList = List<Todo>();
    // For loop to create a 'todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      todoList.add(Todo.fromMapObject(todoMapList[i]));
    }
    return todoList;
  }*/
}
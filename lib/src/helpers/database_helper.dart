import 'package:queritel_demo_app/src/models/item.dart';
import 'package:queritel_demo_app/src/models/order_items_table.dart';
import 'package:queritel_demo_app/src/models/order_table.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  //cart_table
  String cartTable = 'cart_table';
  String cartTableColRefId = 'ref_id';
  String cartTableColCategory = 'category';
  String cartTableColBrand = 'brand';
  String cartTableColTitle = 'title';
  String cartTableColWeight = 'weight';
  String cartTableColWeightLabel = 'weight_label';
  String cartTableColPicUrl = 'pic_url';
  String cartTableColLiderPrice = 'lider_price';
  String cartTableColNewFileName = 'new_file_name';

  //order_table
  String orderTable = 'order_table';
  String orderTableColId = 'id';
  String orderTableColPrice = 'price';
  String orderTableColDate = 'date';

  //order_items_table
  String orderItemsTable = 'order_items_table';
  String orderItemsTableColId = 'id';
  String orderItemsTableColOrderId = 'order_id';
  String orderItemsTableColItemName = 'item_name';
  String orderItemsTableColItemPrice = 'item_price';
  String orderItemsTableColItemCategory = 'item_category';
  String orderItemsTableColItemQuantity = 'item_quantity';
  String orderItemsTableColItemImgUrl = 'img_url';
  String orderItemsTableColItemBrand = 'item_brand';
  String orderItemsTableColItemWeight = 'weight';
  String orderItemsTableColItemWeightLabel = 'weight_label';

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
    var queritelDatabase = await openDatabase(path, version: 1, onCreate: _createDbs);
    return queritelDatabase;
  }

  void _createDbs(Database db, int newVersion) async {
    await db.execute('CREATE TABLE '
        '$cartTable('
        '$cartTableColRefId INTEGER PRIMARY KEY AUTOINCREMENT, '
        '$cartTableColCategory TEXT, '
        '$cartTableColBrand TEXT, '
        '$cartTableColTitle TEXT, '
        '$cartTableColWeight TEXT, '
        '$cartTableColWeightLabel TEXT, '
        '$cartTableColPicUrl TEXT, '
        '$cartTableColLiderPrice TEXT, '
        '$cartTableColNewFileName TEXT)'
    );

    await db.execute('CREATE TABLE '
        '$orderTable('
        '$orderTableColId INTEGER PRIMARY KEY AUTOINCREMENT, '
        '$orderTableColPrice TEXT, '
        '$orderTableColDate TEXT)'
    );

    await db.execute('CREATE TABLE '
        '$orderItemsTable('
        '$orderItemsTableColId INTEGER PRIMARY KEY AUTOINCREMENT, '
        '$orderItemsTableColOrderId INTEGER, '
        '$orderItemsTableColItemName TEXT, '
        '$orderItemsTableColItemPrice TEXT, '
        '$orderItemsTableColItemCategory TEXT, '
        '$orderItemsTableColItemQuantity TEXT, '
        '$orderItemsTableColItemImgUrl TEXT, '
        '$orderItemsTableColItemBrand TEXT, '
        '$orderItemsTableColItemWeight TEXT, '
        '$orderItemsTableColItemWeightLabel TEXT)'
    );

    DateTime now = new DateTime.now();
    OrderTable newOrderTable = OrderTable(null, "0", DateTime(now.year, now.month, now.day).toString());
    createOrderTable(newOrderTable);
  }

  // Fetch Operation: Get all todo objects from database
  Future<List<Map<String, dynamic>>> getItemMapList() async {
    Database db = await this.database;

    //var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
    var result = await db.query(
        cartTable,
        orderBy: '$cartTableColRefId ASC'
    );
    return result;
  }

  Future<int> removeFromCart(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $orderItemsTable WHERE $orderItemsTableColId = $id');
    return result;
  }

  Future<int> addToCart(Item item) async {
    final currentOrderTable = await getCurrentOrderTable();
    OrderItemsTable newOrderItemsTable = OrderItemsTable(null, currentOrderTable.id, "0", item.category, item.brand, item.title, item.weight, item.weightLabel, item.picUrl, item.liderPrice);

    Database db = await this.database;
    var result = await db.insert(orderItemsTable, newOrderItemsTable.toMap());
    return result;
  }

  // Insert Operation: Insert a item object to database
  Future<int> insertItem(Item item) async {
    Database db = await this.database;
    var result = await db.insert(cartTable, item.toMap());
    return result;
  }

  Future<int> createOrderTable(OrderTable newOrderTable) async {
    Database db = await this.database;
    var result = await db.insert(orderTable, newOrderTable.toMap());
    return result;
  }

  Future<OrderTable> getCurrentOrderTable() async {
    Database db = await this.database;

    //var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
    final result = await db.query(
        orderTable,
        orderBy: '$orderTableColDate ASC',
        limit: 1
    );

    print('getCurrentOrderTable result: ' + result.toString());

    if(result.length > 0) {
      return OrderTable.fromMapObject(result[0]);
    }

    return null;
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

  Future<List<Map<String, dynamic>>> getOrderItemMapList() async {
    Database db = await this.database;

    //var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
    var result = await db.query(
        orderItemsTable,
        orderBy: '$orderItemsTableColId ASC'
    );
    return result;
  }

  Future<List<OrderItemsTable>> getOrderItemsList() async {

    var orderItemMapList = await getOrderItemMapList(); // Get 'Map List' from database

    List<OrderItemsTable> orderItemsList = List<OrderItemsTable>();
    for (int i = 0; i < orderItemMapList.length; i++) {
      orderItemsList.add(OrderItemsTable.fromMapObject(orderItemMapList[i]));
    }

    return orderItemsList;
  }
}
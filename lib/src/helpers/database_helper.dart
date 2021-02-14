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

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
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
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'queritel_demo_app.db';

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

  Future<List<Map<String, dynamic>>> getItemMapList() async {
    Database db = await this.database;

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

  Future<int> getOrderItemsCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $orderItemsTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> deleteAllItems() async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $cartTable');
    return result;
  }

  Future<List<Item>> getItemList() async {

    var itemMapList = await getItemMapList();
    int count = itemMapList.length;

    List<Item> itemList = List<Item>();
    for (int i = 0; i < count; i++) {
      itemList.add(Item.fromMapObject(itemMapList[i]));
    }

    return itemList;
  }

  Future<List<Map<String, dynamic>>> getOrderItemMapList() async {
    Database db = await this.database;

    var result = await db.query(
        orderItemsTable,
        orderBy: '$orderItemsTableColId ASC'
    );
    return result;
  }

  Future<List<OrderItemsTable>> getOrderItemsList() async {

    var orderItemMapList = await getOrderItemMapList();

    List<OrderItemsTable> orderItemsList = List<OrderItemsTable>();
    for (int i = 0; i < orderItemMapList.length; i++) {
      orderItemsList.add(OrderItemsTable.fromMapObject(orderItemMapList[i]));
    }

    return orderItemsList;
  }
}
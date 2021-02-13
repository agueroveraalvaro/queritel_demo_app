import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queritel_demo_app/src/helpers/database_helper.dart';
import 'package:queritel_demo_app/src/models/order_items_table.dart';

class CartController extends GetxController
{
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<OrderItemsTable> orderItems = new List();

  @override
  void onInit() {
    super.onInit();

    _fetchOrderItems();
  }

  _fetchOrderItems() async {
    final list = await databaseHelper.getOrderItemsList();
    orderItems = list;
    update(['orderItems']);
  }

  removeOrderItem(int id) async {
    print('removeOrderItem: ' + id.toString());
    final result = await databaseHelper.removeFromCart(id);
    if(result != null)
      update(['orderItems']);
  }

  @override
  void onClose() {
    return super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
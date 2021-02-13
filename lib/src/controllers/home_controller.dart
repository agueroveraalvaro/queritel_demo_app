import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queritel_demo_app/src/api/items_api.dart';
import 'package:queritel_demo_app/src/helpers/database_helper.dart';
import 'package:queritel_demo_app/src/models/item.dart';

class HomeController extends GetxController
{
  DatabaseHelper databaseHelper = DatabaseHelper();

  List<Item> items = new List();
  
  @override
  void onInit() {
    super.onInit();

    _fetchItems();
  }

  _fetchItems() async {
    final response = await getItems();

    if(response.statusCode == 200) {

      print('response.statusCode: ' + response.statusCode.toString());

      final responseBody = jsonDecode(response.data.toString());

      print('responseBody item_list: ' + responseBody["item_list"].toString());

      List<dynamic> list = responseBody["item_list"] as List;

      items = list.map((result) => Item.fromMapObject(result)).toList();

      await databaseHelper.deleteAllItems();
      items.forEach((item) {
        databaseHelper.insertItem(item);
      });

      update(['items']);
    } else {
      Get.dialog(
          AlertDialog(
            title: Text('Alerta!'),
            content: Text('Ha ocurrido un error inesperado.'),
          )
      );
    }
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
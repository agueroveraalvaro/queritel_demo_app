import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queritel_demo_app/src/api/items_api.dart';
import 'package:queritel_demo_app/src/helpers/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class HomeController extends GetxController
{
  @override
  void onInit() {
    super.onInit();

    DatabaseHelper databaseHelper = DatabaseHelper();

    _fetchItems();
  }

  _fetchItems() async {
    final response = await getItems();

    if(response.statusCode == 200) {

      final responseBody = response.data;

      List<dynamic> list = responseBody["item_list"] as List;
      /*regions = list.map((result) => Region.fromJson(result)).toList();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      final communes = prefs.getStringList('comunas');

      if(communes != null) {
        for(int b=0; b<communes.length; b++) {
          for(int c=0; c<regions.length; c++) {
            for(int d=0; d<regions[c].communes.length; d++) {
              if(communes[b] == regions[c].communes[d].id.toString()) {
                regions[c].communes[d].value = true;
              }
            }
          }
        }
      }*/

      update(['regions']);
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
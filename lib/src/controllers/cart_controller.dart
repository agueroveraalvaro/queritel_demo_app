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
    final result = await databaseHelper.removeFromCart(id);
    if(result != null) {
      for(int b=0; b<orderItems.length; b++) {
        if(orderItems[b].id == id.toString())
          orderItems.removeAt(b);
      }
    }
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
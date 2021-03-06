import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:queritel_demo_app/src/controllers/cart_controller.dart';
import 'package:queritel_demo_app/src/components/order_item_card.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: CartController(),
      builder: (_) => Scaffold(
          appBar: AppBar(

          ),
          body: Container(
            height: double.maxFinite,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: GetBuilder<CartController>(
                    id: 'orderItems',
                    builder: (value) => ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: _.orderItems.length,
                      itemBuilder: (context, index) {
                        return OrderItemCard(
                          orderItem: _.orderItems[index],
                          pressFunction: () => null,
                          removeItemFunction: () {
                            _.removeOrderItem(int.parse(_.orderItems[index].id));
                          },
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                    flex: 0,
                    child: RaisedButton(
                      color: Colors.blueAccent,
                      child: Text(
                          'Checkout',
                          style: TextStyle(
                              color: Colors.white,
                            fontSize: 18
                          )
                      ),
                      onPressed: () {

                      },
                    )
                )
              ],
            ),
          )
      ),
    );
  }
}
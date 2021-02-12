import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queritel_demo_app/src/controllers/cart_controller.dart';
import 'package:queritel_demo_app/src/controllers/home_controller.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: CartController(),
      builder: (_) => Scaffold(
          appBar: AppBar(

          ),
          body: Stack(
            children: [

            ],
          ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queritel_demo_app/src/controllers/home_controller.dart';
import 'package:queritel_demo_app/src/pages/cart_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) => Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                icon: Icon(
                    Icons.shopping_cart
                ),
                tooltip: 'My cart!',
                onPressed: () {
                  Get.to(
                      CartPage()
                  );
                },
              )
            ],
          ),
          body: ,
      ),
    );
  }
}
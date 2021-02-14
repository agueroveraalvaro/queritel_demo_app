import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queritel_demo_app/src/components/item_card.dart';
import 'package:queritel_demo_app/src/controllers/home_controller.dart';
import 'package:queritel_demo_app/src/pages/cart_page.dart';
import 'package:queritel_demo_app/src/util/constants.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) => Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              Badge(
                badgeContent: GetBuilder<HomeController>(
                  id: 'orderItemsCount',
                  builder: (value) => Text(_.orderItemsCount.toString()),
                ),
                toAnimate: true,
                position: BadgePosition.topEnd(top: 0, end: 0),
                child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Get.to(
                        CartPage()
                    );
                  },
                ),
              ),
            ],
          ),
          backgroundColor: Colors.orangeAccent,
          body: GetBuilder<HomeController>(
            id: 'items',
            builder: (value) => Padding(
              padding: const EdgeInsets.all(defaultPadding - 8),
              child: GridView.builder(
                  itemCount: _.items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) => ItemCard(
                    item: _.items[index],
                    pressFunction: () => null,
                    addToCartFunction: () => _.addToCart(_.items[index]),
                  )),
            ),
          )
      ),
    );
  }
}
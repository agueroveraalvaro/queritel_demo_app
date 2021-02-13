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
          body: GetBuilder<HomeController>(
            id: 'items',
            builder: (value) => GridView.builder(
              itemCount: _.items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                //childAspectRatio: 1,
              ),
              itemBuilder: (BuildContext context, int index) {
                return _itemCard(_, index);
              },
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: _.fetchItems,
        ),
      ),
    );
  }

  Widget _itemCard(HomeController _, int index) {
    return InkWell(
      //splashColor: AppColors.primaryLight,
      onTap: () {

      },
      child: Container(
        color: Colors.orange,
        height: double.maxFinite,
        //margin: EdgeInsets.all(6),
        child: Column(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              //height: 200,
              color: Colors.blue,
              child: Image.network(
                _.items[index].picUrl,
                fit: BoxFit.contain,
                loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null ?
                      loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                          : null,
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black)
                  ),
                  color: Colors.white,
                  textColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  onPressed: () {},
                  child: Text(
                    _.items[index].weight,
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)
                  ),
                  color: Colors.white,
                  textColor: Colors.red,
                  padding: EdgeInsets.all(8.0),
                  onPressed: () {},
                  child: Text(
                    "Add to Cart".toUpperCase(),
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:queritel_demo_app/src/models/order_items_table.dart';
import 'package:queritel_demo_app/src/util/constants.dart';

class OrderItemCard extends StatelessWidget {

  final OrderItemsTable orderItem;
  final Function pressFunction;
  final Function removeItemFunction;

  const OrderItemCard({
    Key key,
    this.orderItem,
    this.pressFunction,
    this.removeItemFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pressFunction,
      child: Container(
        height: 140,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(defaultBorderCircular),
        ),
        margin: EdgeInsets.all(defaultPadding - 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 90,
                    child: Row(
                      children: [
                        //IMAGE
                        Container(
                          padding: EdgeInsets.all(defaultPadding),
                          margin: EdgeInsets.all(6),
                          height: 90,
                          width: 90,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(defaultBorderCircular),
                          ),
                          child: Hero(
                            tag: orderItem.picUrl,
                            child: Image.network(
                              orderItem.picUrl,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null)
                                  return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null ?
                                      loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                          :
                                      CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange))
                                  ),
                                );
                              },
                              errorBuilder: (context, url, error) => Icon(Icons.error, color: Colors.orange),
                            ),
                          ),
                        ),
                        //INFO
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: defaultPadding / 4),
                              child: Text(
                                orderItem.title,
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  orderItem.category + ' - ',
                                ),
                                Text(
                                  orderItem.weight + ' - ',
                                ),
                                Text(
                                  orderItem.liderPrice,
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  //BUTTONS
                  Row(
                    children: [
                      SizedBox(width: 8),
                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)
                        ),
                        color: Colors.white,
                        textColor: Colors.red,
                        padding: EdgeInsets.all(2),
                        onPressed: removeItemFunction,
                        child: Text(
                          "Remove".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black)
                        ),
                        color: Colors.white60,
                        textColor: Colors.black,
                        padding: EdgeInsets.all(2),
                        onPressed: () {},
                        child: Text(
                          orderItem.quantity,
                          style: TextStyle(
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
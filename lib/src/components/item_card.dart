import 'package:flutter/material.dart';
import 'package:queritel_demo_app/src/models/item.dart';
import 'package:queritel_demo_app/src/util/constants.dart';

class ItemCard extends StatelessWidget {

  final Item item;
  final Function press;

  const ItemCard({
    Key key,
    this.item,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(defaultBorderCircular),
        ),
        margin: EdgeInsets.all(1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(defaultPadding),
                margin: EdgeInsets.all(6),
                // For  demo we use fixed height and width
                // Now we dont need them
                // height: 180,
                // width: 160,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(defaultBorderCircular),
                ),
                child: Hero(
                  tag: item.picUrl,
                  child: Image.network(
                    item.picUrl,
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
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
                    item.weight,
                    style: TextStyle(
                      fontSize: 10.0,
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
                  padding: EdgeInsets.all(2),
                  onPressed: () {},
                  child: Text(
                    "Add to Cart".toUpperCase(),
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.all(6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: defaultPadding / 4),
                    child: Text(
                      // products is out demo list
                      item.title,
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                  Text(
                    "\$${item.liderPrice}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    item.category,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
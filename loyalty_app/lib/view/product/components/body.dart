import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loyalty_app/models/product_model.dart';
import 'package:loyalty_app/view/product/product_detail_screen.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return productInfo(products[index]);
      },
    );
  }

  Widget productInfo(ProductModel product) {
    var name = product.productName;
    var sku = product.productSku;
    var price = product.price;
    var purchaseDate = product.purchaseDate;

    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(14),
      ),
      margin: EdgeInsets.all(5.0),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Card tapped.');
        },
        child: Container(
          width: 300,
          height: 150,
          padding: EdgeInsets.fromLTRB(0, 20, 10, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Image(
                  image: AssetImage(product.image),
                ),
                title: Text(name),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Ngày mua"),
                    Text(DateFormat("dd-MM-yyyy").format(purchaseDate))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('Chi tiết'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProductDetailScreen(product);
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:appfood/utils/white_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/product.dart';
import '../../../style.dart';

class Products extends StatelessWidget {
  final List<Product> products;

  const Products({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: renderProduct(),
    );
  }

  List<ProductComponent> renderProduct() {
    return products.map((e) => ProductComponent(product: e)).toList();
  }
}

class ProductComponent extends StatelessWidget {
  final Product product;
  const ProductComponent({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('/itemDetail', arguments: product);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image.network(
                "http://" +
                    urlServer +
                    "/" +
                    product.image
                        .replaceAllMapped(RegExp(r'\\'), (match) => '/'),
                fit: BoxFit.fill,
              ),
            ),
            Text((() {
              var x = product.title;
              if (x.length >= 14) {
                return x.substring(0, 13) + "...";
              }
              return x;
            })(),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: black,
                )),
            const WhiteBox(5),
            RichText(
              text: TextSpan(
                  text: "\$ ",
                  style: const TextStyle(
                    fontSize: 19,
                    color: dolar,
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: NumberFormat.decimalPattern().format(product.price),
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: black,
                      ),
                    )
                  ]),
            ),
            const WhiteBox(5),
          ],
        ),
      ),
    );
  }
}

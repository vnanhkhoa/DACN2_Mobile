import 'package:appfood/Screens/Home/components/categories.dart';
import 'package:appfood/Screens/Home/components/products.dart';
import 'package:appfood/services/api_service.dart';
import 'package:flutter/material.dart';

import '../../../models/product.dart';
import '../../../style.dart';
import 'header.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Header(),
          const Categories(),
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 10,bottom: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Popular',
                style: TextStyle(
                  color: black,
                  fontSize: 26,
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: ApiService().getProduct(),
              builder: (context, snapshots) {
                if (snapshots.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  var items = snapshots.data as List<Product>;
                  if (items.isEmpty) {
                    return const Center(
                      child: Text('Cannot load products list'),
                    );
                  } else {
                    return Products(products: items);
                  }
                }
              }),
          ),
        ],
      ),
    );
  }
}

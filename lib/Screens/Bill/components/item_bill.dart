import 'package:appfood/style.dart';
import 'package:flutter/material.dart';

class ItemBill extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final items;

  const ItemBill({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 10,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    child: SizedBox(
                        height: size.height * 0.14,
                        width: size.width * 0.2,
                        child: Image.network(
                          "http://$urlServer/" +
                              items[index].image.replaceAllMapped(
                                  RegExp(r'\\'), (match) => '/'),
                          fit: BoxFit.cover,
                        )
                      ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  items[index].title,
                                  style: const TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "\$ " + items[index].price.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child:
                              Text("Qty: ${items[index].quantity.toString()}"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:appfood/style.dart';
import 'package:appfood/models/cart_model.dart';
import 'package:intl/intl.dart';

class CartDialogCard extends StatelessWidget {
  final CartItem data;
  final VoidCallback plusQty;
  final VoidCallback subQty;
  const CartDialogCard({
    Key? key,
    required this.data,
    required this.plusQty,
    required this.subQty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)
        )
      ),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      elevation: 5,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Image.network(
              "http://" +
                  urlServer +
                  "/" +
                  data.image.replaceAllMapped(RegExp(r'\\'), (match) => '/'),
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: size.width * 0.05,
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.title,
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold, color: lightGray),
                  ),
                  RichText(
                    text: TextSpan(
                        text: "\$ ",
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primarycolor),
                        children: [
                          TextSpan(
                              text: data.price.toString(),
                              style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: black))
                        ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: size.width*0.3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: subQty,
                          child: const Icon(
                            Icons.remove,
                            size: 20,
                          ),
                        ),
                        Text(
                          NumberFormat.decimalPattern().format(data.quantity),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        GestureDetector(
                          onTap: plusQty,
                          child: const Icon(Icons.add, size: 20),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../components/cart_dialog.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.shopping_cart),
      backgroundColor: Colors.green,
      onPressed: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            builder: (context) => Container(
                height: MediaQuery.of(context).size.height * 0.9,
                padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                child: const CartDialog()));
      },
    );
  }
}

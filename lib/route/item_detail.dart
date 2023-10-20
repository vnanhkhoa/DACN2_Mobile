import 'package:appfood/utils/white_box.dart';
import 'package:flutter/material.dart';
import 'package:appfood/models/cart_model.dart';
import 'package:appfood/models/product.dart';
import 'package:appfood/services/preferences_service.dart';
import 'package:appfood/style.dart';
import 'package:intl/intl.dart';

class ItemDetail extends StatefulWidget {
  final Product item;
  const ItemDetail({Key? key, required this.item}) : super(key: key);

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  int index = 0;
  final _preferencesService = PreferencesService();
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: black,
          ),
          title: Text(
            widget.item.title,
            style: const TextStyle(
              color: black,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
          automaticallyImplyLeading: true,
          centerTitle: true,
          backgroundColor: yellow,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: size.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.fill,
              )),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 250,
                        height: 250,
                        child: Image.network(
                          "http://" +
                              urlServer +
                              "/" +
                              widget.item.image.replaceAllMapped(
                                  RegExp(r'\\'), (match) => '/'),
                        )),
                    const WhiteBox(10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        color: primaryColor,
                        width: 180,
                        height: 46,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => setState(() {
                                if (_quantity != 1) {
                                  _quantity -= 1;
                                }
                              }),
                              child: const Icon(
                                Icons.remove,
                                color: white,
                                size: 16,
                              ),
                            ),
                            Text(
                              _quantity.toString(),
                              style: const TextStyle(
                                color: white,
                                fontSize: 26,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => setState(() {
                                _quantity += 1;
                              }),
                              child: const Icon(
                                Icons.add,
                                color: white,
                                size: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: "\$ ",
                                style: const TextStyle(
                                    color: primaryColor, fontSize: 30),
                                children: [
                                  TextSpan(
                                    text: NumberFormat.decimalPattern()
                                        .format(widget.item.price),
                                    style: const TextStyle(
                                      color: black,
                                      fontSize: 30,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          iconScore("4.8", "star.png", Colors.yellow),
                          iconScore("150 Kcal", "fire.png", Colors.orange[900]),
                          iconScore("10 - 15 min", "clock.png", primaryColor)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RichText(
                            maxLines: 6,
                            softWrap: true,
                            text: TextSpan(
                              text: widget.item.description,
                              style: const TextStyle(
                                fontSize: 16,
                                color: lightGray,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          maximumSize: const Size(250.0, 54.0),
                          backgroundColor: primaryColor,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)))),
                      onPressed: () {
                        CartItem cartItem = CartItem(
                            widget.item.id,
                            widget.item.title,
                            widget.item.image,
                            widget.item.description,
                            widget.item.price,
                            _quantity);
                        _saveSettings(cartItem);
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Add To Cart",
                              style: TextStyle(fontSize: 16, color: white),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.add_shopping_cart_rounded,
                              size: 24,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void _saveSettings(CartItem cartItem) {
    try {
      String id = cartItem.id;
      String title = cartItem.title;
      String image = cartItem.image;
      String description = cartItem.description;
      int quantity = cartItem.quantity;
      int price = cartItem.price;
      final newSettings =
          CartItem(id, title, image, description, price, quantity);

      _preferencesService.addSettings(newSettings);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Add product to cart success"),
      ));
      Navigator.of(context).pop();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}

Widget iconScore(score, icon, color) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      ImageIcon(
        AssetImage("assets/images/$icon"),
        size: 16,
        color: color,
      ),
      const SizedBox(
        width: 5,
      ),
      Text(
        score,
        style: const TextStyle(fontSize: 16),
      )
    ],
  );
}

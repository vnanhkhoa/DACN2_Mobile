import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:appfood/components/cart_dialog_card.dart';
import 'package:appfood/components/cart_info_cart.dart';
import 'package:appfood/components/rounded_button.dart';
import 'package:appfood/models/bill_model.dart';
import 'package:appfood/models/cart_model.dart';
import 'package:appfood/services/preferences_service.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:appfood/style.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../utils/real_time_socket.dart';

class CartDialog extends StatefulWidget {
  const CartDialog({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _CartDialogState createState() => _CartDialogState();
}

class _CartDialogState extends State<CartDialog> {
  final _preferencesService = PreferencesService();
  IO.Socket? socket;
  List<CartItem> data = [];

  @override
  void initState() {
    super.initState();
    _populateItem();
  }

  void _populateItem() async {
    var cart = await _preferencesService.getSettings();
    setState(() {
      data = cart;
    });
  }

  @override
  Widget build(BuildContext context) {
    RealTimeSocket realTimeSocket = Provider.of<RealTimeSocket>(context);
    if (!realTimeSocket.isConnected()) {
      realTimeSocket.initSocket();
    }
    socket = realTimeSocket.getSocket();
    int total = 0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            "Cart",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: lightGray, fontSize: 34),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const CartInfoCard(),
        const SizedBox(
          height: 8,
        ),
        const CartInfoCard(
          icon: Icons.location_on_sharp,
          color: lightGray,
          text: "13 St Marks street",
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          "Order",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: lightGray, fontSize: 34),
        ),
        const SizedBox(
          height: 8,
        ),
        Expanded(
            flex: 6,
            child: (() {
              if (data.isEmpty) {
                return const Center(
                    child: Text(
                  "Your Cart Is Empty!",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: lightGray),
                ));
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) {
                          setState(() {
                            _preferencesService.removeItemSettings(data[index]);
                            data.removeAt(index);
                          });
                        },
                        background: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          color: Colors.red,
                          child: const Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: white,
                                ),
                                Text(
                                  "Delete",
                                  style: TextStyle(color: white, fontSize: 18),
                                )
                              ],
                            ),
                          ),
                        ),
                        child: CartDialogCard(
                          data: data[index],
                          plusQty: () {
                            setState(() {
                              data[index].quantity++;
                            });
                          },
                          subQty: () {
                            setState(() {
                              data[index].quantity--;
                              if (data[index].quantity == 0) {
                                _preferencesService
                                    .removeItemSettings(data[index]);
                                data.removeAt(index);
                              }
                            });
                          },
                        ),
                      );
                    });
              }
            }())),
        const SizedBox(
          height: 8,
        ),
        Expanded(
            flex: 2,
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Tổng Cộng",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: dolar,
                            fontSize: 20),
                      ),
                      RichText(
                        text: TextSpan(
                            text: () {
                              for (int i = 0; i < data.length; i++) {
                                total =
                                    total + data[i].price * data[i].quantity;
                              }
                              return NumberFormat.decimalPattern()
                                  .format(total);
                            }(),
                            style: const TextStyle(
                              fontSize: 20,
                              color: dolar,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              WidgetSpan(
                                child: Transform.translate(
                                  offset: const Offset(0.0, -7.0),
                                  child: const Text(
                                    ' đ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: dolar,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ]),
                RoundedButton(
                  text: "Thanh Toán",
                  press: () {
                    postData(context);
                  },
                  color: Colors.yellow,
                )
              ],
            ))
      ],
    );
  }

  Future postData(BuildContext context) async {
    final _preferences = PreferencesService();
    List<CartItem> data = await _preferences.getSettings();
    List<Miniproduct> products = [];
    List<String> ids = [];
    int total = 0;
    if (data.isNotEmpty) {
      for (var i = 0; i < data.length; i++) {
        ids.add(data[i].id);
        products.add(Miniproduct(
            productId: data[i].id,
            quantity: data[i].quantity,
            price: data[i].price));
        total = total + data[i].price * data[i].quantity;
      }
      final Set token = await _preferences.getToken();
      final Bill bill = Bill(
          customerId: token.elementAt(1), products: products, total: total);
      List<Bill> list = [bill];
      // ignore: unrelated_type_equality_checks
      if (token != "") {
        final Uri apiURL = Uri.http(urlServer, "api/bill");
        final response = await http.post(apiURL,
            headers: {
              "Content-Type": "application/json",
              HttpHeaders.authorizationHeader: "Bearer " + token.elementAt(0)
            },
            body: Bill.encode(list).substring(1, Bill.encode(list).length - 1));
        final String responseString = response.body;
        Map result = jsonDecode(responseString);

        if (result["success"]) _preferences.removeCart();

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(result["message"]),
        ));
        socket!.emit('pay', jsonEncode(ids));
        Navigator.pop(context);
      } else {
        Navigator.of(context).pushNamed("/login");
      }
    }
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../models/bill_history_model.dart';
import '../models/product.dart';
import 'package:http/http.dart' as http;
import './preferences_service.dart';
import '../style.dart';

class ApiService {
  Future<List<Product>> getProduct() async {
    List<Product> products = [];
    Set set = await PreferencesService().getToken();
    try {
      final response = await http.get(Uri.http(urlServer, 'api/products'),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${set.elementAt(0)}'
          });
      final jsonData = jsonDecode(response.body);
      if (jsonData['success']) {
        for (var u in jsonData['Products']) {
          Product product = Product(u['title'], u['description'], u['price'],
              u['image'], u['_id'], 0, '');
          products.add(product);
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return products;
  }

  Future getBills(BuildContext context) async {
    List<BillHistory> data = [];
    final _preferencesService = PreferencesService();
    var s = 'message';
    try {
      Set set = await _preferencesService.getToken();
      Map<String, dynamic> customerId = {"customerId": set.elementAt(1)};
      final response = await http.post(Uri.http(urlServer, 'api/bill/get'),
          headers: {
            "Content-Type": "application/json",
            HttpHeaders.authorizationHeader: 'Bearer ${set.elementAt(0)}'
          },
          body: jsonEncode(customerId));
      final jsonData = jsonDecode(response.body);
      if (jsonData['success']) {
        for (var x in jsonData['Bills']) {
          List<Product> products = [];
          for (var u in x['products']) {
            Product product = Product(
              u['product']['title'],
              u['product']['description'],
              u['product']['price'] as int,
              u['product']['image'],
              u['product']['_id'] as String,
              u['quantity'] as int,
              u['status'],
            );

            products.add(product);
          }
          BillHistory bill = BillHistory(
              date: x['date'] as String,
              id: x['_id'] as String,
              products: products,
              total: x['total'] as int,
              customerName: x['customer'],
              status: x['status']);
          data.add(bill);
        }
      } else {
        s = jsonData["message"];
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(s),
        ));
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return data;
  }
}

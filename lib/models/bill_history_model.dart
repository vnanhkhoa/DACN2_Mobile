import 'dart:convert';

import 'package:appfood/models/product.dart';

class BillHistory {
  final String id, date;
  final List<Product> products;
  final int total;
  final String customerName;
  bool isExpanded;
  final String status;

  BillHistory(
      {required this.date,
      required this.id,
      required this.products,
      required this.total,
      required this.customerName,
      this.isExpanded = false,
      required this.status});

  Map<String, dynamic> toJson() => {
        'date': date,
        'id': id,
        'products': products,
        'total': total,
        'customerId': customerName,
        'status': status
      };

  static Map<String, dynamic> toMap(BillHistory bill) => {
        'date': bill.date,
        'id': bill.id,
        'products': bill.products,
        'total': bill.total,
        'customerId': bill.customerName,
        'status': bill.status
      };
  static String encode(List<BillHistory> bills) => jsonEncode(
        bills
            .map<Map<String, dynamic>>((bill) => BillHistory.toMap(bill))
            .toList(),
      );
}

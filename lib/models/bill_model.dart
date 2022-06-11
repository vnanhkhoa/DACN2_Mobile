import 'dart:convert';

class Bill {
  final List<Miniproduct> products;
  final int total;
  final String customerId;

  Bill({required this.products, required this.total, required this.customerId});

  Map<String, dynamic> toJson() => {
        'products': products,
        'total': total,
        'customerId': customerId,
      };

  static Map<String, dynamic> toMap(Bill bill) => {
        'products': bill.products,
        'total': bill.total,
        'customerId': bill.customerId,
      };
  static String encode(List<Bill> bills) => jsonEncode(
        bills.map<Map<String, dynamic>>((bill) => Bill.toMap(bill)).toList(),
      );
}

class Miniproduct {
  final String productId;
  final int quantity;
  final int price;

  Miniproduct({
    required this.productId,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'quantity': quantity,
        'price': price,
      };

  static Map<String, dynamic> toMap(Miniproduct product) => {
        'productId': product.productId,
        'quantity': product.quantity,
        'price': product.price,
      };
}

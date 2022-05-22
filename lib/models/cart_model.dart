import 'dart:convert';

class CartItem {
  final String title, description, image, id;
  int quantity;
  final int price;

  CartItem(
    this.id,
    this.title,
    this.image,
    this.description,
    this.price,
    this.quantity,
  );

  factory CartItem.fromJson(Map<String, dynamic> jsonData) {
    return CartItem(
      jsonData['id'],
      jsonData['title'],
      jsonData['image'],
      jsonData['description'],
      jsonData['price'],
      jsonData['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'image': image,
        'description': description,
        'price': price,
        'quantity': quantity,
      };

  static Map<String, dynamic> toMap(CartItem cardItem) => {
        'id': cardItem.id,
        'title': cardItem.title,
        'image': cardItem.image,
        'description': cardItem.description,
        'price': cardItem.price,
        'quantity': cardItem.quantity,
      };

  static String encode(List<CartItem> cardItems) => jsonEncode(
        cardItems
            .map<Map<String, dynamic>>((cardItem) => CartItem.toMap(cardItem))
            .toList(),
      );
  static List<CartItem> decode(String cardItems) =>
      (jsonDecode(cardItems) as List<dynamic>)
          .map<CartItem>((item) => CartItem.fromJson(item))
          .toList();
}

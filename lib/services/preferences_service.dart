import 'package:appfood/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  Future checkPreferences() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString("customerId") == null ? false : true;
  }

  Future saveCustomer(String token, String id) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString("Token", token);
    preferences.setString("customerId", id);
  }

  Future<Set> getToken() async {
    final preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString("Token");
    final String? customerId = preferences.getString("customerId");
    if (token == null) {
      // ignore: equal_elements_in_set
      return {"", ''};
    } else {
      Set set = {token, customerId};
      return set;
    }
  }

  Future removeToken() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.remove("Token");
    preferences.remove("customerId");
  }

  Future addSettings(CartItem cartItem) async {
    final preferences = await SharedPreferences.getInstance();
    final String? cartsString = preferences.getString("Cart_key");
    List<CartItem> listitem = [cartItem];
    if (cartsString != null) {
      final List<CartItem> cartitems = CartItem.decode(cartsString);
      bool _status = true;
      for (var i = 0; i < cartitems.length; i++) {
        if (cartitems[i].id == cartItem.id) {
          _status = false;
          cartitems[i].quantity += cartItem.quantity;
          await saveSettings(cartitems);
          // ignore: avoid_print
          print("Update Quantity \"" + cartitems[i].id + " Settings");
          break;
        }
      }
      if (_status) {
        cartitems.add(cartItem);
        await saveSettings(cartitems);
        // ignore: avoid_print
        print("+1 Settings");
      }
    } else {
      await saveSettings(listitem);
      // ignore: avoid_print
      print("Add New Settings");
    }
  }

  Future removeItemSettings(CartItem cartItem) async {
    final preferences = await SharedPreferences.getInstance();
    final String? cartsString = preferences.getString("Cart_key");
    if (cartsString == null) {
      return null;
    } else {
      final List<CartItem> cartitems = CartItem.decode(cartsString);
      cartitems.removeWhere((cartitem) => cartitem.id == cartItem.id);
      await saveSettings(cartitems);
    }
  }

  Future updateSettings(CartItem cartitem) async {
    final preferences = await SharedPreferences.getInstance();
    final String? cartsString = preferences.getString("Cart_key");
    if (cartsString == null) {
      return null;
    } else {
      final List<CartItem> cartitems = CartItem.decode(cartsString);
      for (var i = 0; i < cartitems.length; i++) {
        if (cartitems[i].id == cartitem.id) {
          cartitems[i].quantity = cartitem.quantity;
          break;
        }
      }
      await saveSettings(cartitems);
    }
  }

  Future saveSettings(List<CartItem> listitem) async {
    final preferences = await SharedPreferences.getInstance();
    final String encodedData = CartItem.encode(listitem);
    await preferences.setString("Cart_key", encodedData);
    // ignore: avoid_print
    print("Preferences Saved");
  }

  Future getSettings() async {
    late List<CartItem> cartitems;
    try {
      final preferences = await SharedPreferences.getInstance();
      final String? cartsString = preferences.getString("Cart_key");
      if (cartsString == null) return [];
      cartitems = CartItem.decode(cartsString);
      return cartitems;
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future removeCart() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.remove("Cart_key");
    // ignore: avoid_print
    print("Remove Settings");
  }
}

import 'package:appfood/Screens/Account/account_screen.dart';
import 'package:appfood/Screens/Bill/bill_screen.dart';
import 'package:appfood/Screens/Home/components/floatingbutton.dart';
import 'package:flutter/material.dart';
import 'package:appfood/Screens/Home/components/body.dart';
import 'package:provider/provider.dart';

import '../../services/preferences_service.dart';
import '../../utils/real_time_socket.dart';
import 'components/bottom_navigation.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int index = 0;
  final pre = PreferencesService();
  

  @override
  initState() {
    super.initState();
    checkTokenExist();
  }

  void checkTokenExist() async {
    final status = await pre.checkPreferences() as bool;
    if (!status) {
      Navigator.pushNamedAndRemoveUntil(context, "/welcome", (route) => false);
    }
  }

  

  final items = [
    const Icon(Icons.home),
    const Icon(Icons.content_paste),
    const Icon(Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      floatingActionButton: const FloatingButton(),
      bottomNavigationBar: BottomNavigation(
        onTap: (index) => setState(() {
          this.index = index;
        }),
        index: index,
        items: items,
      ),
      body: SafeArea(child: getBody()),
    );
  }

  Widget getBody() {
    if (index == 0) {
      return const SingleChildScrollView(child: Body());
    } else if (index == 1) {
      return const BillScreen();
    } else {
      return const AccountScreen();
    }
  }
}

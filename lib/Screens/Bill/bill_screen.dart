import 'package:flutter/material.dart';
import 'package:appfood/Screens/Bill/components/body.dart';

class BillScreen extends StatefulWidget {
  const BillScreen({Key? key}) : super(key: key);

  @override
  _BillScreenState createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Body();
  }
}

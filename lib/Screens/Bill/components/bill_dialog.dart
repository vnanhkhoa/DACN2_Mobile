import 'package:appfood/Screens/Bill/components/item_bill.dart';
import 'package:appfood/models/bill_history_model.dart';
import 'package:appfood/utils/white_box.dart';
import 'package:flutter/material.dart';

import 'bill_header.dart';

class BillDialog extends StatefulWidget {
  final BillHistory data;

  const BillDialog({Key? key, required this.data}) : super(key: key);

  @override
  _BillDialogState createState() => _BillDialogState();
}

class _BillDialogState extends State<BillDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BodyCardHeader(item: widget.data),
        const WhiteBox(15),
        Expanded(child: ItemBill(items: widget.data.products)),
        const WhiteBox(15),
      ],
    );
  }
}

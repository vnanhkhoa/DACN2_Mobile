import 'package:appfood/models/bill_history_model.dart';
import 'package:appfood/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BodyCardHeader extends StatelessWidget {
  const BodyCardHeader({
    Key? key,
    required this.item,
  }) : super(key: key);

  final BillHistory item;

  @override
  Widget build(BuildContext context) {
    DateTime parseDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(item.date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd/MM/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Order #${item.id}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: black,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                outputDate,
                style: const TextStyle(
                  color: lightGray,
                  fontWeight: FontWeight.bold,
                ),
              ),
              RichText(
                text: TextSpan(
                    text: "Total: " +
                        NumberFormat.decimalPattern().format(item.total),
                    style: const TextStyle(
                      color: black,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      WidgetSpan(
                        child: Transform.translate(
                          offset: const Offset(0.0, -7.0),
                          child: const Text(
                            ' đ',
                            style: TextStyle(
                              color: black,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ]),
            Container(
                padding: const EdgeInsets.all(6.0),
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      item.status,
                      style: TextStyle(
                          color: () {
                            if (item.status == "Accepted") {
                              return Colors.green;
                            } else if (item.status == "Rejected") {
                              return Colors.red;
                            }
                            return Colors.yellow;
                          }(),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )
                  ],
                ))
          ],
        ),
      ],
    );
  }
}

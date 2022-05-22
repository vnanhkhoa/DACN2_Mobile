import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String id;

  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
      ),
      body: Center(
        child: Text(id),
      ),
    );
  }
}
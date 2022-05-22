import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../../style.dart';

class BottomNavigation extends StatelessWidget {
  final ValueChanged<int> onTap;
  // ignore: prefer_typing_uninitialized_variables
  final items;
  // ignore: prefer_typing_uninitialized_variables
  final index;

  const BottomNavigation(
      {Key? key, required this.onTap, required this.items, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Theme(
      data: Theme.of(context)
          .copyWith(iconTheme: const IconThemeData(color: white)),
      child: CurvedNavigationBar(
        buttonBackgroundColor: purple,
        color: Colors.blueAccent,
        backgroundColor: transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        items: items,
        index: index,
        height: size.height * 0.08,
        onTap: onTap,
      ),
    );
  }
}

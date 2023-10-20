import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../style.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.175,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, bottom: 15, top: 15),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Categories',
                style: TextStyle(
                  color: black,
                  fontSize: 26,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Category(index: index);
                }),
          )
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final title;
  // ignore: prefer_typing_uninitialized_variables
  final image;
  // ignore: prefer_typing_uninitialized_variables
  final index;

  const Category({Key? key, this.image, this.title, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: (index == 0)
          ? const EdgeInsets.symmetric(horizontal: 20)
          : const EdgeInsets.only(right: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Container(
          color: primaryColor,
          child: IntrinsicHeight(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed('/detail', arguments: 'abcfdfs');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: white,
                      ),
                      child: FittedBox(
                        child: Image.asset('assets/images/Hambuger.png'),
                      ),
                    ),
                  ),
                  const IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: 15,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            'Burger',
                            style: TextStyle(
                              color: white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

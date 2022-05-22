import 'package:flutter/material.dart';

import '../../../style.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Banner.jpg'),
              fit: BoxFit.fill,
            )),
        width: double.infinity,
        height: size.height * 0.25,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: RichText(
                  text: const TextSpan(
                      text: 'The Fastest In Delivery ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Food',
                            style: TextStyle(
                              color: primarycolor,
                            ))
                      ])),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                primary: primarycolor,
              ),
              child: const Text(
                'Order Now',
                style: TextStyle(
                  color: white,
                ),
              ),
              onPressed: () {
                // getData();
              },
            ),
          ],
        ),
      ),
    );
  }

}
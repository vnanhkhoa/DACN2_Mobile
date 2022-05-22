import 'package:flutter/material.dart';
import 'package:appfood/Screens/Account/components/background.dart';
import 'package:appfood/components/account_button.dart';
import 'package:appfood/services/preferences_service.dart';
import 'package:appfood/style.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _preferences = PreferencesService();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Background(
          child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: white,
                  border: Border.all(color: borderColor),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: shadowColor,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    )
                  ]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular((size.height * 0.08) / 2),
                      child: SizedBox(
                        width: size.height * 0.08,
                        height: size.height * 0.08,
                        child: Image.asset(
                          "assets/images/woman.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.04,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Good Morning",
                          style: TextStyle(
                            color: lightGray,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Misuta No",
                          style: TextStyle(
                            color: black,
                            fontWeight: FontWeight.bold,
                            fontSize: size.height * 0.04,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: const [
                AccountInfoCard(
                    icon: Icons.alarm, color: Colors.yellow, text: "time"),
                AccountInfoCard(
                    icon: Icons.compare, color: purple, text: "total"),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AccountButton(
                      text: "Profile",
                      color: white,
                      textColor: accountButtonActive,
                      press: () {},
                      icon: Icons.people_alt_outlined),
                  AccountButton(
                      text: "Notifications",
                      color: white,
                      textColor: accountButtonActive,
                      press: () {},
                      icon: Icons.notifications_outlined),
                  AccountButton(
                      text: "Change Password",
                      color: white,
                      textColor: accountButtonActive,
                      press: () {
                        Navigator.of(context).pushNamed("/Changepassword");
                      },
                      icon: Icons.lock),
                  AccountButton(
                      text: "Sign Out",
                      color: accountButtonActive,
                      textColor: white,
                      press: () async {
                        await _preferences.removeToken();
                        Navigator.of(context).pushNamed("/welcome");
                      },
                      icon: Icons.logout),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class AccountInfoCard extends StatelessWidget {
  final String text;
  final Color color;
  final IconData icon;
  const AccountInfoCard(
      {Key? key, required this.icon, required this.color, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: white,
                  border: Border.all(color: borderColor),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: shadowColor,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    )
                  ]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular((size.height * 0.08) / 2),
                      child: Container(
                        color: color,
                        width: size.height * 0.08,
                        height: size.height * 0.08,
                        alignment: Alignment.center,
                        child: Icon(
                          icon,
                          size: 20,
                          color: white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.04,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                        fontSize: size.height * 0.04,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

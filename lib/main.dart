import 'package:appfood/routes/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'utils/real_time_socket.dart';

void main() => runApp(
  Provider(
    create: (_) => RealTimeSocket(),
    child: const MyApp(),
    )
  );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    RealTimeSocket realTimeSocket = Provider.of<RealTimeSocket>(context);
    realTimeSocket.initSocket();
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

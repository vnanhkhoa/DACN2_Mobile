import 'package:appfood/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:appfood/style.dart';
import 'package:appfood/Screens/Bill/components/background.dart';
import 'package:appfood/models/bill_history_model.dart';
import 'package:provider/provider.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../utils/real_time_socket.dart';
import 'bill_dialog.dart';
import 'bill_header.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late IO.Socket socket;

  var i = 0;

  @override
  void initState() {
    super.initState();
  }

  Future initSocket(RealTimeSocket realTimeSocket) async {
    if (!realTimeSocket.isConnected()) {
      realTimeSocket.initSocket();
    }
    socket = realTimeSocket.getSocket();
    socket.on("reload", (data) {
      while (mounted) {
        setState(() {});
        break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    RealTimeSocket realTimeSocket = Provider.of<RealTimeSocket>(context);
    initSocket(realTimeSocket);
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: double.infinity,
            height: 50,
            child: Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              elevation: 10,
              color: green,
              child: Center(
                child: Text("Bills",
                    style: TextStyle(
                      color: white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              flex: 8,
              child: FutureBuilder(
                  future: ApiService().getBills(context),
                  builder: (context, snapshots) {
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      var items = snapshots.data as List<BillHistory>;
                      if (items.isEmpty) {
                        return const Center(child: Text("My Bills is empty"));
                      } else {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(30))),
                                      builder: (context) => Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.9,
                                          padding: const EdgeInsets.all(15),
                                          child:
                                              BillDialog(data: items[index])));
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(10),
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      BodyCardHeader(item: items[index]),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    }
                  })),
        ],
      ),
    );
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }
}

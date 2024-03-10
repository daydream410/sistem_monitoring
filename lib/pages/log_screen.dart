import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sistem_monitoring/routes/route_name.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/notif.dart';

class LogPage extends StatefulWidget {
  const LogPage({super.key});

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  var searchLog = "";
  var dataTimestamp;
  var index_value;

  @override
  void initState() {
    super.initState();
    getTotalData();
  }

  getTotalData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    index_value = sharedPreferences.getInt('totalData');
    print('bbbbbbbbbb' + index_value.toString());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var totalData = 0;

    var _numberToMonth = {
      1: "Janurai",
      2: "Februari",
      3: "Maret",
      4: "April",
      5: "Mei",
      6: "Juni",
      7: "Juli",
      8: "Agustus",
      9: "September",
      10: "Oktober",
      11: "November",
      12: "December",
    };

    Stream<QuerySnapshot<Map<String, dynamic>>> notificationStream =
        FirebaseFirestore.instance
            .collection('log')
            // .orderBy('tanggal', descending: true)
            .orderBy('statusperangkat')
            .startAt([searchLog]).endAt(["$searchLog\uf8ff"]).snapshots();
    notificationStream.listen(
      (event) {
        if (event.docs.isEmpty) {
          return;
        }
        totalData = event.docs.length;
        print(totalData);
        if (event.docs.length != index_value) {
          print('aaaaaaaaaaa');
          NotificationService.showSimpleNotification(
            title: 'Beep beeep!',
            body: 'Data Log Baru',
            payload: 'Manajemen Log',
          );
        }
      },
    );

    setTotalData() async {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setInt('totalData', totalData);

      print('total data ' + totalData.toString());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('LOG KEAMANAN'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            Center(
              child: Container(
                width: size.width * 0.8,
                height: size.height * 0.06,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                        offset: Offset(2.0, 2.0))
                  ],
                ),
                child: TextField(
                  // onChanged: (value) {
                  //   setState(() {
                  //     searchLog = value.toUpperCase();
                  //   });
                  // },
                  onSubmitted: (value) {
                    setState(() {
                      searchLog = value.toUpperCase();
                    });
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search_rounded),
                    border: OutlineInputBorder(),
                    hintText: 'Search',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: size.height * 0.70,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: StreamBuilder(
                  stream: notificationStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        setTotalData();
                        return ListView.separated(
                          padding: const EdgeInsets.all(16),
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            );
                          },
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> data =
                                snapshot.data?.docs[index].data()
                                    as Map<String, dynamic>;
                            Timestamp t = data['tanggal'] as Timestamp;
                            DateTime date = t.toDate();
                            return Card(
                              elevation: 5,
                              child: ListTile(
                                title: Text(
                                  '${_numberToMonth[date.month]} ${date.day} ${date.year} ${date.hour}:${date.minute}:${date.second}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(snapshot.data!.docs[index]
                                    ['statusperangkat']),
                                onTap: () {
                                  dataTimestamp = snapshot.data?.docs[index].id;
                                  print(dataTimestamp.toString());
                                  Get.toNamed(RouteName.detailLogPage,
                                      arguments: dataTimestamp);
                                },
                                trailing: IconButton(
                                  icon: const Icon(
                                      Icons.arrow_forward_ios_rounded),
                                  onPressed: () {},
                                  color: Colors.white,
                                ),
                                tileColor: snapshot.data!.docs[index]
                                            ['statusperangkat'] ==
                                        'AWAS'
                                    ? Colors.orange
                                    : Colors.red,
                                textColor: Colors.white,
                              ),
                            );
                          },
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }),
            )
          ],
        )),
      ),
    );
  }
}

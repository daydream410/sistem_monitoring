import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sistem_monitoring/controllers/controller.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var docId;
  int nilaiModem = 0;
  int nilaiDigitizer = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final myController = Get.put(Controller());
    bool modem;
    bool digitizer;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('SISTEM MONITORING KEAMANAN')),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('log_dasboard').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                docId = snapshot.data?.docs[0].id;
                return Column(
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      height: size.height * 0.20,
                      width: size.width * 1,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2.0,
                              offset: Offset(2.0, 2.0))
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                        color: HexColor('#11009E'),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'STATUS KEAMANAN',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              snapshot.data?.docs[0]['statusperangkat'],
                              style: (snapshot.data?.docs[0]
                                          ['statusperangkat'] ==
                                      'Aman')
                                  ? TextStyle(
                                      color: Colors.greenAccent.shade400,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    )
                                  : (snapshot.data?.docs[0]
                                              ['statusperangkat'] ==
                                          'Awas')
                                      ? TextStyle(
                                          color: Colors.orange.shade400,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                        )
                                      : TextStyle(
                                          color: Colors.red.shade400,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                        ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          height: size.height * 0.08,
                          width: size.width * 0.45,
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2.0,
                                  offset: Offset(2.0, 2.0))
                            ],
                            borderRadius: BorderRadius.circular(10.0),
                            color: HexColor('#4942E4'),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: Image.asset('images/pintu.jpg')),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      'Sensor Pintu',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  snapshot.data?.docs[0]['statuspintu'],
                                  style: snapshot.data?.docs[0]
                                              ['statuspintu'] ==
                                          'Terbuka'
                                      ? TextStyle(
                                          color: Colors.red.shade400,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        )
                                      : TextStyle(
                                          color: Colors.greenAccent.shade400,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          clipBehavior: Clip.hardEdge,
                          height: size.height * 0.08,
                          width: size.width * 0.45,
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2.0,
                                  offset: Offset(2.0, 2.0))
                            ],
                            borderRadius: BorderRadius.circular(10.0),
                            color: HexColor('#5C469C'),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: Image.asset('images/gerak.jpg')),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      'Sensor Gerak',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  snapshot.data?.docs[0]['statusgerak'],
                                  style: snapshot.data?.docs[0]
                                              ['statusgerak'] ==
                                          'Terdeteksi'
                                      ? TextStyle(
                                          color: Colors.red.shade400,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        )
                                      : TextStyle(
                                          color: Colors.greenAccent.shade400,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          height: size.height * 0.08,
                          width: size.width * 0.45,
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2.0,
                                  offset: Offset(2.0, 2.0))
                            ],
                            borderRadius: BorderRadius.circular(10.0),
                            color: HexColor('#146C94'),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: Image.asset('images/jarak.jpg')),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      'Sensor Jarak',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${snapshot.data?.docs[0]['jarak']} cm (${snapshot.data?.docs[0]['statusjarak']})',
                                  style: snapshot.data?.docs[0]['jarak'] > 100
                                      ? TextStyle(
                                          color: Colors.red.shade400,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        )
                                      : TextStyle(
                                          color: Colors.greenAccent.shade400,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          clipBehavior: Clip.hardEdge,
                          height: size.height * 0.08,
                          width: size.width * 0.45,
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2.0,
                                  offset: Offset(2.0, 2.0))
                            ],
                            borderRadius: BorderRadius.circular(10.0),
                            color: HexColor('#088395'),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: Image.asset('images/beban.png')),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      'Sensor Beban',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // ringan = merah, sedang = oren, berat = hijau
                                Text(
                                  '${snapshot.data?.docs[0]['beban']} kg (${snapshot.data?.docs[0]['statusbeban']})',
                                  style: (snapshot.data?.docs[0]
                                              ['statusbeban'] ==
                                          'Berat')
                                      ? TextStyle(
                                          color: Colors.greenAccent.shade400,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        )
                                      : (snapshot.data?.docs[0]
                                                  ['statusbeban'] ==
                                              'Sedang')
                                          ? TextStyle(
                                              color: Colors.orange.shade400,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            )
                                          : TextStyle(
                                              color: Colors.red.shade400,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.16,
                    ),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      height: size.height * 0.20,
                      width: size.width * 1,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2.0,
                              offset: Offset(2.0, 2.0))
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                        color: HexColor('#6096B4'),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'KENDALI PERANGKAT',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: size.height * 0.09,
                                  width: size.height * 0.20,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 2.0,
                                          offset: Offset(2.0, 2.0))
                                    ],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          height: 25,
                                          width: 25,
                                          child:
                                              Image.asset('images/modem.jpg')),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'Modem',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Switch(
                                          value: snapshot.data?.docs[0]
                                                      ['modem'] ==
                                                  1
                                              ? modem = true
                                              : modem = false,
                                          onChanged: (bool value) {
                                            if (snapshot.data?.docs[0]
                                                    ['modem'] ==
                                                1) {
                                              Get.defaultDialog(
                                                title: 'Turn Off Modem?',
                                                middleText: 'Are You Sure?',
                                                textConfirm: 'Yes',
                                                textCancel: 'No',
                                                confirmTextColor: Colors.white,
                                                onCancel: () {
                                                  Get.back();
                                                },
                                                onConfirm: () {
                                                  Get.back();
                                                  modem = false;
                                                  nilaiModem = 0;
                                                  _updateModem();
                                                  Get.snackbar(
                                                    'Success',
                                                    'Successfully Turn Off Modem',
                                                    backgroundColor: Colors.red,
                                                    colorText: Colors.white,
                                                    duration: const Duration(
                                                        seconds: 1),
                                                  );
                                                },
                                              );
                                            } else {
                                              Get.defaultDialog(
                                                title: 'Turn On Modem?',
                                                middleText: 'Are You Sure?',
                                                textConfirm: 'Yes',
                                                textCancel: 'No',
                                                confirmTextColor: Colors.white,
                                                onCancel: () {
                                                  Get.back();
                                                },
                                                onConfirm: () {
                                                  Get.back();
                                                  modem = true;
                                                  nilaiModem = 1;
                                                  _updateModem();
                                                  Get.snackbar(
                                                    'Success',
                                                    'Successfully Turn On Modem',
                                                    backgroundColor:
                                                        Colors.green,
                                                    colorText: Colors.white,
                                                    duration: const Duration(
                                                        seconds: 1),
                                                  );
                                                },
                                              );
                                            }
                                          }),
                                    ],
                                  )),
                                ),
                                Container(
                                  height: size.height * 0.09,
                                  width: size.height * 0.20,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 2.0,
                                          offset: Offset(2.0, 2.0))
                                    ],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          height: 25,
                                          width: 25,
                                          child: Image.asset(
                                              'images/digitizer.jpg')),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'Digitizer',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Switch(
                                        value: snapshot.data?.docs[0]
                                                    ['digitizer'] ==
                                                1
                                            ? digitizer = true
                                            : digitizer = false,
                                        onChanged: (bool value) {
                                          if (snapshot.data?.docs[0]
                                                  ['digitizer'] ==
                                              1) {
                                            Get.defaultDialog(
                                              title: 'Turn Off Digitizer?',
                                              middleText: 'Are You Sure?',
                                              textConfirm: 'Yes',
                                              textCancel: 'No',
                                              confirmTextColor: Colors.white,
                                              onCancel: () {
                                                Get.back();
                                              },
                                              onConfirm: () {
                                                Get.back();
                                                digitizer = false;
                                                nilaiDigitizer = 0;
                                                _updateDigitizer();
                                                Get.snackbar(
                                                  'Success',
                                                  'Successfully Turn Off Digitizer',
                                                  backgroundColor: Colors.red,
                                                  colorText: Colors.white,
                                                  duration: const Duration(
                                                      seconds: 1),
                                                );
                                              },
                                            );
                                          } else {
                                            Get.defaultDialog(
                                              title: 'Turn On Digitizer?',
                                              middleText: 'Are You Sure?',
                                              textConfirm: 'Yes',
                                              textCancel: 'No',
                                              confirmTextColor: Colors.white,
                                              onCancel: () {
                                                Get.back();
                                              },
                                              onConfirm: () {
                                                Get.back();
                                                digitizer = true;
                                                nilaiDigitizer = 1;
                                                _updateDigitizer();
                                                Get.snackbar(
                                                  'Success',
                                                  'Successfully Turn On Digitizer',
                                                  backgroundColor: Colors.green,
                                                  colorText: Colors.white,
                                                  duration: const Duration(
                                                      seconds: 1),
                                                );
                                              },
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            } else {
              return const Center(
                  child: Column(
                children: [
                  Text('Loading Data...'),
                  SizedBox(
                    height: 20,
                  ),
                  CircularProgressIndicator(),
                ],
              ));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  //update kendali perangkat ke firebase
  Future _updateModem() async {
    FirebaseFirestore.instance
        .collection('log_dasboard')
        .doc(docId)
        .update({'modem': nilaiModem});
  }

  Future _updateDigitizer() async {
    FirebaseFirestore.instance
        .collection('log_dasboard')
        .doc(docId)
        .update({'digitizer': nilaiDigitizer});
  }
}

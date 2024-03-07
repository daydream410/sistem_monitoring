import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sistem_monitoring/controllers/controller.dart';

class DetailLog extends StatefulWidget {
  const DetailLog({super.key});

  @override
  State<DetailLog> createState() => _DetailLogState();
}

class _DetailLogState extends State<DetailLog> {
  var dataTimestamp = Get.arguments.toString();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final myController = Get.put(Controller());
    bool modem;
    bool digitizer;
    var urlimage;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('SISTEM MONITORING KEAMANAN')),
        actions: [
          IconButton(
            onPressed: () {
              print(dataTimestamp);
            },
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('log')
                .doc(dataTimestamp)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  if (snapshot.data!['foto'] != '') {
                    urlimage = false;
                  } else {
                    urlimage = true;
                  }
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
                              // Text(snapshot.data!['statusperangkat'].toString()),
                              Text(
                                snapshot.data!['statusperangkat'],
                                style:
                                    snapshot.data!['statusperangkat'] == 'AWAS'
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
                                          child:
                                              Image.asset('images/pintu.jpg')),
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
                                    snapshot.data!['statuspintu'],
                                    style: snapshot.data!['statuspintu'] ==
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
                                          child:
                                              Image.asset('images/gerak.jpg')),
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
                                    snapshot.data!['statusgerak'],
                                    style: snapshot.data!['statusgerak'] ==
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
                                          child:
                                              Image.asset('images/jarak.jpg')),
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
                                    '${snapshot.data!['jarak']} cm (${snapshot.data!['statusjarak']})',
                                    style: snapshot.data!['jarak'] > 100
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
                                          child:
                                              Image.asset('images/beban.png')),
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
                                  Text(
                                    '${snapshot.data!['beban']} kg (${snapshot.data!['statusbeban']})',
                                    style: snapshot.data!['statusbeban'] ==
                                            'Berat'
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
                      Container(
                        clipBehavior: Clip.hardEdge,
                        height: size.height * 0.45,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'FOTO RUANGAN',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: size.height * 0.35,
                                width: size.width * 0.8,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: urlimage == true
                                            ? NetworkImage(
                                                'https://cdn.discordapp.com/attachments/993306743557849139/1214937279022374982/no_foto.png?ex=65faed83&is=65e87883&hm=67f9ad6c8a340e01733dfd1a8493f1e074a6592709655e1925f43311d663731b&')
                                            : NetworkImage(
                                                snapshot.data!['foto']),
                                        fit: BoxFit.cover)),
                                // child: CircleAvatar(
                                //   radius: 10,
                                //   backgroundImage: urlimage
                                //       ? NetworkImage(
                                //           'https://cdn.discordapp.com/attachments/993306743557849139/1214937279022374982/no_foto.png?ex=65faed83&is=65e87883&hm=67f9ad6c8a340e01733dfd1a8493f1e074a6592709655e1925f43311d663731b&')
                                //       : NetworkImage(snapshot.data!['foto'])
                                //           as ImageProvider<Object>,
                                // ),
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
      ),
    );
  }
}

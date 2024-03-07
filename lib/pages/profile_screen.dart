import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sistem_monitoring/controllers/controller.dart';
import 'package:sistem_monitoring/routes/route_name.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  static var docId;
  @override
  Widget build(BuildContext context) {
    final myController = Get.put(Controller());
    var size = MediaQuery.of(context).size;
    String? userEmail = (FirebaseAuth.instance.currentUser?.email);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PROFILE'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Get.offAllNamed(RouteName.loginPage);
              Get.snackbar(
                'Success',
                'Successfully Logout',
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .where('email', isEqualTo: userEmail)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.hasData) {
                          myController.doccId.value = snapshot.data!.docs[0].id;
                          return Column(
                            children: [
                              Obx(() => CircleAvatar(
                                    radius: 80,
                                    backgroundImage: myController
                                            .imagePath.isNotEmpty
                                        ? FileImage(File(
                                            myController.imagePath.toString()))
                                        : NetworkImage(
                                                snapshot.data?.docs[0]['image'])
                                            as ImageProvider<Object>,
                                  )),
                              TextButton(
                                onPressed: () async {
                                  myController.getImage();
                                },
                                child: const Text(
                                  'Edit Photo Profile',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Container(
                                height: size.height * 0.07,
                                width: size.width * 0.8,
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.person_rounded),
                                    const SizedBox(width: 10),
                                    Text(
                                      '${snapshot.data?.docs[0]['nama']}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: size.height * 0.07,
                                width: size.width * 0.8,
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.email_rounded),
                                    const SizedBox(width: 10),
                                    Text(
                                      '${snapshot.data?.docs[0]['email']}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: size.height * 0.07,
                                width: size.width * 0.8,
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.phone_android_rounded),
                                    const SizedBox(width: 10),
                                    Text(
                                      '${snapshot.data?.docs[0]['phone']}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: size.height * 0.07,
                                width: size.width * 0.8,
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.work_rounded),
                                    const SizedBox(width: 10),
                                    Text(
                                      '${snapshot.data?.docs[0]['office']}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.hasError.toString()),
                          );
                        } else {
                          return const Center(
                              child: Text(
                            "No Data",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ));
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    myController.changePw();
                  },
                  child: Obx(
                    () => Visibility(
                      visible: myController.chPw.value,
                      replacement: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height * 0.05,
                            width: size.width * 0.6,
                            child: TextField(
                              controller: myController.changePassword.value,
                              obscureText: myController.pressedBool.isTrue,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    myController.changeStatus();
                                  },
                                  icon: myController.pressedBool.isTrue
                                      ? const Icon(
                                          Icons.visibility_off,
                                          size: 20,
                                        )
                                      : const Icon(
                                          Icons.visibility,
                                          size: 20,
                                        ),
                                ),
                                border: const OutlineInputBorder(),
                                labelText: 'Change Password',
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  myController.gantiPassword();
                                },
                                icon: const Icon(
                                  Icons.check_box_rounded,
                                  color: Colors.green,
                                  size: 35,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  myController.changePw();
                                  myController.changePassword.value.clear();
                                },
                                icon: const Icon(
                                  Icons.cancel_rounded,
                                  color: Colors.red,
                                  size: 35,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      child: Container(
                        height: size.height * 0.07,
                        width: size.width * 0.8,
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
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.password_rounded),
                            SizedBox(width: 10),
                            Text(
                              'Change Password',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.keyboard_arrow_right_outlined,
                              size: 35,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

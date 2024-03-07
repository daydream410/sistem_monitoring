// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers, unrelated_type_equality_checks

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:sistem_monitoring/controllers/firebase_auth.dart';
import '../routes/route_name.dart';

class Controller extends GetxController {
  //-------------------------login page
  final email = TextEditingController().obs;
  final password = TextEditingController().obs;

  RxBool pressedBool = true.obs;
  void changeStatus() {
    pressedBool.toggle();
  }

  final FirebaseAuthService _auth = FirebaseAuthService();
  var isSigning = false.obs;
  void signIn() async {
    isSigning.toggle();
    String emaill = email.value.text;
    String pasword = password.value.text;

    User? user = await _auth.signInWithEmailAndPassword(emaill, pasword);

    isSigning.toggle();

    if (user != null) {
      Get.snackbar(
        'Success',
        'Successfully Login',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offNamed(RouteName.navbarPage);
      email.value.clear();
      password.value.clear();
    }
  }

  //-------------------------dasboard page

  RxInt modem = 0.obs;
  RxInt digitizer = 0.obs;

  var light1 = true.obs;
  var light2 = true.obs;

  void toggle1() {
    if (modem == 0) {
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
          light1.toggle();
          modem.value = 1;
        },
      );
    } else {
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
          light1.toggle();
          modem.value = 0;
        },
      );
    }
  }

  void toggle2() {
    if (digitizer == 0) {
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
          light2.toggle();
          digitizer.value = 1;
        },
      );
    } else {
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
          light2.toggle();
          digitizer.value = 0;
        },
      );
    }
  }

  //------------------------profile page
  RxString imagePath = ''.obs;
  UploadTask? uploadTask;

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath.value = image.path.toString();
      uploadImage();
      print('uploaded');
    }
    print('Image Path = ${imagePath.value}');
  }

  RxString doccId = ''.obs;
  RxString urlDownload = ''.obs;
  Future uploadImage() async {
    File file2 = File(imagePath.value);
    String basename2 = basename(file2.path);
    final file = File(imagePath.value);
    String path = 'files/$basename2';
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() {});
    urlDownload.value = await snapshot.ref.getDownloadURL();
    print('Download Link: $urlDownload');
    await FirebaseFirestore.instance
        .collection('users')
        .doc(doccId.value.toString())
        .update({'image': urlDownload.value.toString()});
  }

  final changePassword = TextEditingController().obs;
  var chPw = true.obs;
  void changePw() {
    chPw.toggle();
  }

// final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  void gantiPassword() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    Get.defaultDialog(
      title: 'Change Password Confirmation',
      middleText: 'Are You Sure?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: Colors.white,
      onCancel: () {
        Get.back();
        changePw();
        changePassword.value.clear();
      },
      onConfirm: () {
        Get.back();
        currentUser?.updatePassword(changePassword.value.text).then((value) {
          Get.snackbar(
            'Success',
            'Successfully Change Your Password',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          changePw();
          changePassword.value.clear();
        }).catchError((err) {
          print(err);
          if (err.code == 'weak-password') {
            Get.snackbar(
              'Failed Change Password',
              'Password Harus Lebih Dari 6 Karakter',
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          } else {
            Get.snackbar(
              'Failed Change Password',
              'Error: ${err.code}',
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        });
      },
    );
  }

  //-----------------------log page
  final search = TextEditingController().obs;

  var results = [].obs;

  Future getLog() async {
    print('aaaa');
    Stream allLog = FirebaseFirestore.instance
        .collection('log')
        .orderBy('tanggal')
        .snapshots();
    print('bbbb');
    if (await allLog.isEmpty) {
      print('cccc');
      results.value = '.....' as List;
    } else {
      print('dddd $results');
      results.value = allLog as List;
      print('eee $results');
    }
  }
}

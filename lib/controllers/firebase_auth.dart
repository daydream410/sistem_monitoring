import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        Get.snackbar(
          'Failed Login',
          'Email / Password Salah.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (e.code == 'invalid-email') {
        Get.snackbar(
          'Failed Login',
          'Format Email Salah.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Failed Login',
          'Error : ${e.code}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
    return null;
  }
}

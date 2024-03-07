// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sistem_monitoring/controllers/controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final myController = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: size.height * 0.08,
                ),
                Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("images/logo.jpg"),
                    fit: BoxFit.fill,
                  )),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Center(
                  child: Text(
                    'SISTEM MONITORING KEAMANAN',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: size.height * 0.3,
                  width: size.width * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        controller: Get.find<Controller>().email.value,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                      const SizedBox(height: 20),
                      Obx(
                        () {
                          return TextField(
                            controller: Get.find<Controller>().password.value,
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
                              labelText: 'Password',
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          myController.signIn();
                        },
                        child: const Text('LOGIN'),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Belum Mempunyai Akun? Hubungi Admin',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

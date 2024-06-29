// ignore_for_file: unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:odoo_app/main.dart';
import 'package:odoo_app/screen/homescreen.dart';
// import 'package:hive/hive.dart';

class SignupProvider extends ChangeNotifier {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool pas = true;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // var box = Hive.box("bank");

  var box = Hive.box("diet");
  bool isloading = false;

  void logout(context) {
    box.put("login", false);
    box.put("admin", false);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Gate()),
        (route) => false);
  }

  void login(context) async {
    if (email.text == "admin@gmail.com" && pass.text == "admin") {
      box.put("login", true);
      box.put("admin", true);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('login as admin'),
      ));

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Gate()),
          (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('wrong id password'),
      ));
    }
  }

  Widget textinput(TextEditingController controller, String hint, IconData icon,
      bool isObscure, context, bool isusername) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontWeight: FontWeight.w600),
        decoration: InputDecoration(
            filled: true,
            hintText: hint,
            hintStyle: const TextStyle(fontFamily: "Jost"),
            prefixIcon: isusername
                ? const Padding(
                    padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    child: Text(
                      '#',
                      style: TextStyle(fontWeight: FontWeight.w900),
                      textScaler: TextScaler.linear(1.4),
                    ),
                  )
                : Icon(icon)),
      ),
    );
  }

  Widget password(TextEditingController controller, String hint, context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: TextField(
        controller: controller,
        obscureText: pas,
        style: const TextStyle(fontWeight: FontWeight.w600),
        decoration: InputDecoration(
            filled: true,
            suffixIcon: pas
                ? IconButton(
                    onPressed: () {
                      pas = false;
                      notifyListeners();
                    },
                    icon: const Icon(Icons.visibility_off))
                : IconButton(
                    onPressed: () {
                      pas = true;
                      notifyListeners();
                    },
                    icon: const Icon(Icons.visibility)),
            hintText: hint,
            hintStyle: const TextStyle(fontFamily: "Jost"),
            prefixIcon: const Icon(Icons.password_rounded)),
      ),
    );
  }
}

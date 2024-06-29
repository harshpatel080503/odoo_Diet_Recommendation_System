// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:odoo_app/main.dart';
import 'package:odoo_app/screen/homescreen.dart';
import 'package:odoo_app/screen/login.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController uheight = TextEditingController();
  TextEditingController uwidth = TextEditingController();
  TextEditingController dietary_preferences = TextEditingController();
  TextEditingController allergies = TextEditingController();
  TextEditingController health_goals = TextEditingController();
  String selectedGender = "Male";
  String selectedPreference = "Veg";
  bool pas = true;

  String txt = "Generate Plan";

  void change() {
    bool check = box.get("rec") ?? false;
    if (check) {
      txt = "View Plan";
      notifyListeners();
      print("true");
    } else {
      txt = "Generate Plan";
      notifyListeners();
      print("false");
    }
  }

  void logout(context) {
    box.put("login", false);
    box.put("admin", false);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Gate()),
        (route) => false);
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var box = Hive.box("diet");

  bool validateRegistrationForm() {
    if (name.text.isEmpty ||
        email.text.isEmpty ||
        pass.text.isEmpty ||
        age.text.isEmpty ||
        uheight.text.isEmpty ||
        uwidth.text.isEmpty ||
        dietary_preferences.text.isEmpty ||
        allergies.text.isEmpty ||
        health_goals.text.isEmpty) {
      return false;
    }

    return true;
  }

  Future<void> registerUser(context) async {
    try {
      DocumentReference docRef =
          await FirebaseFirestore.instance.collection('users').add({
        'name': name.text.trim(),
        'email': email.text.trim(),
        "password": pass.text.trim(),
        'age': int.parse(age.text.trim()),
        'height': double.parse(uheight.text.trim()),
        'weight': double.parse(uwidth.text.trim()),
        'gender': selectedGender,
        'dietaryPreferences': dietary_preferences.text.trim(),
        'allergies': allergies.text.trim(),
        'healthGoals': health_goals.text.trim(),
        "login": true
      });
      await firestore
          .collection("users")
          .doc(docRef.id)
          .update({"docid": docRef.id});

      box.put("name", name.text.trim());
      box.put("email", email.text.trim());
      box.put("password", pass.text.trim());
      box.put("age", int.parse(age.text.trim()));
      box.put("height", double.parse(uheight.text.trim()));
      box.put("weight", double.parse(uwidth.text.trim()));
      box.put("gender", selectedGender);
      box.put("dietaryPreferences", dietary_preferences.text.trim());
      box.put("allergies", allergies.text.trim());
      box.put("healthGoals", health_goals.text.trim());
      // box.put("login", login);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Registration Successful'),
      ));
      box.put("login", true);
      box.put("admin", false);
      box.put("id", docRef.id);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false);
    } catch (e) {
      String errorMessage = 'Error registering user';
      if (e is FirebaseAuthException) {
        errorMessage = e.message ?? 'Error registering user';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
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

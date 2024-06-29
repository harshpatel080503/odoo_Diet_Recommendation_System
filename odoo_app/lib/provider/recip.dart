// ignore_for_file: unused_element
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:hive/hive.dart';
import 'package:odoo_app/screen/item_result.dart';
import 'package:odoo_app/screen/recipe.dart';
// import 'package:random_avatar/random_avatar.dart';

class SearchProvider extends ChangeNotifier {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  var box = Hive.box("diet");
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Widget result = const Row(
    children: [Text("enter full item name like pizza, burger etc.")],
  );
  Widget result2 = const Row(
    children: [
      Text(
          "Enter Available Ingredients to Find Your Recipe, like : tomato, potato")
    ],
  );

  final gemini = Gemini.instance;

  void search(context) {
    final gemini = Gemini.instance;

    try {
      result = const Center(
        child: CircularProgressIndicator(),
      );
      notifyListeners();
      gemini
          .text('''Generate a recipe using the provided { ${controller.text}}}. Include step-by-step cooking instructions and any additional necessary details.also give recipe with high nutrisian. Format the output as a markdown output in step by step formate ''').then(
              (value) {
        String? data = value?.output;
        result = const Row(
          children: [Text("enter full item to serach")],
        );
        notifyListeners();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Recp(data: data ?? "some error try again")));
      }).catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('error : ${e.toString()}'),
        ));
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('error : ${e.toString()}'),
      ));
    }
  }

  void search2(context) {
    final gemini = Gemini.instance;

    try {
      result2 = const Center(
        child: CircularProgressIndicator(),
      );
      notifyListeners();
      gemini
          .text('''Generate a detailed nutritional list of {${controller2.text}}. Include information such as calories, protein, carbohydrates, fats, vitamins, and minerals. give me output in markdown text form include table and text data both  ''').then(
              (value) {
        String? data = value?.output;

        result2 = const Row(
          children: [Text("enter full item to serach")],
        );
        notifyListeners();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Item_result(data: data ?? "some error try again")));
      }).catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('error : ${e.toString()}'),
        ));
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('error : ${e.toString()}'),
      ));
    }
  }
}

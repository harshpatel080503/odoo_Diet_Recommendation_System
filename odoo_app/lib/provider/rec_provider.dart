import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:hive/hive.dart';

class RecProvider extends ChangeNotifier {
  TextEditingController controller = TextEditingController();
  var box = Hive.box("diet");
  void check() {
    print(box.get('age'));
  }

  void generate(context) {
    final gemini = Gemini.instance;
    String age = box.get('age').toString();
    String gender = box.get('gender').toString();
    String height = box.get('height').toString();
    String weight = box.get('weight').toString();
    String dietaryPreferences = box.get('dietaryPreferences').toString();
    String allergies = box.get('allergies').toString();
    String healthGoals = box.get('healthGoals').toString();

    try {
      gemini
          .text('''generate my whole day diet on basis of data like age : ${age.toString()} , weight : ${weight.toString()} kg ,gender : ${gender.toString()} , height : ${height.toString()} cm , dietaryPreferences : ${dietaryPreferences.toString()} , allergies : ${allergies.toString()} , health goal(${healthGoals.toString()}). give me the output in markdown text form , ${controller.text} ''').then(
              (value) {
        String? data = value?.output;
        box.put("rec_txt", data);
        box.put("rec", true);
        print(data);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('susseccfully done click now on routain'),
        ));
        // Navigator.push(
        //     // context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             Recp(data: data ?? "some error try again")));
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

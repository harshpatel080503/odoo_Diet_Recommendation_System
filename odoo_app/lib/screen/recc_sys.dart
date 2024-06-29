import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:odoo_app/provider/rec_provider.dart';
import 'package:odoo_app/screen/plan_show.dart';
import 'package:provider/provider.dart';

class RecGate extends StatelessWidget {
  const RecGate({super.key});

  @override
  Widget build(BuildContext context) {
    var box = Hive.box("diet");

    bool check = box.get("rec") ?? false;

    if (check) {
      print("true");
      return PlanPage();
    } else {
      print("false");
      return const RecSys();
    }
  }
}

class RecSys extends StatefulWidget {
  const RecSys({super.key});

  @override
  State<RecSys> createState() => _RecSysState();
}

class _RecSysState extends State<RecSys> {
  var box = Hive.box("diet");
  @override
  Widget build(BuildContext context) {
    return Consumer<RecProvider>(builder: (context, value, child) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Create New Plan"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(30),
                    child: TextField(
                      controller: value.controller,
                      // onSubmitted: (String txt) {
                      //   value.search();
                      // },
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter,
                        TextInputFormatter.withFunction(
                          (oldValue, newValue) {
                            if (newValue.text.isNotEmpty) {
                              return TextEditingValue(
                                text: newValue.text.toLowerCase(),
                                selection: newValue.selection,
                              );
                            }
                            return newValue;
                          },
                        )
                      ],
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: "Anything Special ?",
                        prefixIcon: Icon(Icons.book),
                      ),
                    )),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text("Got suggestions? or Click Generate Button")
                    ],
                  ),
                )
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              value.generate(context);
            },
            icon: const Icon(Icons.add),
            label: const Text("Generate"),
          ));
    });
  }
}

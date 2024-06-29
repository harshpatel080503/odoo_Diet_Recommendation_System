// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:markdown_widget/widget/markdown_block.dart';
import 'package:odoo_app/screen/recc_sys.dart';

class PlanPage extends StatefulWidget {
  PlanPage({
    super.key,
  });

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  var box = Hive.box("diet");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BalancedBite :  Diet Plan "),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const RecSys()));
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: MarkdownBlock(data: box.get("rec_txt") ?? ""),
      )),
    );
  }
}

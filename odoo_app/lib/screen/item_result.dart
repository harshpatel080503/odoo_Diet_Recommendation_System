// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:markdown_widget/widget/markdown_block.dart';

class Item_result extends StatefulWidget {
  String data;
  Item_result({super.key, required this.data});

  @override
  State<Item_result> createState() => _Item_resultState();
}

class _Item_resultState extends State<Item_result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Item Result"),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: MarkdownBlock(data: widget.data),
      )),
    );
  }
}

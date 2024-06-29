// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:markdown_widget/widget/markdown_block.dart';

class Recp extends StatefulWidget {
  String data;
  Recp({super.key, required this.data});

  @override
  State<Recp> createState() => _RecpState();
}

class _RecpState extends State<Recp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe"),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: MarkdownBlock(data: widget.data),
      )),
    );
  }
}

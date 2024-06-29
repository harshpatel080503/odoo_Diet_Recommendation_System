// import 'package:board_money/provider/find_friend_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:odoo_app/provider/recip.dart';
import 'package:provider/provider.dart';

class Searchrecp extends StatefulWidget {
  const Searchrecp({super.key});

  @override
  State<Searchrecp> createState() => _SearchrecpState();
}

class _SearchrecpState extends State<Searchrecp> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Consumer<SearchProvider>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          elevation: 10,
          toolbarHeight: height * 0.1,
          title: const Text(
            'Recipe Genie',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
        body: SafeArea(
          child: SizedBox(
            height: height * 0.85,
            child: Column(
              children: [
                const Gap(10),
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
                      decoration: InputDecoration(
                        filled: true,
                        suffixIcon: IconButton(
                            onPressed: () {
                              value.search(context);
                            },
                            icon: Icon(Icons.search)),
                        hintText: "Enter Avilable Items",
                        prefixIcon: Icon(Icons.food_bank_outlined),
                      ),
                    )),
                // const Gap(30),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: value.result2,
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

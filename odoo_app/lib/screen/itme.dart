// import 'package:board_money/provider/find_friend_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:odoo_app/provider/recip.dart';
import 'package:provider/provider.dart';

class SearchItem extends StatefulWidget {
  const SearchItem({super.key});

  @override
  State<SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Consumer<SearchProvider>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          elevation: 10,
          toolbarHeight: height * 0.1,
          title: const Text(
            'NutriScan',
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
                      controller: value.controller2,
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
                              value.search2(context);
                            },
                            icon: const Icon(Icons.search)),
                        hintText: "Enter food item name",
                        prefixIcon: const Icon(Icons.dinner_dining_rounded),
                      ),
                    )),
                // const Gap(30),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: value.result,
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

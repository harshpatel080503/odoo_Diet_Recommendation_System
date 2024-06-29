import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:odoo_app/provider/homepage_provider.dart';
import 'package:odoo_app/screen/dummy.dart';
import 'package:odoo_app/screen/dummydata.dart';
import 'package:odoo_app/screen/item_result.dart';
import 'package:odoo_app/screen/itme.dart';
import 'package:odoo_app/screen/recc_sys.dart';
import 'package:odoo_app/screen/serach_recp.dart';
import 'package:odoo_app/screen/user.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String pltxt = "Generate Plan";
  var box = Hive.box("diet");
  @override
  void initState() {
    super.initState();
    print(dummy["output"]?.length);
    print(dummy["output"]![0]["name"]);
    bool check = box.get("rec") ?? false;
    if (check) {
      print("object");
      pltxt = "View Plan";
      setState(() {});
    }
  }

  // List<dynamic> data = dummy['''output'''];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Consumer<LoginProvider>(builder: (context, value, child) {
      value.change();
      return Scaffold(
        appBar: AppBar(
          title: const Text("DietGenius"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.065,
                  width: width,
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // const Text("Search Option :",
                        //     textScaler: TextScaler.linear(1.2),
                        //     style: TextStyle(
                        //       fontWeight: FontWeight.bold,
                        //     )),
                        // const Gap(10),
                        FilledButton.icon(
                            icon: const Icon(Icons.local_pizza_rounded),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SearchItem()));
                            },
                            label: SizedBox(
                                height: height * 0.07,
                                width: width * 0.25,
                                child: const Center(
                                    child: Text("Search Nutrient",
                                        textScaler: TextScaler.linear(1.2))))),
                        // const Gap(20),

                        OutlinedButton.icon(
                            icon: const Icon(Icons.lunch_dining_rounded),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Searchrecp()));
                            },
                            label: SizedBox(
                                height: height * 0.07,
                                width: width * 0.25,
                                child: const Center(
                                    child: Text("Search Recipe",
                                        textScaler: TextScaler.linear(1.2))))),
                      ]),
                ),
                const Gap(10),
                // SizedBox(
                //   // height: height * 0.1,
                //   width: width * 0.95,
                //   child: Card(
                //     child: Padding(
                //       padding: const EdgeInsets.all(10),
                //       child: Column(
                //         children: [
                //           Row(
                //             children: [
                //               Text("Goal"),
                //             ],
                //           ),
                //           FilledButton.icon(
                //               onPressed: () {
                //                 Navigator.push(
                //                     context,
                //                     MaterialPageRoute(
                //                         builder: (context) => const RecGate()));
                //               },
                //               label: SizedBox(
                //                   height: height * 0.07,
                //                   width: width * 0.25,
                //                   child: Center(
                //                       child: Text("Generate Diet Plan"))))
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                Gap(10),
                const Row(
                  children: [Text("Exploer :")],
                ),
                SizedBox(
                  height: height * 0.8,
                  width: width * 0.95,
                  child: ListView.builder(
                    itemCount: dummydata["output"]?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        child: Card(
                            child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Item_result(
                                        data: dummy2["output"]![index]
                                            ["op"]!)));
                          },
                          leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.cover,
                                  dummy2["output"]![index]["image"]!)),
                          subtitle: Text(
                            dummydata["output"]![index]["description"]!,
                            overflow: TextOverflow.ellipsis,
                          ),
                          title: Text(dummy2["output"]![index]["name"]!),
                        )),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const RecGate()));
            },
            icon: const Icon(Icons.menu_book_rounded),
            label: Text(
              "Plan",
              textScaler: const TextScaler.linear(1.2),
              style: const TextStyle(fontWeight: FontWeight.w500),
            )),
        drawer: Drawer(
          child: Column(
            children: [
              const DrawerHeader(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "DietGenius",
                    style: TextStyle(fontWeight: FontWeight.w700),
                    textScaler: TextScaler.linear(1.8),
                  ),
                ],
              )),
              ListTile(
                leading: const Icon(Icons.medication_rounded),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Searchrecp()),
                  );
                },
                title: const Text(
                  "NutriScan",
                  style: TextStyle(fontWeight: FontWeight.w600),
                  textScaler: TextScaler.linear(1.2),
                ),
                subtitle: const Text(
                  "Explore Nutritional Details",
                  style: TextStyle(fontWeight: FontWeight.w600),
                  textScaler: TextScaler.linear(1),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.restaurant_rounded),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchItem()),
                  );
                },
                title: const Text(
                  "Recipe Genie",
                  style: TextStyle(fontWeight: FontWeight.w600),
                  textScaler: TextScaler.linear(1.2),
                ),
                subtitle: const Text(
                  "make recipes with available ingrediants",
                  style: TextStyle(fontWeight: FontWeight.w600),
                  textScaler: TextScaler.linear(0.8),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person_rounded),
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserPage()),
                  );
                },
                title: const Text(
                  "Profile",
                  style: TextStyle(fontWeight: FontWeight.w600),
                  textScaler: TextScaler.linear(1.2),
                ),
                subtitle: const Text(
                  "Your details",
                  style: TextStyle(fontWeight: FontWeight.w600),
                  textScaler: TextScaler.linear(1),
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ListTile(
                      onTap: () {
                        value.logout(context);
                      },
                      leading: const Icon(Icons.exit_to_app_rounded),
                      title: const Text(
                        "Logout",
                        style: TextStyle(fontWeight: FontWeight.w600),
                        textScaler: TextScaler.linear(1.2),
                      ),
                      subtitle: const Text(
                        "LogOut account",
                        style: TextStyle(fontWeight: FontWeight.w600),
                        textScaler: TextScaler.linear(1),
                      ),
                    ),
                    const ListTile(
                      leading: Icon(Icons.phone_android_rounded),
                      title: Text(
                        "Made In India 🇮🇳",
                        style: TextStyle(fontWeight: FontWeight.w600),
                        textScaler: TextScaler.linear(1.2),
                      ),
                      subtitle: Text(
                        "Made with ❤ by Dhairya",
                        style: TextStyle(fontFamily: "Jost"),
                      ),
                    ),
                    const Gap(10)
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

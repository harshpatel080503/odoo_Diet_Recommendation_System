// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:odoo_app/provider/homepage_provider.dart';
import 'package:odoo_app/screen/homescreen.dart';
import 'package:odoo_app/screen/signup.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, value, child) {
      return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Get Started',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Gap(25),
                  value.textinput(value.name, "Enter your Name", Icons.person,
                      true, context, false),
                  const Gap(20),
                  const Gap(20),
                  value.textinput(value.email, "Enter Email Address",
                      Icons.mail_rounded, false, context, false),
                  const Gap(20),
                  value.password(value.pass, "Create Password", context),
                  const Gap(20),
                  value.textinput(value.age, "Enter Age", Icons.child_care,
                      false, context, false),
                  const Gap(20),
                  value.textinput(value.uheight, "Enter Height",
                      Icons.straighten_rounded, false, context, false),
                  const Row(
                    children: [Gap(15), Text("in cm")],
                  ),
                  const Gap(20),
                  value.textinput(value.uwidth, "Enter Weight",
                      Icons.horizontal_rule, false, context, false),
                  const Row(
                    children: [Gap(15), Text("in Kg")],
                  ),
                  const Gap(20),
                  value.textinput(value.allergies, "Enter Your Allergies",
                      Icons.medical_information, false, context, false),
                  const Gap(20),
                  value.textinput(
                      value.health_goals,
                      "Enter your health goals.",
                      Icons.fitness_center,
                      false,
                      context,
                      false),
                  /////////////////////////////////
                  const Gap(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text(
                        "Gender :",
                        textScaler: TextScaler.linear(1.2),
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            value.selectedGender = 'Male';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(12),
                            color: value.selectedGender == 'Male'
                                ? Colors.blue.withOpacity(0.2)
                                : Colors.transparent,
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Row(
                            children: [
                              Icon(
                                value.selectedGender == 'Male'
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: value.selectedGender == 'Male'
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                              const SizedBox(width: 10),
                              const Text('Male'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            value.selectedGender = 'Female';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.pink),
                            borderRadius: BorderRadius.circular(12),
                            color: value.selectedGender == 'Female'
                                ? Colors.pink.withOpacity(0.2)
                                : Colors.transparent,
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Row(
                            children: [
                              Icon(
                                value.selectedGender == 'Female'
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: value.selectedGender == 'Female'
                                    ? Colors.pink
                                    : Colors.grey,
                              ),
                              const SizedBox(width: 10),
                              const Text('Female'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Preferences :",
                        textScaler: TextScaler.linear(1.2),
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const Gap(10),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            value.selectedPreference = 'Veg';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(12),
                            color: value.selectedPreference == 'Veg'
                                ? Colors.green.withOpacity(0.2)
                                : Colors.transparent,
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Row(
                            children: [
                              Icon(
                                value.selectedPreference == 'Veg'
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: value.selectedPreference == 'Veg'
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              const Text('Veg'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            value.selectedPreference = 'Non-Veg';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.circular(12),
                            color: value.selectedPreference == 'Non-Veg'
                                ? Colors.red.withOpacity(0.2)
                                : Colors.transparent,
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Row(
                            children: [
                              Icon(
                                value.selectedPreference == 'Non-Veg'
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: value.selectedPreference == 'Non-Veg'
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              const Text('Non-Veg'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            value.selectedPreference = 'Jain';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange),
                            borderRadius: BorderRadius.circular(12),
                            color: value.selectedPreference == 'Jain'
                                ? Colors.orange.withOpacity(0.2)
                                : Colors.transparent,
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Row(
                            children: [
                              Icon(
                                value.selectedPreference == 'Jain'
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: value.selectedPreference == 'Jain'
                                    ? Colors.orange
                                    : Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              const Text('Jain'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(30),

                  // Row(
                  //   children: [
                  //     TextButton(
                  //         onPressed: () {
                  //           Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) =>
                  //                       const SignUpScreen()));
                  //         },
                  //         child: const Text("Already have account ?"))
                  //   ],
                  // ),
                  const Gap(10),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpScreen()));
                          },
                          child: const Text("Are you admin ?"))
                    ],
                  )
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await value.registerUser(context);
              // value.loginapp(context);
            },
            label: const Text("Login"),
            icon: const Icon(
              Icons.arrow_forward,
            ),
          ));
    });
  }
}

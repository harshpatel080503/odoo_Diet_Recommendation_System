import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:odoo_app/main.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                var box = Hive.box("diet");
                box.put("login", false);
                box.put("admin", false);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Gate()),
                    (route) => false);
              },
              icon: const Icon(Icons.logout))
        ],
        title: const Text('Admin Page'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [Text("Users :")],
            ),
          ),
          SizedBox(
            height: height * 0.8,
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final users = snapshot.data?.docs ?? [];

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    final userData = user.data() as Map<String, dynamic>;

                    return Column(
                      children: [
                        ListTile(
                          title: Text(userData['name'] ?? 'No Name'),
                          subtitle:
                              Text('Email: ${userData['email'] ?? 'No Email'}'),
                          trailing: const Icon(Icons.arrow_forward),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(userData['name'] ?? 'No Name'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Email: ${userData['email'] ?? 'No Email'}'),
                                      Text(
                                          'Age: ${userData['age'] ?? 'No Age'}'),
                                      Text(
                                          'Height: ${userData['height'] ?? 'No Height'}'),
                                      Text(
                                          'Weight: ${userData['weight'] ?? 'No Weight'}'),
                                      Text(
                                          'Gender: ${userData['gender'] ?? 'No Gender'}'),
                                      Text(
                                          'Allergies: ${userData['allergies'] ?? 'None'}'),
                                      Text(
                                          'Dietary Preferences: ${userData['dietaryPreferences'] ?? 'None'}'),
                                      Text(
                                          'Health Goals: ${userData['healthGoals'] ?? 'None'}'),
                                      Text(
                                          'Login: ${userData['login'] ?? false}'),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('Close'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

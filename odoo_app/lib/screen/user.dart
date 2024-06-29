import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class UserPage extends StatefulWidget {
  // DocumentSnapshot userData;
  UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  var box = Hive.box("diet");
  @override
  Widget build(BuildContext context) {
    // fetchUserData();
    // createUserJson();
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("Name", box.get('name').toString()),
            _buildTextField("Email", box.get('email').toString()),
            _buildTextField("Age", box.get('age').toString()),
            _buildTextField("Gender", box.get('gender').toString()),
            _buildTextField("Height", box.get('height').toString()),
            _buildTextField("Weight", box.get('weight').toString()),
            // _buildTextField(
            //     "DietaryPreferences", box.get("dietaryPreferences")),
            _buildTextField("Allergies", box.get("allergies").toString()),
            _buildTextField("HealthGoals", box.get("healthGoals").toString()),
            // Add more fields as needed
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     await fetchUserData();
      //   },
      //   child: const Text("data"),
      // ),
    );
  }

  Widget _buildTextField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: value,
            readOnly: true, // Prevent editing
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
          ),
        ],
      ),
    );
  }
}

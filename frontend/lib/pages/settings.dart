import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final List<String> settingsOptions = [
    "Account",
    "Notifications",
    "Privacy",
    "Security",
    "Language",
    "Help & Support",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Settings",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
        child: ListView.separated(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        itemCount: settingsOptions.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5), // <- Vertical padding prevents border clipping
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black.withOpacity(0.2),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(
                settingsOptions[index],
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              trailing: Icon(Icons.settings, size: 20, color: Colors.black),
              onTap: () {
                print("Tapped on ${settingsOptions[index]}");
              },
            ),
          ),
        ),
        separatorBuilder: (context, index) => SizedBox(height: 10),
      ),

      ),
    );
  }
}

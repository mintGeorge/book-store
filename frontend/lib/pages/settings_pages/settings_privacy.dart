import 'package:flutter/material.dart';

class SettingsPrivacy extends StatelessWidget {
  const SettingsPrivacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Settings')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Change Password'),
            onTap: () {
              // Navigate to change password page
            },
          ),
          ListTile(
            leading: const Icon(Icons.visibility_off),
            title: const Text('Manage Blocked Users'),
            onTap: () {
              // Navigate to blocked users page
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy Policy'),
            onTap: () {
              // Show privacy policy
            },
          ),
        ],
      ),
    );
  }
}

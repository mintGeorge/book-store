import 'package:flutter/material.dart';

class SettingsHelp extends StatelessWidget {
  const SettingsHelp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('FAQ'),
              onTap: () {
                // Navigate to FAQ page or show FAQ dialog
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.email_outlined),
              title: const Text('Contact Support'),
              subtitle: const Text('support@example.com'),
              onTap: () {
                // Implement email support action
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('App Info'),
              onTap: () {
                // Show app info dialog or page
              },
            ),
          ],
        ),
      ),
    );
  }
}

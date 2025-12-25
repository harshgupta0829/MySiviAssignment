import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.settings, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text("Settings", style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            const Text("No settings available at the moment."),
          ],
        ),
      ),
    );
  }
}

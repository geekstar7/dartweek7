import 'package:flutter/material.dart';
import 'send_money_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SendMoneyPage()),
            );
          },
          child: const Text('Send Money'),
        ),
      ),
    );
  }
}

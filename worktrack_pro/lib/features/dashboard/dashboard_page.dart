import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:worktrack_pro/features/auth/login_page.dart';

class DashboardPage extends StatelessWidget {

  const DashboardPage({super.key});

  Future<void> logout(BuildContext context) async {

    await Supabase.instance.client.auth.signOut();

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final user = Supabase.instance.client.auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [

          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(Icons.logout),
          ),

        ],
      ),

      body: Center(
        child: Text(
          "Welcome\n\n${user?.email ?? ""}",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
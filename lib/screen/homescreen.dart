import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/screen/login.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await auth.signOut().then((value) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Loginpage()));
                });
              },
              icon: const Icon(Icons.exit_to_app_outlined))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Helloo",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${auth.currentUser?.email}",
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: (Colors.red),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

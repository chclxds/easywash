import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final title;
  const HomePage({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagina Inicial"),
      ),
      body: Center(
        child: Column(children: [
          const Text("Texto 1"),
          const Text("Texto 2"),
          ElevatedButton(
              onPressed: () {
                _signOut();
              },
              child: const Icon(Icons.switch_access_shortcut))
        ]),
      ),
    );
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

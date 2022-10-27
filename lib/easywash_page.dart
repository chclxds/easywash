import 'package:easywash/homepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'preloginpage.dart';

class EasyWashPage extends StatefulWidget {
  const EasyWashPage({super.key});

  @override
  State<EasyWashPage> createState() => _EasyWashPageState();
}

class _EasyWashPageState extends State<EasyWashPage> {
  @override
  void initState() {
    super.initState();
    verificarUsuario().then((temUsuario) {
      if (temUsuario) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const PreLoginPage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text('Bem Vindo Page'),
    ));
  }

  Future<bool> verificarUsuario() async {
    SharedPreferences shrdPreferences = await SharedPreferences.getInstance();
    String? token = shrdPreferences.getString('token');
    if (token == null) {
      return false;
    } else {
      return true;
    }
  }
}

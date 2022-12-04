import 'package:flutter/material.dart';
import 'homepagelavanderia.dart';
import 'loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaginaInicialLav extends StatefulWidget {
  const PaginaInicialLav({Key? key}) : super(key: key);

  @override
  State<PaginaInicialLav> createState() => _PaginaInicialLavState();
}

class _PaginaInicialLavState extends State<PaginaInicialLav> {
  @override
  void initState() {
    super.initState();
    verificarLavanderia().then((temLavanderia) {
      if (temLavanderia) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePageLavanderia(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      }
    });
  }

  Future<bool> verificarLavanderia() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? idLavanderia = sharedPreferences.getString('idLavanderia');
    if (idLavanderia == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

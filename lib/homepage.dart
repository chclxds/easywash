import 'package:easywash/visualizarservico.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final dynamic title;
  const HomePage({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Página Inicial',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        backgroundColor: const Color.fromRGBO(61, 144, 171, 1),
        leading: Image.asset('assets/IconTop.png'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment(0.0, -1.0),
            image: AssetImage('assets/backgroud-prelogin.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          child: Container(
            margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
            child: Column(
              children: [
                const Center(
                  heightFactor: 2,
                  child: Text('Pagina Inicial',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        color: Color.fromARGB(255, 51, 51, 51),
                      )),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                ),
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[100],
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text('Serviço 1'),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[100],
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text('Serviço 2'),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[100],
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text('Serviço 3'),
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VerServico()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(216, 40),
                    backgroundColor: const Color.fromARGB(255, 71, 212, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Ver Serviço',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {
                    _signOut();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(216, 40),
                    backgroundColor: const Color.fromARGB(255, 71, 212, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'LOGOUT',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

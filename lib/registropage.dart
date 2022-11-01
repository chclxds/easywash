import 'package:flutter/material.dart';
import 'cadastrapage.dart';
import 'cadastrapageuser.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  int _tipocliente = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Cadastra-se como!',
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
          backgroundColor: const Color.fromARGB(255, 61, 144, 171)),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment(0.0, -1.0),
            image: AssetImage('assets/backgroud-prelogin.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(children: [
          const Center(
            heightFactor: 2,
            child: Text(
              'Easy Wash',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 56,
                color: Color.fromARGB(255, 51, 51, 51),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: ListView(shrinkWrap: true, children: [
              RadioListTile(
                  value: 1,
                  title: const Text("Registra como Usuário"),
                  groupValue: _tipocliente,
                  onChanged: (val) => setState(() {
                        _tipocliente = val!;
                      })),
              RadioListTile(
                  value: 2,
                  title: const Text("Registra como Lavanderia"),
                  groupValue: _tipocliente,
                  onChanged: (val) => setState(() {
                        _tipocliente = val!;
                      })),
            ]),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
              onPressed: () {
                if (_tipocliente == 1) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CadastrarPageUser()));
                }
                if (_tipocliente == 2) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CadastrarPage()));
                }
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(216, 40),
                  backgroundColor: const Color.fromARGB(255, 71, 212, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
              child: const Text("CONTINUAR",
                  style: TextStyle(color: Colors.black)),
            ),
          ),
        ]),
      ),
    );
  }
}

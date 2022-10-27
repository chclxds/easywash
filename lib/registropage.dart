import 'package:flutter/material.dart';
import 'cadastrapage.dart';
import 'cadastrapageuser.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  bool _checkboxListTile1 = true;
  bool _checkboxListTile2 = false;

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
              child: Text('Easy Wash',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 56,
                    color: Color.fromARGB(255, 51, 51, 51),
                  )),
            ),
            SizedBox(
              width: 300,
              height: 40,
              child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const Text('CLIENTE'),
                  value: _checkboxListTile1,
                  activeColor: const Color.fromARGB(255, 59, 255, 141),
                  onChanged: (value) {
                    setState(() {
                      //_checkboxListTile1 = !_checkboxListTile2;
                      _checkboxListTile1 =
                          !_checkboxListTile1 && !_checkboxListTile2;
                    });
                  }),
            ),
            SizedBox(
              width: 300,
              height: 40,
              child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const Text('LAVANDERIA'),
                  value: _checkboxListTile2,
                  activeColor: const Color.fromARGB(255, 59, 255, 141),
                  onChanged: (value) {
                    setState(() {
                      //_checkboxListTile2 = !_checkboxListTile1;
                      _checkboxListTile2 =
                          !_checkboxListTile2 && !_checkboxListTile1;
                    });
                  }),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_checkboxListTile1 == true) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CadastrarPageUser()));
                  }
                  if (_checkboxListTile2 == true) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CadastrarPage()));
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(216, 40),
                  backgroundColor: const Color.fromARGB(255, 71, 212, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text("CONTINUAR",
                    style: TextStyle(color: Colors.black)),
              ),
            ),
          ]),
        ));
  }
}

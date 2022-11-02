import 'package:easywash/registropage.dart';
import 'package:flutter/material.dart';
import 'loginpage.dart';

class PreLoginPage extends StatefulWidget {
  const PreLoginPage({super.key});

  @override
  State<PreLoginPage> createState() => _PreLoginPageState();
}

class _PreLoginPageState extends State<PreLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 61, 144, 171),
          leading: Image.asset('assets/IconTop.png'),
          actions: const [
            //Padding(
            //  padding: EdgeInsets.symmetric(horizontal: 16),
            //  /child: Icon(Icons.menu, color: Color.fromARGB(255, 0, 0, 0)),
            //),
          ],
        ),
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
            Image.asset(
              'assets/Icon-prelogin.png',
              height: 200,
              width: 200,
            ),
            Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginPage()));
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(216, 40),
                      backgroundColor: const Color.fromARGB(255, 71, 212, 255),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  child: const Text("LOGIN",
                      style: TextStyle(color: Colors.black)),
                )),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RegistroPage()));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(216, 40),
                    backgroundColor: const Color.fromARGB(255, 71, 212, 255),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                child: const Text("REGISTRAR",
                    style: TextStyle(color: Colors.black)),
              ),
            ),
          ]),
        ));
  }
}

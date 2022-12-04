import 'package:easywash/loginpage.dart';
import 'package:easywash/pedidospage.dart';
import 'package:flutter/material.dart';
import 'servicos.dart';

class HomePageLavanderia extends StatefulWidget {
  const HomePageLavanderia({super.key});

  @override
  State<HomePageLavanderia> createState() => _HomePageLavanderiaState();
}

class _HomePageLavanderiaState extends State<HomePageLavanderia> {
  int _tiposervico = 1;

  signOut() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'EasyWash',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              signOut();
            },
            child: const Icon(Icons.logout),
          ),
        ],
        backgroundColor: const Color.fromRGBO(61, 144, 171, 1),
        leading: Image.asset('assets/IconTop.png'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment(0.0, -1.0),
            image: AssetImage('assets/backgroud-prelogin.png'),
            opacity: 0.75,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(children: [
          const Center(
            heightFactor: 2,
            child: Text(
              'O que gostaria de fazer:',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 56,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
          SizedBox(
            width: 300,
            height: 100,
            child: ListView(shrinkWrap: true, children: [
              RadioListTile(
                  value: 1,
                  title: const Text("Consultar Pedidos"),
                  groupValue: _tiposervico,
                  activeColor: const Color.fromARGB(255, 0, 0, 255),
                  onChanged: (val) => setState(() {
                        _tiposervico = val!;
                      })),
              RadioListTile(
                  value: 2,
                  title: const Text("Gerenciar Serviços"),
                  groupValue: _tiposervico,
                  activeColor: const Color.fromARGB(255, 0, 0, 255),
                  onChanged: (val) => setState(() {
                        _tiposervico = val!;
                      })),
            ]),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
              onPressed: () {
                if (_tiposervico == 1) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PedidosPage()));
                }
                if (_tiposervico == 2) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ServicosCadastro()));
                }
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(216, 50),
                  backgroundColor: const Color.fromARGB(255, 71, 212, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
              child: const Text("CONTINUAR",
                  style: TextStyle(color: Colors.black)),
            ),
          ),
          Container(margin: const EdgeInsets.only(top: 20.0)),
        ]),
      ),
    );
  }
}

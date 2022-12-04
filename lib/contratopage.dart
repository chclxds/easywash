import 'package:easywash/homepage.dart';
import 'package:flutter/material.dart';
import 'loginpage.dart';

class ContratadoServico extends StatefulWidget {
  const ContratadoServico({super.key});

  @override
  State<ContratadoServico> createState() => _ContratadoServicoState();
}

class _ContratadoServicoState extends State<ContratadoServico> {
  voltar() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePageUsuario(),
      ),
    );
  }

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
          'Descrição do Serviços',
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
        child: Form(
          child: Container(
            margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
            child: Column(
              children: [
                const Center(
                  heightFactor: 2,
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                ),
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[100],
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text('Serviço Contratado'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    voltar();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(216, 50),
                    backgroundColor: const Color.fromARGB(255, 71, 212, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  child: const Text('PÁGINA INICIAL',
                      style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

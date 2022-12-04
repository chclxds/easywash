import 'package:easywash/homepagelavanderia.dart';
import 'package:flutter/material.dart';
import 'loginpage.dart';

class PedidosPage extends StatefulWidget {
  const PedidosPage({super.key});

  @override
  State<PedidosPage> createState() => _PedidosPageState();
}

class _PedidosPageState extends State<PedidosPage> {
  voltar() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePageLavanderia(),
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
          'Pedidos',
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
                SizedBox(
                  height: 400,
                  child: ListView(
                    children: <Widget>[
                      Card(
                        child: ListTile(
                          leading: Image.asset('assets/Icon-avatar.png'),
                          title: const Text('Jose'),
                          subtitle: const Text(
                              'Pedido : 9876, 10 Camisas, Rua concordia numero 77'),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Image.asset('assets/Icon-avatar.png'),
                          title: const Text('Renata'),
                          subtitle: const Text(
                              'Pedido : 9877, 9 Calças, Rua senador numero 147'),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Image.asset('assets/Icon-avatar.png'),
                          title: const Text('Ellen'),
                          subtitle: const Text(
                              'Pedido : 9879, 5 Vestidos, 3 Calças, 10 Camisas, Rua Chile numero 200'),
                        ),
                      ),
                    ],
                  ),
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
                  child: const Text('Voltar',
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

import 'package:flutter/material.dart';
import 'registropage.dart';

class CadastrarPage extends StatefulWidget {
  const CadastrarPage({super.key});

  @override
  State<CadastrarPage> createState() => _CadastrarPageState();
}

class _CadastrarPageState extends State<CadastrarPage> {
  final _formKey = GlobalKey<FormState>();
  final _senhaController = TextEditingController();
  final _nomeController = TextEditingController();
  final _dnController = TextEditingController();
  final _emailController = TextEditingController();
  bool _verSenha = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Cadastro - Lavanderia',
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
          backgroundColor: const Color.fromRGBO(61, 144, 171, 1)),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment(0.0, -1.0),
            image: AssetImage('assets/backgroud-prelogin.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
            child: Column(
              children: [
                TextFormField(
                  controller: _nomeController,
                  decoration: const InputDecoration(
                    label: Text('Nome'),
                    hintText: 'Nome Completo',
                  ),
                  validator: (nome) {
                    if (nome == null || nome.isEmpty) {
                      return 'Digite seu Nome Compelto';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _dnController,
                  decoration: const InputDecoration(
                    label: Text('Data Nascimento'),
                    hintText: 'DD/MM/AAAA',
                  ),
                  validator: (dn) {
                    if (dn == null || dn.isEmpty) {
                      return 'Digite sua Data de Nascimento';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    label: Text('E-mail'),
                    hintText: 'nome@email.com',
                  ),
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'Digite seu E-mail';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _senhaController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !_verSenha,
                  decoration: InputDecoration(
                    label: const Text('Senha'),
                    hintText: 'Digite sua senha',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _verSenha = !_verSenha;
                        });
                      },
                      icon: Icon(
                        _verSenha
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                  ),
                  validator: (senha) {
                    if (senha == null || senha.isEmpty) {
                      return 'Digite sua Senha';
                    } else if (senha.length < 8) {
                      return 'Digite Uma Senha Maior';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      cadastrar();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(216, 40),
                    backgroundColor: const Color.fromARGB(255, 71, 212, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Cadastrar',
                      style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  cadastrar() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const RegistroPage(),
      ),
    );
  }
}

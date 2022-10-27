// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:easywash/easywash_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'registropage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _verSenha = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'LOGIN',
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
                      logar();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(216, 40),
                    backgroundColor: const Color.fromARGB(255, 71, 212, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Entrar',
                      style: TextStyle(color: Colors.black)),
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {
                    cadastrar();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(216, 40),
                    backgroundColor: const Color.fromARGB(255, 71, 212, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Cadastar',
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
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const RegistroPage(),
      ),
    );
  }

  logar() async {
    SharedPreferences shrdPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse('https://demo.treblle.com/');
    var response = await http.post(
      url,
      body: {
        'user_id': _emailController.text,
        'password': _senhaController.text,
      },
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      String token = json.decode(response.body)['token'];
      await shrdPreferences.setString('token', 'Token $token');
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const EasyWashPage(),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('E-mail e/ou Senha inválidos'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}

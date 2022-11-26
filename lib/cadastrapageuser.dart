// ignore_for_file: avoid_print

import 'package:easywash/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Usuario> createUsuario(
  String nome,
  String senha,
  String cpf,
  String email,
) async {
  final response = await http.post(
      Uri.parse('https://easywash-backend.herokuapp.com/usuarios'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nome': nome,
        'senha': senha,
        'cpf': cpf,
        'email': email,
      }));
  print(response);
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    return Usuario.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Falha ao cadastrar Usuario');
  }
}

class Usuario {
  final String id;
  final String nome;
  final String senha;
  final String cpf;
  final String email;
  const Usuario({
    required this.id,
    required this.nome,
    required this.senha,
    required this.cpf,
    required this.email,
  });
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nome: json['nome'],
      senha: json['senha'],
      cpf: json['cpf'],
      email: json['email'],
    );
  }
}

class CadastrarPageUser extends StatefulWidget {
  const CadastrarPageUser({super.key});

  @override
  State<CadastrarPageUser> createState() => _CadastrarPageUserState();
}

class _CadastrarPageUserState extends State<CadastrarPageUser> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _verSenha = false;

  Future<Usuario>? _futureUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Cadastro - Usuário',
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
                  controller: _cpfController,
                  decoration: const InputDecoration(
                    label: Text('CPF'),
                    hintText: '000.000.000-00',
                  ),
                  validator: (cpf) {
                    if (cpf == null || cpf.isEmpty) {
                      return 'Digite seu CPF';
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
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _futureUser = createUsuario(
                          _nomeController.text,
                          _senhaController.text,
                          _cpfController.text,
                          _emailController.text);
                      cadastrar();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(216, 50),
                    backgroundColor: const Color.fromARGB(255, 71, 212, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
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

  FutureBuilder<Usuario> buildFutureBuilder() {
    return FutureBuilder(
        future: _futureUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data!.nome);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        });
  }

  cadastrar() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }
}

import 'dart:convert';
import 'package:easywash/servicos.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Lavanderia> createLavanderia(
  String nome,
  String senha,
  String cnpj,
  String email,
) async {
  final response = await http.post(
      Uri.parse('https://easywash-backend.herokuapp.com/lavanderias'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nome': nome,
        'senha': senha,
        'cnpj': cnpj,
        'email': email,
      }));
  if (response.statusCode == 200) {
    return Lavanderia.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Falha ao cadastrar lavanderia');
  }
}

class Lavanderia {
  final String id;
  final String nome;
  final String senha;
  final String cnpj;
  final String email;
  const Lavanderia({
    required this.id,
    required this.nome,
    required this.senha,
    required this.cnpj,
    required this.email,
  });
  factory Lavanderia.fromJson(Map<String, dynamic> json) {
    return Lavanderia(
      id: json['id'],
      nome: json['nome'],
      senha: json['senha'],
      cnpj: json['cnpj'],
      email: json['email'],
    );
  }
}

class CadastrarPage extends StatefulWidget {
  const CadastrarPage({super.key});

  @override
  State<CadastrarPage> createState() => _CadastrarPageState();
}

class _CadastrarPageState extends State<CadastrarPage> {
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _verSenha = false;

  Future<Lavanderia>? _futureLavanderia;

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
          child: Container(
            margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
            child: Column(
              children: [
                TextFormField(
                  controller: _nomeController,
                  decoration: const InputDecoration(
                    label: Text('Nome da Lavanderia'),
                    hintText: 'EasyWash',
                  ),
                  validator: (nome) {
                    if (nome == null || nome.isEmpty) {
                      return 'Digite o nome da Lavanderia';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _cnpjController,
                  decoration: const InputDecoration(
                    label: Text('CNPJ'),
                    hintText: '00.000.000/0001-00',
                  ),
                  validator: (cnpj) {
                    if (cnpj == null || cnpj.isEmpty) {
                      return 'Digite o CNPJ';
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
                      _futureLavanderia = createLavanderia(
                          _nomeController.text,
                          _senhaController.text,
                          _cnpjController.text,
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

  FutureBuilder<Lavanderia> buildFutureBuilder() {
    return FutureBuilder(
        future: _futureLavanderia,
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
        builder: (context) => const ServicosCadastro(),
      ),
    );
  }
}

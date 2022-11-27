// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:easywash/servicos.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Lavanderia> createLavanderia(
  String nome,
  String senha,
  String cnpj,
  String email,
  String telefone,
  String rua,
  String bairro,
  String cidade,
  String uf,
  String cep,
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
        'telefone': telefone,
        'rua': rua,
        'bairro': bairro,
        'cidade': cidade,
        'uf': uf,
        'cep': cep,
      }));
  print(response);
  print(response.statusCode);
  print(response.body);
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
  final String telefone;
  final String rua;
  final String bairro;
  final String cidade;
  final String uf;
  final String cep;
  const Lavanderia({
    required this.id,
    required this.nome,
    required this.senha,
    required this.cnpj,
    required this.email,
    required this.telefone,
    required this.rua,
    required this.bairro,
    required this.cidade,
    required this.uf,
    required this.cep,
  });
  factory Lavanderia.fromJson(Map<String, dynamic> json) {
    return Lavanderia(
      id: json['id'],
      nome: json['nome'],
      senha: json['senha'],
      cnpj: json['cnpj'],
      email: json['email'],
      telefone: json['telefone'],
      rua: json['rua'],
      bairro: json['bairro'],
      cidade: json['cidade'],
      uf: json['uf'],
      cep: json['cep'],
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
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _ufController = TextEditingController();
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
          child: (_futureLavanderia == null)
              ? Container(
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
                        controller: _telefoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          label: Text('Telefone'),
                          hintText: '11 91111-1111',
                        ),
                        validator: (telefone) {
                          if (telefone == null || telefone.isEmpty) {
                            return 'Digite seu Telefone';
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
                        controller: _cepController,
                        decoration: const InputDecoration(
                          label: Text('CEP'),
                          hintText: '00.000-000',
                        ),
                        validator: (cep) {
                          if (cep == null || cep.isEmpty) {
                            return 'Digite o CEP';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _ruaController,
                        keyboardType: TextInputType.streetAddress,
                        decoration: const InputDecoration(
                          label: Text('Rua'),
                          hintText: 'Rua dos Bobos, nº 0',
                        ),
                        validator: (rua) {
                          if (rua == null || rua.isEmpty) {
                            return 'Digite a Rua ou Avenida';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _bairroController,
                        keyboardType: TextInputType.streetAddress,
                        decoration: const InputDecoration(
                          label: Text('Bairro'),
                          hintText: 'Bairro Esmero',
                        ),
                        validator: (bairro) {
                          if (bairro == null || bairro.isEmpty) {
                            return 'Digite o Bairro';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _cidadeController,
                        keyboardType: TextInputType.streetAddress,
                        decoration: const InputDecoration(
                          label: Text('Cidade'),
                          hintText: 'Cidade Engraçada',
                        ),
                        validator: (cidade) {
                          if (cidade == null || cidade.isEmpty) {
                            return 'Digite sua Cidade';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _ufController,
                        keyboardType: TextInputType.streetAddress,
                        decoration: const InputDecoration(
                          label: Text('Estado'),
                          hintText: 'Rio de São Paulo',
                        ),
                        validator: (uf) {
                          if (uf == null || uf.isEmpty) {
                            return 'Digite seu Estado';
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
                              _emailController.text,
                              _telefoneController.text,
                              _ruaController.text,
                              _bairroController.text,
                              _cidadeController.text,
                              _ufController.text,
                              _cepController.text,
                            );
                            cadastrar();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(216, 50),
                          backgroundColor:
                              const Color.fromARGB(255, 71, 212, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: const Text('Cadastrar',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                )
              : buildFutureBuilder(),
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

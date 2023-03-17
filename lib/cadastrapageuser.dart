import 'package:easywash/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Usuario> createUsuario(
  String nome,
  String senha,
  String cpf,
  String email,
  String telefone,
  String rua,
  String bairro,
  String cidade,
  String uf,
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
        'telefone': telefone,
        'rua': rua,
        'bairro': bairro,
        'cidade': cidade,
        'uf': uf,
      }));
  if (response.statusCode == 200) {
    return Usuario.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Falha ao cadastrar Usuário');
  }
}

class Usuario {
  const Usuario({
    required this.id,
    required this.nome,
    required this.senha,
    required this.cpf,
    required this.email,
    required this.telefone,
    required this.rua,
    required this.bairro,
    required this.cidade,
    required this.uf,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nome: json['nome'],
      senha: json['senha'],
      cpf: json['cpf'],
      email: json['email'],
      telefone: json['telefone'],
      rua: json['rua'],
      bairro: json['bairro'],
      cidade: json['cidade'],
      uf: json['uf'],
    );
  }

  final String bairro;
  final String cidade;
  final String cpf;
  final String email;
  final String id;
  final String nome;
  final String rua;
  final String senha;
  final String telefone;
  final String uf;
}

class CadastrarPageUser extends StatefulWidget {
  const CadastrarPageUser({super.key});

  @override
  State<CadastrarPageUser> createState() => _CadastrarPageUserState();
}

class _CadastrarPageUserState extends State<CadastrarPageUser> {
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future<Usuario>? _futureUser;
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _ufController = TextEditingController();
  bool _verSenha = false;

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
            opacity: 0.75,
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _formKey,
          child: (_futureUser == null)
              ? SingleChildScrollView(
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nomeController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          label: Text('Nome'),
                          hintText: 'Nome Completo',
                        ),
                        validator: (nome) {
                          if (nome == null || nome.isEmpty) {
                            return 'Digite seu Nome Completo';
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
                        controller: _cpfController,
                        keyboardType: TextInputType.number,
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
                          hintText: 'Digite sua senha com 8 caracteres ou mais',
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
                          if (_formKey.currentState!.validate()) {
                            cadastrar();
                            setState(() {
                              _futureUser = createUsuario(
                                _nomeController.text,
                                _senhaController.text,
                                _cpfController.text,
                                _emailController.text,
                                _telefoneController.text,
                                _ruaController.text,
                                _bairroController.text,
                                _cidadeController.text,
                                _ufController.text,
                              );
                            });
                          }
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
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              : buildFutureBuilder(),
        ),
      ),
    );
  }
}

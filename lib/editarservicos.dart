import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'servicos.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Usuario> createUsuario(
  String titulo,
  String descricao,
  String valor,
) async {
  final response = await http.post(
      Uri.parse('https://easywash-backend.herokuapp.com/servicos'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'titulo': titulo,
        'descricao': descricao,
        'valor': valor,
      }));
  if (response.statusCode == 200) {
    return Usuario.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Falha ao cadastrar Serviço');
  }
}

class Usuario {
  const Usuario({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.valor,
    required this.idLavanderia,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      titulo: json['titulo'],
      descricao: json['descricao'],
      valor: json['valor'],
      idLavanderia: json['idLavanderia'],
    );
  }

  final String descricao;
  final String id;
  final String idLavanderia;
  final String titulo;
  final String valor;
}

class ServicoEditar extends StatefulWidget {
  const ServicoEditar({super.key});

  @override
  State<ServicoEditar> createState() => _ServicoEditarState();
}

class _ServicoEditarState extends State<ServicoEditar> {
  final TextEditingController _descricaoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future<Usuario>? _futureServico;
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();

  FutureBuilder<Usuario> buildFutureBuilder() {
    return FutureBuilder(
        future: _futureServico,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data!.titulo);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        });
  }

  salvar() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ServicosCadastro(),
      ),
    );
  }

  cancelar() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ServicosCadastro(),
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
          'Serviços',
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
          key: _formKey,
          child: (_futureServico == null)
              ? Container(
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
                  child: Column(
                    children: [
                      const Center(
                        heightFactor: 2,
                        child: Text(
                          'Cadastrar Serviço',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                      ),
                      TextFormField(
                        controller: _tituloController,
                        decoration: const InputDecoration(
                          label: Text('Titulo'),
                          hintText: 'Tipo do Serviço',
                        ),
                        validator: (titulo) {
                          if (titulo == null || titulo.isEmpty) {
                            return 'Ex: Lavagem Clean';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _valorController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text('Valor'),
                          hintText: '25,00',
                        ),
                        validator: (valor) {
                          if (valor == null || valor.isEmpty) {
                            return 'Valor do Serviço';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _descricaoController,
                        decoration: const InputDecoration(
                          label: Text('Descrição'),
                          hintText: 'Roupas Leves',
                        ),
                        validator: (desc) {
                          if (desc == null || desc.isEmpty) {
                            return 'Digite uma descrição';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _futureServico = createUsuario(
                            _tituloController.text,
                            _descricaoController.text,
                            _valorController.text,
                          );
                          salvar();
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(216, 50),
                          backgroundColor:
                              const Color.fromARGB(255, 71, 212, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: const Text('SALVAR',
                            style: TextStyle(color: Colors.black)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          cancelar();
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(216, 40),
                          backgroundColor:
                              const Color.fromARGB(255, 71, 212, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: const Text('CANCELAR',
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
}

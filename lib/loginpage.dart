// ignore_for_file: avoid_print, use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';
import 'homepagelavanderia.dart';
import 'registropage.dart';
import 'package:http/http.dart' as http;

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
          'EasyWash',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
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
          child: Container(
            margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
            child: Column(
              children: [
                const Center(
                  heightFactor: 2,
                  child: Text('Login',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 35,
                        color: Color.fromARGB(255, 0, 0, 0),
                      )),
                ),
                Image.asset(
                  'assets/Icon-prelogin.png',
                  height: 200,
                  width: 200,
                ),
                SizedBox(
                  width: 250,
                  child: TextFormField(
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
                ),
                SizedBox(
                  width: 250,
                  child: TextFormField(
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
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      logar();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(216, 50),
                    backgroundColor: const Color.fromARGB(255, 71, 212, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  child: const Text('ENTRAR',
                      style: TextStyle(color: Colors.black)),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    cadastrar();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(216, 50),
                    backgroundColor: const Color.fromARGB(255, 71, 212, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  child: const Text('CADASTRAR',
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

  logar() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse('https://easywash-backend.herokuapp.com/login');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            'email': _emailController.text,
            'senha': _senhaController.text,
          },
        ));

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      String idUsuario = json.decode(response.body)['idUsuario'];
      await sharedPreferences.setString('idUsuario', 'idUsuario $idUsuario');
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const HomePageUsuario()));
    } else if (response.statusCode == 201) {
      String idLavanderia = json.decode(response.body)['idLavanderia'];
      await sharedPreferences.setString(
          'idLavanderia', 'idLavanderia $idLavanderia');
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const HomePageLavanderia()));
    } else {
      const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('E-mail ou Senha inválidos'),
        behavior: SnackBarBehavior.floating,
      );
    }
  }
}

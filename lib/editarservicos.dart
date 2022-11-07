import 'package:flutter/material.dart';
import 'servicos.dart';

class ServicoEditar extends StatefulWidget {
  const ServicoEditar({super.key});

  @override
  State<ServicoEditar> createState() => _ServicoEditarState();
}

class _ServicoEditarState extends State<ServicoEditar> {
  final _nomeController = TextEditingController();
  final _qtdController = TextEditingController();
  final _valorController = TextEditingController();
  final _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Serviços',
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
                  child: Text('Tipo de Serviços',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        color: Color.fromARGB(255, 51, 51, 51),
                      )),
                ),
                TextFormField(
                  controller: _nomeController,
                  decoration: const InputDecoration(
                    label: Text('Nome'),
                    hintText: 'Tipo do Serviço',
                  ),
                  validator: (nome) {
                    if (nome == null || nome.isEmpty) {
                      return 'Ex: Lavagem Clean';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _qtdController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Quantidade'),
                    hintText: '50',
                  ),
                  validator: (qtd) {
                    if (qtd == null || qtd.isEmpty) {
                      return 'Quantidade de Peças';
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
                  controller: _descController,
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
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {
                    salvar();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(216, 40),
                    backgroundColor: const Color.fromARGB(255, 71, 212, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('SALVAR',
                      style: TextStyle(color: Colors.black)),
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {
                    cancelar();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(216, 40),
                    backgroundColor: const Color.fromARGB(255, 71, 212, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('CANCELAR',
                      style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
}

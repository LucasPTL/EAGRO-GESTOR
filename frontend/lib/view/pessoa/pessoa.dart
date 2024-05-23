// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:eagro_gestor/utils/http_client.dart';
import 'package:flutter/material.dart';

class PessoaWidget extends StatefulWidget {
  const PessoaWidget({super.key});

  @override
  State<PessoaWidget> createState() => _PessoaWidgetState();
}

class _PessoaWidgetState extends State<PessoaWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool drawerOpen = false;
  List<Map<String, dynamic>> pessoas =
      []; // Lista para armazenar os dados dos usuários

  @override
  void initState() {
    super.initState();
  }

  void toggleDrawer() {
    setState(() {
      scaffoldKey.currentState?.openDrawer();
      drawerOpen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> fetchPessoas() async {
      var resposta = await get('/pessoa');
      if (resposta != null && resposta.statusCode == 200) {
        try {
          List<dynamic> listaDinamica = jsonDecode(resposta.body);
          List<Map<String, dynamic>> pessoas = listaDinamica
              .map((item) => item as Map<String, dynamic>)
              .toList();

          setState(() {
            this.pessoas = pessoas;
          });
        } catch (e) {
          debugPrint("Erro ao decodificar JSON: $e");
        }
      } else {
        debugPrint("Erro ao buscar dados: status code ${resposta?.statusCode}");
      }
    }

    fetchPessoas(); // Chama a função para buscar os dados

    double larguraTelaPorc(double porc) {
      double larguraTela = MediaQuery.of(context).size.width;
      return (larguraTela * (porc / 100));
    }

    double alturaTelaPorc(double porc) {
      double alturaTela = MediaQuery.of(context).size.height;
      return (alturaTela * (porc / 100));
    }

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color.fromARGB(164, 34, 57, 88),
      appBar: AppBar(
        title: const Text('Pessoas'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: alturaTelaPorc(10),
                width: larguraTelaPorc(90),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: larguraTelaPorc(40),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/cadpessoa');
                        },
                        style: TextButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 88, 211, 40),
                          shape: RoundedRectangleBorder(
                            // Define a forma do botão como retangular
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: const Text(
                          'Adicionar Pessoa',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    )),
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: larguraTelaPorc(90),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: pessoas.length,
                    itemBuilder: (context, index) {
                      final pessoa = pessoas[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 4), // Separação entre as linhas
                        decoration: BoxDecoration(
                          color: (index % 2 == 0)
                              ? Colors.white
                              : Colors.grey[200], // Alternância de cores
                          borderRadius:
                              BorderRadius.circular(8), // Bordas arredondadas
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1), // Posição da sombra
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(pessoa['nome'],
                              style: const TextStyle(color: Colors.black)),
                          subtitle: Text(
                              '${pessoa['contato']}\n${pessoa['endereco']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/cadpessoa',
                                      arguments: pessoa['id']);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  if (await confirm(
                                    context,
                                    title: const Text('Confirmação'),
                                    content: const Text(
                                        'Você deseja excluir a pessoa selecionada?'),
                                    textOK: const Text('Sim'),
                                    textCancel: const Text('Não'),
                                  )) {
                                    var resposta =
                                        await delete('/pessoa/${pessoa['id']}');
                                    if (resposta == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('Servidor Inoperante'),
                                      ));
                                    } else {
                                      if (resposta.statusCode != 200) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content:
                                              Text('Erro ao excluir pessoa'),
                                        ));
                                      }
                                    }
                                    setState(() {});
                                  } else {}
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:eagro_gestor/utils/http_client.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class ProdutoWidget extends StatefulWidget {
  const ProdutoWidget({super.key});

  @override
  State<ProdutoWidget> createState() => _ProdutoWidgetState();
}

class _ProdutoWidgetState extends State<ProdutoWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool drawerOpen = false;
  List<Map<String, dynamic>> produtos = [];

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
    Future<void> fetchProdutos() async {
      var resposta = await get('/produto');
      if (resposta != null && resposta.statusCode == 200) {
        try {
          List<dynamic> listaDinamica = jsonDecode(resposta.body);
          List<Map<String, dynamic>> produtos = listaDinamica
              .map((item) => item as Map<String, dynamic>)
              .toList();

          setState(() {
            this.produtos = produtos;
          });
        } catch (e) {
          debugPrint("Erro ao decodificar JSON: $e");
        }
      } else {
        debugPrint("Erro ao buscar dados: status code ${resposta?.statusCode}");
      }
    }

    fetchProdutos();

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
        title: const Text('Produtos'),
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
                          Navigator.pushNamed(context, '/cadproduto');
                        },
                        style: TextButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 88, 211, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: const Text(
                          'Adicionar Produto',
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
                      itemCount: produtos.length,
                      itemBuilder: (context, index) {
                        final produto = produtos[index];
                        final formatCurrency = NumberFormat.simpleCurrency(
                          locale: Platform.localeName,
                          name: 'BRL',
                        );

                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: (index % 2 == 0)
                                ? Colors.white
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(produto['nome'],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            subtitle: RichText(
                              text: TextSpan(
                                text: '${produto['descricao']}\n',
                                style: DefaultTextStyle.of(context)
                                    .style
                                    .copyWith(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                children: [
                                  const TextSpan(
                                      text: 'Categoria: ', style: TextStyle()),
                                  TextSpan(text: '${produto['categoria']}\n'),
                                  TextSpan(
                                      text: formatCurrency
                                          .format(((produto['preco'] / 100))),
                                      style: const TextStyle()),
                                ],
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/cadproduto',
                                        arguments: produto['id']);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    if (await confirm(
                                      context,
                                      title: const Text('Confirmação'),
                                      content: const Text(
                                          'Você deseja excluir o produto selecionado?'),
                                      textOK: const Text('Sim'),
                                      textCancel: const Text('Não'),
                                    )) {
                                      var resposta = await delete(
                                          '/produto/${produto['id']}');
                                      if (resposta == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Servidor Inoperante')));
                                      } else {
                                        if (resposta.statusCode != 200) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Erro ao excluir produto')));
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
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

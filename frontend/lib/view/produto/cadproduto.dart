// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:eagro_gestor/utils/http_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:phone_form_field/phone_form_field.dart';

class CadastroprodutosPageWidget extends StatefulWidget {
  const CadastroprodutosPageWidget({super.key, String? id});

  @override
  State<CadastroprodutosPageWidget> createState() =>
      _CadastroprodutosPageWidgetState();
}

class _CadastroprodutosPageWidgetState
    extends State<CadastroprodutosPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController controllerNome = TextEditingController();
  final TextEditingController controllerDescricao = TextEditingController();
  final controllerPreco =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  final TextEditingController controllerCategoria = TextEditingController();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PhoneFormField();

    double larguraTelaPorc(double porc) {
      double larguraTela = MediaQuery.sizeOf(context).width;
      return (larguraTela * (porc / 100));
    }

    double alturaTelaPorc(double porc) {
      double alturaTela = MediaQuery.sizeOf(context).height;
      return (alturaTela * (porc / 100));
    }

    final String? idProduto =
        ModalRoute.of(context)?.settings.arguments as String?;

    void populaCampos(String? idProduto) async {
      if (idProduto != null && idProduto.isNotEmpty) {
        var resposta = await get('/produto/$idProduto');
        if (resposta?.statusCode == 200) {
          try {
            var produto = jsonDecode(resposta!.body.toString());
            controllerNome.text = produto['nome'];
            controllerDescricao.text = produto['descricao'];
            controllerCategoria.text = produto['categoria'];
            controllerPreco.text = (produto['preco']).toString();
          } catch (e) {
            debugPrint("Erro ao buscar produto: $e");
          }
        } else {
          debugPrint(
              "Erro ao buscar produto: status code ${resposta?.statusCode}");
        }
      }
    }

    populaCampos(idProduto);

    return Scaffold(
        backgroundColor: const Color.fromARGB(164, 34, 57, 88),
        key: scaffoldKey,
        appBar: AppBar(),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: larguraTelaPorc(60),
                  child: Column(
                    children: [
                      SizedBox(
                        height: alturaTelaPorc(15),
                      ),
                      TextField(
                        maxLength: 150,
                        controller: controllerNome,
                        decoration: const InputDecoration(
                          counterText: '',
                          hintText: 'Insira o nome do produto',
                          labelText: 'Produto',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 88, 211, 40)),
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 88, 211, 40)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 88, 211, 40)),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: alturaTelaPorc(2)),
                      TextField(
                        maxLength: 150,
                        controller: controllerDescricao,
                        decoration: const InputDecoration(
                          counterText: '',
                          hintText: 'Insira a descrição',
                          labelText: 'Descrição',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 88, 211, 40)),
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 88, 211, 40)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 88, 211, 40)),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: alturaTelaPorc(2)),
                      TextField(
                        maxLength: 150,
                        controller: controllerCategoria,
                        decoration: const InputDecoration(
                          counterText: '',
                          hintText: 'Insira a categoria',
                          labelText: 'Categoria',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 88, 211, 40)),
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 88, 211, 40)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 88, 211, 40)),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: alturaTelaPorc(2)),
                      TextField(
                        controller: controllerPreco,
                        decoration: const InputDecoration(
                          counterText: '',
                          hintText: 'Insira o valor da moeda',
                          labelText: 'Valor da Moeda',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 88, 211, 40)),
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 88, 211, 40)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 88, 211, 40)),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: alturaTelaPorc(4),
                      ),
                      SizedBox(
                        width: larguraTelaPorc(40),
                        child: TextButton(
                          onPressed: () async {
                            String erro = '';
                            if (controllerNome.text.length < 3) {
                              erro = '${erro}Nome Inválido. ';
                            }
                            if (controllerDescricao.text.length < 3) {
                              erro = '${erro}Descrição Inválida. ';
                            }
                            if (controllerCategoria.text.length < 3) {
                              erro = '${erro}Categoria Inválida. ';
                            }
                            if (erro == '') {
                              final Map<String, dynamic> body = {
                                'nome': controllerNome.text,
                                'descricao': controllerDescricao.text,
                                'preco': (controllerPreco.numberValue * 100)
                                    .roundToDouble()
                                    .toString()
                                    .substring(
                                        0,
                                        controllerPreco.numberValue
                                            .toString()
                                            .length),
                                'categoria': controllerCategoria.text
                              };
                              if (idProduto != null && idProduto.isNotEmpty) {
                                final resposta =
                                    await put('/produto/$idProduto', body);
                                if (resposta == null) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('Servidor Inoperante'),
                                  ));
                                } else {
                                  if (resposta.statusCode == 200 ||
                                      resposta.statusCode == 201) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                          Text('Produto alterado com sucesso'),
                                    ));
                                    Navigator.pushNamed(context, '/produto');
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text('Erro ao alterar produto'),
                                    ));
                                  }
                                }
                              } else {
                                final resposta = await post('/produto', body);
                                if (resposta == null) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('Servidor Inoperante'),
                                  ));
                                } else {
                                  if (resposta.statusCode == 200 ||
                                      resposta.statusCode == 201) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                          Text('Produto gravado com sucesso'),
                                    ));
                                    Navigator.pushNamed(context, '/produto');
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text('Erro ao gravar produto'),
                                    ));
                                  }
                                }
                              }

                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(erro),
                              ));
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 88, 211, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          child: const Text(
                            'Salvar',
                            style:
                                TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )));
  }
}

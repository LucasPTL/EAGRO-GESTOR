// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:eagro_gestor/utils/http_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_form_field/phone_form_field.dart';

class CadastroPessoasPageWidget extends StatefulWidget {
  const CadastroPessoasPageWidget({super.key, String? id});

  @override
  State<CadastroPessoasPageWidget> createState() =>
      _CadastroPessoasPageWidgetState();
}

class _CadastroPessoasPageWidgetState extends State<CadastroPessoasPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController controllerNome = TextEditingController();
  final TextEditingController controllerContato = TextEditingController();
  final TextEditingController controllerDDD = TextEditingController();
  final TextEditingController controllerEndereco = TextEditingController();
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

    final String? idPessoa =
        ModalRoute.of(context)?.settings.arguments as String?;

    void populaCampos(String? idPessoa) async {
      if (idPessoa != null && idPessoa.isNotEmpty) {
        // Corrigido aqui
        var resposta = await get('/pessoa/$idPessoa');
        var pessoa = jsonDecode(resposta!.body);
        if (resposta.statusCode == 200) {
          try {
            controllerNome.text = pessoa['nome'];
            controllerEndereco.text = pessoa['endereco'];
            String contato = pessoa['contato'];
            controllerDDD.text = contato.substring(0, 2);
            controllerContato.text = contato.substring(2, contato.length);
          } catch (e) {
            debugPrint("Erro ao buscar pessoa: $e");
          }
        } else {
          debugPrint(
              "Erro ao buscar pessoa: status code ${resposta.statusCode}");
        }
      }
    }

    populaCampos(idPessoa);

    return Scaffold(
        backgroundColor: const Color.fromARGB(164, 34, 57, 88),
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Cadastro de Pessoas'),
        ),
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
                        controller: controllerNome,
                        decoration: const InputDecoration(
                          hintText: 'Insira o nome',
                          labelText: 'Pessoa',
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
                        controller: controllerEndereco,
                        decoration: const InputDecoration(
                          hintText: 'Insira o endereço',
                          labelText: 'Endereço',
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
                      SizedBox(
                        width: larguraTelaPorc(60),
                        child: Row(
                          children: [
                            SizedBox(
                              width: larguraTelaPorc(7),
                              child: TextField(
                                textAlign: TextAlign.center,
                                textAlignVertical: TextAlignVertical.center,
                                maxLength: 2,
                                maxLengthEnforcement: MaxLengthEnforcement
                                    .truncateAfterCompositionEnds,
                                controller: controllerDDD,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  counterText: '',
                                  labelText: 'DDD',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 88, 211, 40)),
                                  hintStyle: TextStyle(color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 88, 211, 40)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 88, 211, 40)),
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: larguraTelaPorc(3),
                            ),
                            SizedBox(
                              width: larguraTelaPorc(50),
                              child: TextField(
                                maxLength: 9,
                                controller: controllerContato,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  counterText: '',
                                  alignLabelWithHint: true,
                                  hintText: 'Insira o contato',
                                  labelText: 'Contato',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 88, 211, 40)),
                                  hintStyle: TextStyle(color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 88, 211, 40)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 88, 211, 40)),
                                  ),
                                ),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: alturaTelaPorc(4),
                      ),
                      SizedBox(
                        width: larguraTelaPorc(40),
                        child: TextButton(
                          onPressed: () async {
                            var erro = '';
                            if (controllerNome.text.length < 3) {
                              erro = '${erro}Nome Inválido. ';
                            }
                            if (controllerEndereco.text.length < 3) {
                              erro = '${erro}Endereço Inválido. ';
                            }
                            if (controllerDDD.text.length != 2) {
                              erro = '${erro}DDD Inválido. ';
                            }
                            if (controllerContato.text.length < 8) {
                              erro = '${erro}Contato Inválido. ';
                            }
                            if (erro == '') {
                              final Map<String, dynamic> body = {
                                'nome': controllerNome.text,
                                'endereco': controllerEndereco.text,
                                'contato':
                                    controllerDDD.text + controllerContato.text
                              };
                              if (idPessoa != null && idPessoa.isNotEmpty) {
                                final resposta =
                                    await put('/pessoa/$idPessoa', body);
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
                                          Text('Pessoa alterada com sucesso'),
                                    ));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text('Erro ao alterar pessoa'),
                                    ));
                                  }
                                }
                              } else {
                                final resposta = await post('/pessoa', body);
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
                                          Text('Pessoa gravada com sucesso'),
                                    ));
                                    Navigator.pushNamed(context, '/pessoa');
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text('Erro ao gravar pessoa'),
                                    ));
                                  }
                                }
                              }

                              setState(() {});
                            }
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
                            'Cadastrar',
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

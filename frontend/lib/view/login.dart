// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:eagro_gestor/utils/http_client.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({super.key});

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool senhaVisivel = false;
  String erro = '';
  final TextEditingController controllerLogin = TextEditingController();
  final TextEditingController controllerSenha = TextEditingController();
  @override
  void initState() {
    senhaVisivel = false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double larguraTelaPorc(double porc) {
      double larguraTela = MediaQuery.sizeOf(context).width;
      return (larguraTela * (porc / 100));
    }

    double alturaTelaPorc(double porc) {
      double alturaTela = MediaQuery.sizeOf(context).height;
      return (alturaTela * (porc / 100));
    }

    return Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color.fromARGB(164, 34, 57, 88),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: alturaTelaPorc(65),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: alturaTelaPorc(5)),
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: alturaTelaPorc(15),
                              width: larguraTelaPorc(60),
                              child: const Image(
                                image: AssetImage('assets/Logo-EAGRO.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Do campo para sua mão.',
                            style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 28,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: larguraTelaPorc(90),
                        child: Column(
                          children: [
                            SizedBox(height: alturaTelaPorc(4)),
                            TextField(
                              controller: controllerLogin,
                              decoration: const InputDecoration(
                                hintText: 'Insira seu usuário',
                                labelText: 'Usuário',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
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
                            SizedBox(height: alturaTelaPorc(4)),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: controllerSenha,
                                    obscureText: !senhaVisivel,
                                    decoration: InputDecoration(
                                      hintText: 'Insira sua senha',
                                      labelText: 'Senha',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      errorText: erro.isEmpty ? null : erro,
                                      labelStyle: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 88, 211, 40)),
                                      hintStyle:
                                          const TextStyle(color: Colors.white),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 88, 211, 40)),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 88, 211, 40)),
                                      ),
                                    ),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    senhaVisivel
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      senhaVisivel = !senhaVisivel;
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: alturaTelaPorc(4)),
                            SizedBox(
                              width: larguraTelaPorc(40),
                              child: TextButton(
                                onPressed: () async {
                                  String login = controllerLogin.text;

                                  Uint8List bytes =
                                      utf8.encode(controllerSenha.text);
                                  Digest digest = sha256.convert(bytes);
                                  final Map<String, dynamic> body = {
                                    'login': login,
                                    'senha': digest.toString(),
                                  };
                                  final resposta = await post(
                                      '/usuario/verificarUsuario', body);
                                  if (resposta == null) {
                                    erro = "Servidor inoperante.";
                                  } else {
                                    if (resposta.statusCode == 200) {
                                      erro = "";
                                      Navigator.pushNamed(context, '/home');
                                    } else {
                                      erro = "Usuário ou senha incorretos.";
                                    }
                                  }
                                  setState(() {});
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 88, 211, 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                child: const Text(
                                  'Entrar',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: alturaTelaPorc(35),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/Background-EAGRO.png'),
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

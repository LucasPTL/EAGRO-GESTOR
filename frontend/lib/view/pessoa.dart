import 'package:flutter/material.dart';

class PessoasPageWidget extends StatefulWidget {
  const PessoasPageWidget({super.key});

  @override
  State<PessoasPageWidget> createState() => _PessoasPageWidgetState();
}

class _PessoasPageWidgetState extends State<PessoasPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(164, 34, 57, 88),
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Cadastro de Pessoas'),
        ),
        body: const SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [],
          ),
        )));
  }
}

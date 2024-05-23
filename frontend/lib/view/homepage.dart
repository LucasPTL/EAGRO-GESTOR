import 'package:flutter/material.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool drawerOpen = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void toggleDrawer() {
    setState(() {
      scaffoldKey.currentState?.openDrawer();
      drawerOpen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        drawer: SafeArea(
            child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: alturaTelaPorc(8), // Defina a altura desejada aqui
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(26, 77, 46, 1),
                ),
                child: const Center(
                  child: Text('E-Agro Gestor',
                      style: TextStyle(color: Colors.white, fontSize: 24)),
                ),
              ),
              ListTile(
                title: const Text('Pessoas'),
                onTap: () {
                  Navigator.pushNamed(context, '/pessoa');
                },
              ),
              ListTile(
                title: const Text('Cadastro de Produtos'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ExpansionTile(
                title: const Text('Pedidos'),
                children: <Widget>[
                  ListTile(
                    title: const Text('Adicionar Pedido'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Visualizar Pedidos'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text('Relatórios'),
                children: <Widget>[
                  ListTile(
                    title: const Text('Relatório de Pedidos'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Relatório Financeiro'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        )),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: larguraTelaPorc(100),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onPressed: toggleDrawer,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

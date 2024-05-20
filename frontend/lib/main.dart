import 'package:eagro_gestor/view/homepage.dart';
import 'package:eagro_gestor/view/login.dart';
import 'package:eagro_gestor/view/pessoa.dart'; // Importe a nova página de pessoas
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor:
          Colors.transparent, // Torna a barra de status transparente
      statusBarIconBrightness:
          Brightness.dark, // Define a cor dos ícones da barra de status
    ),
  );
  runApp(const EAgro());
}

class EAgro extends StatelessWidget {
  const EAgro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Agro Gestor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPageWidget(),
        '/home': (context) => const HomePageWidget(),
        '/pessoa': (context) =>
            const PessoasPageWidget(), // Adicione a rota para a página de pessoas
      },
    );
  }
}

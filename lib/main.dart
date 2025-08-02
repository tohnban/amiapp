import 'package:ami_projecto/pages/homepage.dart';
import 'package:ami_projecto/themes/themeprovider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Método que retorna a lista de IDs de vídeos
  List<String> getVideoIds() {
    return [
      'ZkIvWLIWXwo', // Exemplo de IDs de vídeos
      '2izp7IJVugs',
      'yjNp-ZGU8DM',
      'ZkIvWLIWXwo',
      '2izp7IJVugs',
      // Adicione mais IDs conforme necessário
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(
        videoIds: getVideoIds(), // Passa a lista de IDs para o Homepage
      ),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}

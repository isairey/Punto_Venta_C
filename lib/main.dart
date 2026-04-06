import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'vista/inicio.dart';


void main() async {
  await Hive.initFlutter();
  Hive.openBox('productos');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: inicio(), // Asegúrate de utilizar el nombre correcto para la clase Inicio
      debugShowCheckedModeBanner: false,
    );
  }
}

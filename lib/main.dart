import 'package:flutter/material.dart';
import 'screen/screen_promedio.dart';
import 'screen/screen_trabajador.dart';
import 'screen/screen_descuento.dart';
import 'screen/screen_comision.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: ScreenPromedio(),
      //home: ScreenTrabajador(),
      //home: ScreenDescuento(),
      home: ScreenComision(),
    );
  }
}
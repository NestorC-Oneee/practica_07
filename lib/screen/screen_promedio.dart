import 'package:flutter/material.dart';
import '../controllers/promedio_controller.dart';

class ScreenPromedio extends StatefulWidget {
  const ScreenPromedio({super.key});

  @override
  State<ScreenPromedio> createState() => _ScreenPromedioState();
}

class _ScreenPromedioState extends State<ScreenPromedio> {
  // Declaración 
  final nombre = TextEditingController();
  final nota1 = TextEditingController();
  final nota2 = TextEditingController();
  final nota3 = TextEditingController();

  final _promedioController = PromedioController();

  double _resultadoPromedio = 0;
  String _estadoResultado = '';
  String _mensajeError = '';

  void _calcular() {
    setState(() {
      _mensajeError = '';
    });

    
    if (nombre.text.isEmpty ||
        nota1.text.isEmpty ||
        nota2.text.isEmpty ||
        nota3.text.isEmpty) {
      setState(() {
        _mensajeError = 'Todos los campos son obligatorios';
      });
      return;
    }

    double n1 = double.tryParse(nota1.text) ?? -1;
    double n2 = double.tryParse(nota2.text) ?? -1;
    double n3 = double.tryParse(nota3.text) ?? -1;

    // Validar rango de 0 a 20
    if (!_promedioController.validarNotas(n1, n2, n3)) {
      setState(() {
        _mensajeError = 'Las notas deben estar entre 0 y 20';
      });
      return;
    }

    setState(() {
      _resultadoPromedio = _promedioController.calcularPromedio(n1, n2, n3);
      _estadoResultado = _promedioController.determinarEstado(_resultadoPromedio);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promedio Académico'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Uso en los TextField en la propiedad controller
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nombre,
                decoration: const InputDecoration(labelText: 'Nombre del estudiante'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nota1,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Ingrese Nota 1'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nota2,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Ingrese Nota 2'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nota3,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Ingrese Nota 3'),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => _calcular(),
                child: const Text('Calcular Promedio'),
              ),
            ),
            if (_mensajeError.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  _mensajeError,
                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Promedio: ${_resultadoPromedio.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Estado: $_estadoResultado",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _estadoResultado == 'Aprobado' ? Colors.green : Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    //liberar memoria en el dispose
    nombre.dispose();
    nota1.dispose();
    nota2.dispose();
    nota3.dispose();
    super.dispose();
  }
}
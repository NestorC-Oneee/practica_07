import 'package:flutter/material.dart';
import '../controllers/trabajador_controller.dart';

class ScreenTrabajador extends StatefulWidget {
  const ScreenTrabajador({super.key});

  @override
  State<ScreenTrabajador> createState() => _ScreenTrabajadorState();
}

class _ScreenTrabajadorState extends State<ScreenTrabajador> {
  // Controladores de texto simples
  final nombre = TextEditingController();
  final horasTrabajadas = TextEditingController();
  final tarifaHora = TextEditingController();

  // Instancia del controlador
  final _trabajadorController = TrabajadorController();

  double _sueldoFinal = 0;
  String _mensajeError = '';

  void _calcular() {
    setState(() {
      _mensajeError = '';
    });

    // Validar campos vacíos
    if (nombre.text.isEmpty ||
        horasTrabajadas.text.isEmpty ||
        tarifaHora.text.isEmpty) {
      setState(() {
        _mensajeError = 'Todos los campos son obligatorios';
      });
      return;
    }

    double horas = double.tryParse(horasTrabajadas.text) ?? -1;
    double tarifa = double.tryParse(tarifaHora.text) ?? -1;

    // Validar que no sean negativos
    if (!_trabajadorController.validarDatos(horas, tarifa)) {
      setState(() {
        _mensajeError = 'Las horas y la tarifa no pueden ser negativas';
      });
      return;
    }

    setState(() {
      _sueldoFinal = _trabajadorController.calcularSueldoTotal(horas, tarifa);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pago de Trabajador'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nombre,
                decoration: const InputDecoration(labelText: 'Nombre del trabajador'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: horasTrabajadas,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Horas trabajadas'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: tarifaHora,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Tarifa por hora (S/.)'),
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
                child: const Text('Calcular Sueldo'),
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
                "Sueldo Total: S/. ${_sueldoFinal.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nombre.dispose();
    horasTrabajadas.dispose();
    tarifaHora.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import '../controllers/comision_controller.dart';

class ScreenComision extends StatefulWidget {
  const ScreenComision({super.key});

  @override
  State<ScreenComision> createState() => _ScreenComisionState();
}

class _ScreenComisionState extends State<ScreenComision> {
  // Controladores de texto simples
  final vendedor = TextEditingController();
  final ventasInput = TextEditingController();

  // Instancia del controlador
  final _comisionController = ComisionController();

  double _montoComision = 0;
  double _sueldoTotal = 0;
  String _mensajeError = '';

  void _calcular() {
    setState(() {
      _mensajeError = '';
    });

    // Validar campos vacíos
    if (vendedor.text.isEmpty || ventasInput.text.isEmpty) {
      setState(() {
        _mensajeError = 'Todos los campos son obligatorios';
      });
      return;
    }

    double ventas = double.tryParse(ventasInput.text) ?? -1;

    // Validar ventas negativas
    if (!_comisionController.validarVentas(ventas)) {
      setState(() {
        _mensajeError = 'Las ventas no pueden ser negativas';
      });
      return;
    }

    double comision = _comisionController.calcularComision(ventas);
    double total = _comisionController.calcularSueldoTotal(comision);

    setState(() {
      _montoComision = comision;
      _sueldoTotal = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comisión por Ventas'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: vendedor,
                decoration: const InputDecoration(labelText: 'Nombre del vendedor'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: ventasInput,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Monto total de ventas (S/.)'),
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
                child: const Text('Calcular Comisión'),
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
                "Comisión ganada: S/. ${_montoComision.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Sueldo total: S/. ${_sueldoTotal.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    vendedor.dispose();
    ventasInput.dispose();
    super.dispose();
  }
}
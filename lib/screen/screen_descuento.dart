import 'package:flutter/material.dart';
import '../controllers/descuento_controller.dart';

class ScreenDescuento extends StatefulWidget {
  const ScreenDescuento({super.key});

  @override
  State<ScreenDescuento> createState() => _ScreenDescuentoState();
}

class _ScreenDescuentoState extends State<ScreenDescuento> {
  // Controladores de texto simples
  final producto = TextEditingController();
  final importeInput = TextEditingController();

  // Instancia del controlador
  final _descuentoController = DescuentoController();

  double _montoDescuento = 0;
  double _totalPagar = 0;
  String _mensajeError = '';

  void _calcular() {
    setState(() {
      _mensajeError = '';
    });

    // Validar campos vacíos
    if (producto.text.isEmpty || importeInput.text.isEmpty) {
      setState(() {
        _mensajeError = 'Todos los campos son obligatorios';
      });
      return;
    }

    double importe = double.tryParse(importeInput.text) ?? -1;

    // Validar importe negativo
    if (!_descuentoController.validarImporte(importe)) {
      setState(() {
        _mensajeError = 'El importe no puede ser negativo';
      });
      return;
    }

    double descuento = _descuentoController.calcularDescuento(importe);
    double total = _descuentoController.calcularTotalPagar(importe, descuento);

    setState(() {
      _montoDescuento = descuento;
      _totalPagar = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cálculo de Descuento'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: producto,
                decoration: const InputDecoration(labelText: 'Nombre del producto'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: importeInput,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Importe de la compra (S/.)'),
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
                child: const Text('Calcular Descuento'),
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
                "Descuento aplicado: S/. ${_montoDescuento.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Total a pagar: S/. ${_totalPagar.toStringAsFixed(2)}",
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
    producto.dispose();
    importeInput.dispose();
    super.dispose();
  }
}
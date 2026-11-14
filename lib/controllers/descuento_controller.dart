class DescuentoController {
  // Calcula el descuento (10% si es mayor a 100, caso contrario 5%)
  double calcularDescuento(double importe) {
    double porcentaje = 0.0;
    if (importe > 100) {
      porcentaje = 0.10;
    } else {
      porcentaje = 0.05;
    }
    return importe * porcentaje;
  }

  // Calcula el total a pagar restando el descuento
  double calcularTotalPagar(double importe, double descuento) {
    return importe - descuento;
  }

  // Valida que el importe no sea negativo
  bool validarImporte(double importe) {
    if (importe < 0) {
      return false;
    }
    return true;
  }
}
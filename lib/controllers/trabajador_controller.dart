class TrabajadorController {
  // Calcula el sueldo total (si pasa de 48 horas, las horas extras se pagan a 1.5x)
  double calcularSueldoTotal(double horas, double tarifa) {
    double sueldoTotal = 0;
    if (horas <= 48) {
      sueldoTotal = horas * tarifa;
    } else {
      double horasNormales = 48;
      double horasExtras = horas - 48;
      sueldoTotal = (horasNormales * tarifa) + (horasExtras * tarifa * 1.5);
    }
    return sueldoTotal;
  }

  // Valida que las horas y la tarifa no sean negativas
  bool validarDatos(double horas, double tarifa) {
    if (horas < 0 || tarifa < 0) {
      return false;
    }
    return true;
  }
}
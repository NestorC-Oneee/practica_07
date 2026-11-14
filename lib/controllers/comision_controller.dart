class ComisionController {
  // Calcula la comisión (10% si las ventas son > 5000, caso contrario 5%)
  double calcularComision(double ventas) {
    double porcentaje = 0.0;
    if (ventas > 5000) {
      porcentaje = 0.10;
    } else {
      porcentaje = 0.05;
    }
    return ventas * porcentaje;
  }

  // Calcula el sueldo total (Sueldo base fijo de S/. 1000 + Comisión)
  double calcularSueldoTotal(double comision) {
    double sueldoBase = 1000.0;
    return sueldoBase + comision;
  }

  // Valida que las ventas no sean negativas
  bool validarVentas(double ventas) {
    if (ventas < 0) {
      return false;
    }
    return true;
  }
}
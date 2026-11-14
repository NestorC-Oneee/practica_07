class PromedioController {
  double calcularPromedio(double n1, double n2, double n3) {
    return (n1 + n2 + n3) / 3;
  }

  String determinarEstado(double promedio) {
    if (promedio >= 13) {
      return "Aprobado";
    } else {
      return "Desaprobado";
    }
  }

  bool validarNotas(double n1, double n2, double n3) {
    if (n1 < 0 || n1 > 20 || n2 < 0 || n2 > 20 || n3 < 0 || n3 > 20) {
      return false;
    }
    return true;
  }
}
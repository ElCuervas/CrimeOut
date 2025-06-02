/// Valida un RUT chileno (Rol Único Tributario).
///
/// El RUT se compone de una serie de dígitos seguidos por un dígito verificador (que puede ser un número o la letra 'K').
/// Esta función limpia el RUT de puntos y guiones, calcula el dígito verificador esperado usando el algoritmo Módulo 11
/// y lo compara con el dígito ingresado.
///
/// ### Ejemplos válidos:
/// - `12.345.678-5`
/// - `98765432-K`
///
/// ### Parámetros:
/// - [rut]: El RUT en formato string (puede incluir puntos y guión).
///
/// ### Retorna:
/// - `true` si el RUT es válido según el cálculo del dígito verificador.
/// - `false` si no es válido o si tiene un formato incorrecto.
bool isValidRut(String rut) {
  // Limpia el RUT eliminando puntos y guiones, y lo convierte a mayúsculas
  rut = rut.replaceAll('.', '').replaceAll('-', '').toUpperCase();

  if (rut.length < 2) return false;

  final digits = rut.substring(0, rut.length - 1); // Parte numérica del RUT
  final verifier = rut[rut.length - 1]; // Dígito verificador

  // Verifica que los dígitos sean numéricos
  if (!RegExp(r'^\d+$').hasMatch(digits)) return false;

  int sum = 0;
  int multiplier = 2;

  // Calcula la suma ponderada de los dígitos del RUT
  for (int i = digits.length - 1; i >= 0; i--) {
    sum += int.parse(digits[i]) * multiplier;
    multiplier = (multiplier == 7) ? 2 : multiplier + 1;
  }

  // Cálculo del dígito verificador esperado usando Módulo 11
  final mod11 = 11 - (sum % 11);
  String expected;

  if (mod11 == 11) {
    expected = '0';
  } else if (mod11 == 10) {
    expected = 'K';
  } else {
    expected = mod11.toString();
  }

  return verifier == expected;
}
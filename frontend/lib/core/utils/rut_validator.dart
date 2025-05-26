bool isValidRut(String rut) {
  rut = rut.replaceAll('.', '').replaceAll('-', '').toUpperCase();

  if (rut.length < 2) return false;

  final digits = rut.substring(0, rut.length - 1);
  final verifier = rut[rut.length - 1];

  if (!RegExp(r'^\d+\$').hasMatch(digits)) return false;

  int sum = 0;
  int multiplier = 2;

  for (int i = digits.length - 1; i >= 0; i--) {
    sum += int.parse(digits[i]) * multiplier;
    multiplier = multiplier == 7 ? 2 : multiplier + 1;
  }

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
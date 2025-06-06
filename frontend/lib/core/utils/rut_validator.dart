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
class RutValidator {
  static String charAt(String subject, int position) {
    if (subject is! String ||
        subject.length <= position ||
        subject.length + position < 0) {
      return '';
    }

    int _realPosition = position < 0 ? subject.length + position : position;

    return subject[_realPosition];
  }

  static bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  static bool Check(String rut) {
    // Despejar Puntos
    var valor = rut.replaceAll('.', '');
    // Despejar Guión
    valor = valor.replaceAll('-', '');

    var cuerpo = valor.substring(0, valor.length - 1);

    var dv = valor.substring(valor.length - 1).toUpperCase();

    if (isNumeric(cuerpo)) {
      // Formatear RUN
      rut = cuerpo + '-' + dv;

      // Si no cumple con el mínimo ej. (n.nnn.nnn)
      if (cuerpo.length < 7) {
        return false;
      }

      // Calcular Dígito Verificador
      var suma = 0;
      var multiplo = 2;

      // Para cada dígito del Cuerpo (de derecha a izquierda)
      for (var i = cuerpo.length - 1; i >= 0; i--) {
        suma += int.parse(cuerpo[i]) * multiplo;
        multiplo = multiplo < 7 ? multiplo + 1 : 2;
      }

      // Calcular Dígito Verificador en base al Módulo 11
      var dvEsperado = 11 - (suma % 11);

      String dvCalculado;
      if (dvEsperado == 11) {
        dvCalculado = '0';
      } else if (dvEsperado == 10) {
        dvCalculado = 'K';
      } else {
        dvCalculado = dvEsperado.toString();
      }

      // Validar que el Cuerpo coincide con su Dígito Verificador
      if (dv != dvCalculado) {
        return false;
      }

      // Si todo sale bien, eliminar errores (decretar que es válido)
      return true;
    } else {
      return false;
    }
  }
}

class Validation {
  static bool documentID(String _cedula) {
    String cedula = _cedula.replaceAll('-', '').trim();

    int verificador = 0;
    int digito = 0;
    int digitoVerificador = 0;
    int digitoImpar = 0;
    int sumaPar = 0;
    int sumaImpar = 0;
    int longitud = cedula.length;

    if (longitud == 11) {
      if ('0'.allMatches(cedula).length == 11) return false;
      digitoVerificador = int.parse(cedula.substring(10));

      for (int i = 9; i >= 0; i--) {
        digito = int.parse(cedula.substring(i, i + 1));
        if ((i % 2) != 0) {
          digitoImpar = digito * 2;

          if (digitoImpar >= 10) {
            digitoImpar = digitoImpar - 9;
          }
          sumaImpar = sumaImpar + digitoImpar;
        } else {
          sumaPar = sumaPar + digito;
        }
      }
      verificador = 10 - ((sumaPar + sumaImpar) % 10);

      if (((verificador == 10) && (digitoVerificador == 0)) ||
          (verificador == digitoVerificador)) {
        return true;
      }
    }

    return false;
  }

  static String number(String number, {String text}) {
    if (number.isEmpty)
      return 'Digitar ' + text;
    else if (int.parse(number) <= 0) return text + 'debe ser mayor a 0';
    return null;
  }

  static String text(String input, {String text}) {
    if (input.isEmpty) return 'Digitar ' + text;
    return null;
  }
}

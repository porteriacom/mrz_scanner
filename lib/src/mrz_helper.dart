class MRZHelper {
  static List<String>? getFinalListToParse(List<String> ableToScanTextList) {
    if (ableToScanTextList.length < 2) {
      // Mínimo número de líneas de cualquier formato MRZ es 2
      return null;
    }
    int lineLength = ableToScanTextList.first.length;
    for (var e in ableToScanTextList) {
      if (e.length != lineLength) {
        return null;
      }
      // Para asegurarse de que todas las líneas tengan la misma longitud
    }
    List<String> firstLineChars = ableToScanTextList.first.split('');
    String firstLine = ableToScanTextList.first;

    // Verificar si la primera línea comienza con 'INCHL' (DNI chileno)
    if (firstLine.startsWith('INCHL')) {
      return [...ableToScanTextList];
    }

    // Verificar si la primera línea comienza con 'IDARG' (DNI argentino)
    if (firstLine.startsWith('IDARG')) {
      return [...ableToScanTextList];
    }

    // Verificar si la primera línea comienza con 'IDMEX' (DNI Mexicano)
    if (firstLine.startsWith('IDMEX')) {
      return [...ableToScanTextList];
    }
    // Verificar si la primera línea comienza con 'IDFRA' (DNI Frances)
    if (firstLine.startsWith('IDFRA')) {
      return [...ableToScanTextList];
    }

    // Verificar si la primera línea comienza con 'IDESP' (DNI Español)
    if (firstLine.startsWith('IDESP')) {
      return [...ableToScanTextList];
    }

    List<String> supportedDocTypes = ['A', 'C', 'P', 'V', 'I', 'IN', 'ID'];
    String fChar = firstLineChars[0];
    String sChar = firstLineChars[1];

    if ((sChar == '<' && supportedDocTypes.contains(fChar)) ||
        ableToScanTextList.first.startsWith('INCHL') ||
        ableToScanTextList.first.startsWith('IDARG') ||
        ableToScanTextList.first.startsWith('IDMEX') ||
        ableToScanTextList.first.startsWith('IDFRA') ||
        ableToScanTextList.first.startsWith('IDESP')) {
      return [...ableToScanTextList];
    }
    return null;
  }

  static String testTextLine(String text) {
    String res = text.replaceAll(' ', '');
    List<String> list = res.split('');

    // Para comprobar si el texto pertenece a algún formato MRZ
    if (list.length < 30 || list.length > 44) {
      return '';
    }

    for (int i = 0; i < list.length; i++) {
      if (RegExp(r'^[A-Za-z0-9_.]+$').hasMatch(list[i])) {
        list[i] = list[i].toUpperCase();
        // Para asegurarse de que todas las letras estén en mayúsculas
      }
      if (double.tryParse(list[i]) == null &&
          !(RegExp(r'^[A-Za-z0-9_.]+$').hasMatch(list[i]))) {
        list[i] = '<';
        // A veces el signo < no se reconoce bien
      }
    }
    String result = list.join('');
    return result;
  }
}

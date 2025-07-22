extension StringExt on String {
  int toInt() {
    return int.parse(this);
  }

  double toDouble() {
    return double.parse(this);
  }

  String get appendRuppeeSymbol => "₹$this";

  String initCap() {
    if (isEmpty) {
      return "";
    }
    if (length == 1) {
      return toUpperCase();
    }
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String removeDecimal() {
    if (!contains('.0') && !contains('.00')) {
      return this;
    }
    if (contains('.0')) {
      return replaceAll('.0', '');
    }
    return replaceAll('.00', '');
  }
}

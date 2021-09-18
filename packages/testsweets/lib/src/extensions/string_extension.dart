extension CapExtension on String {
  String get removePrecisionIfZero =>
      this.isEmpty ? '' : this.replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");

  String get inCaps =>
      this.isEmpty ? '' : '${this[0].toUpperCase()}${this.substring(1)}';
  String get firstLetterInSmallLetter =>
      this.isEmpty ? '' : '${this[0].toLowerCase()}${this.substring(1)}';

  String get allInCaps => this.isEmpty ? '' : this.toUpperCase();

  String get capitalizeFirstofEach =>
      this.isEmpty ? '' : this.split(" ").map((str) => str.inCaps).join(" ");
}

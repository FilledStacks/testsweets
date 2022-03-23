import 'dart:ui';

extension CapExtension on String {
  String get removePrecisionIfZero =>
      this.isEmpty ? '' : this.replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");

  String get inCaps =>
      this.isEmpty ? '' : '${this[0].toUpperCase()}${this.substring(1)}';
  String get firstLetterInSmallLetter =>
      this.isEmpty ? '' : '${this[0].toLowerCase()}${this.substring(1)}';

  String get allInCaps => this.isEmpty ? '' : this.toUpperCase();

  String get capitalizeFirstOfEach =>
      this.isEmpty ? '' : this.split(" ").map((str) => str.inCaps).join(" ");
}

extension WidgetDescriptionStringValidation on String {
  String get convertWidgetNameToValidFormat {
    final trimmerText = this.trim();
    assert(trimmerText.isNotEmpty);
    return trimmerText.replaceAllMapped(
        RegExp(r'[/\-_\s]+([.\S])'), (match) => match.group(1)!.inCaps);
  }

  String get restoreWidgetNameToOriginal {
    final trimmerText = this.trim();
    assert(trimmerText.isNotEmpty);
    return trimmerText.replaceAllMapped(RegExp(r'[A-Z][a-z0-9]+'),
        (match) => ' ' + match.group(0)!.firstLetterInSmallLetter);
  }

  String get convertViewNameToValidFormat {
    final trimmerText = this.trim();
    assert(trimmerText.isNotEmpty);
    if (trimmerText == '/')
      return 'initialView';
    else
      return trimmerText.replaceAll('/', '').replaceAllMapped(
          RegExp(r'[/\-_\s]+([.\S])'), (match) => match.group(1)!.inCaps);
  }
}

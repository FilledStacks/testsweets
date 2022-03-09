import 'package:testsweets/testsweets.dart';

extension ScrollableDescriptionExtension on ScrollableDescription {
  String get generateHash =>
      // this.rect.width.toStringAsFixed(0) +
      // '#' +
      // this.rect.height.toStringAsFixed(0) +
      // '#' +
      this.rect.top.toStringAsFixed(0) +
      '#' +
      this.rect.left.toStringAsFixed(0);
}

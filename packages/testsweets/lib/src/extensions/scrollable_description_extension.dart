import 'package:testsweets/testsweets.dart';

extension ScrollableDescriptionExtension on ScrollableDescription {
  String get generateHash =>
      (this.rect.width + this.rect.height + this.rect.top + this.rect.bottom)
          .toStringAsFixed(0);
}

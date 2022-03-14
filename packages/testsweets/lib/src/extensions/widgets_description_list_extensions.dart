import 'package:testsweets/testsweets.dart';

extension WidgetDescriptionListExtension on List<WidgetDescription> {
  List<WidgetDescription> replaceInteractions(
      List<WidgetDescription> updatedInteractions) {
    final nonAffectedItems =
        this.where((interaction) => interaction.externalities == null);

    return nonAffectedItems.followedBy(updatedInteractions).toList();
  }
}

import 'package:testsweets/testsweets.dart';

extension WidgetDescriptionListExtension on List<WidgetDescription> {
  List<WidgetDescription> replaceInteractions(
      List<WidgetDescription> updatedInteractions) {
    final nonAffectedItems = this.where((interaction) => updatedInteractions
        .any((updatedInteraction) => updatedInteraction.id != interaction.id));
    return nonAffectedItems.followedBy(updatedInteractions).toList();
  }
}

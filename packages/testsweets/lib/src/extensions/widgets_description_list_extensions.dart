import 'package:testsweets/testsweets.dart';
import 'package:collection/collection.dart';

extension WidgetDescriptionListExtension on List<WidgetDescription> {
  List<WidgetDescription> replaceInteractions(
      Iterable<WidgetDescription> updatedInteractions) {
    final updatedInteractionsIds = updatedInteractions.map((e) => e.id);
    final nonAffectedItems =
        this.whereNot((element) => updatedInteractionsIds.contains(element.id));

    return nonAffectedItems.followedBy(updatedInteractions).toList();
  }
}

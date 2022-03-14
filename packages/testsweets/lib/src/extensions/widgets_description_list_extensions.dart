import 'package:testsweets/testsweets.dart';
import 'package:collection/collection.dart';

extension WidgetDescriptionListExtension on List<Interaction> {
  List<Interaction> replaceInteractions(
      Iterable<Interaction> updatedInteractions) {
    final updatedInteractionsIds = updatedInteractions.map((e) => e.id);
    final nonAffectedItems =
        this.whereNot((element) => updatedInteractionsIds.contains(element.id));

    return nonAffectedItems.followedBy(updatedInteractions).toList();
  }
}

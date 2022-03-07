import 'package:flutter/widgets.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/extensions/widget_position_extension.dart';
import 'package:testsweets/testsweets.dart';
import 'package:collection/collection.dart';

import '../models/capture_exception.dart';

abstract class ReactiveInteraction {
  /// Filter the founded lists to exclude the ones that doesn't overlap
  /// with our widget
  Iterable<ScrollableDescription> overlappingListWithWidget(
      Iterable<ScrollableDescription> listsRect, WidgetPosition widgetPosition);

  /// After you confirm a list is overlapping with the newly created widget
  /// You should check if the list is accually captured previously by comparing all the
  /// scrollable interactions in this view if they overlap with our list
  String findAssociatedInteractionWithScrollable(
      ScrollableDescription scrollableDescription,
      List<WidgetDescription> viewInteractions);
}

class ReactiveScrollable extends ReactiveInteraction {
  @override
  Iterable<ScrollableDescription> overlappingListWithWidget(
          Iterable<ScrollableDescription> listsRect,
          WidgetPosition widgetPosition) =>
      listsRect
          .where((element) => element.rect.contains(widgetPosition.toOffset));

  @override
  String findAssociatedInteractionWithScrollable(
    ScrollableDescription scrollableDescription,
    List<WidgetDescription> viewInteractions,
  ) {
    final interactionThatRepresentScrollable = viewInteractions.where(
        (element) =>
            element.widgetType == WidgetType.scrollable &&
            element.axis == scrollableDescription.axis);

    if (interactionThatRepresentScrollable.isEmpty)
      throw NoScrollableInteractionsInsideThisScrollableWidget();

    if (interactionThatRepresentScrollable.length > 1)
      throw FoundMoreThanOneScrollInteractionPerScrollable();

    return interactionThatRepresentScrollable.first.id!;
  }
}

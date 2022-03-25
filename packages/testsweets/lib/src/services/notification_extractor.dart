import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:testsweets/src/extensions/widgets_description_list_extensions.dart';
import 'package:testsweets/src/services/reactive_scrollable.dart';
import 'package:testsweets/testsweets.dart';

import '../locator.dart';

abstract class NotificationExtractor {
  bool onlyScrollUpdateNotification(Notification notification);

  ScrollableDescription notificationToScrollableDescription(
      Notification notification);

  List<Interaction> scrollInteractions(
      ScrollableDescription scrollableDescription,
      List<Interaction> viewInteractions);
}

class NotificationExtractorImp implements NotificationExtractor {
  final _reactiveScrollable = locator<ReactiveScrollable>();

  ScrollDirection? scrollDirection;
  Offset? globalPosition;
  Offset? localPosition;

  @override
  bool onlyScrollUpdateNotification(Notification notification) {
    if (notification is ScrollStartNotification) {
      globalPosition = notification.dragDetails!.globalPosition;
      localPosition = notification.dragDetails!.localPosition;
      return false;
    } else if (notification is UserScrollNotification) {
      scrollDirection = notification.direction;
      return false;
    } else {
      return true;
    }
  }

  @override
  List<Interaction> scrollInteractions(
      ScrollableDescription scrollableDescription,
      List<Interaction> viewInteractions) {
    _reactiveScrollable.currentScrollableDescription = scrollableDescription;

    final affectedInteractions = _reactiveScrollable
        .filterAffectedInteractionsByScrollable(viewInteractions);

    final scrolledInteractions = _reactiveScrollable
        .moveInteractionsWithScrollable(affectedInteractions);

    return viewInteractions.replaceInteractions(scrolledInteractions);
  }

  @override
  ScrollableDescription notificationToScrollableDescription(
      Notification notification) {
    return ScrollableDescription.fromNotification(
        globalPosition: globalPosition!,
        localPosition: localPosition!,
        metrics: (notification as ScrollUpdateNotification).metrics,
        scrollDirection: scrollDirection!);
  }
}

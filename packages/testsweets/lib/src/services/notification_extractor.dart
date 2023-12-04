import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:testsweets/src/app/logger.dart';
import 'package:testsweets/src/extensions/widgets_description_list_extensions.dart';
import 'package:testsweets/src/services/reactive_scrollable.dart';
import 'package:testsweets/testsweets.dart';

import '../locator.dart';

class NotificationExtractor {
  final log = getLogger('NotificationExtractor');
  final _reactiveScrollable = locator<ReactiveScrollable>();

  ScrollDirection? scrollDirection;
  Offset? globalPosition;
  Offset? localPosition;

  ScrollableDescription? lastScrollEvent;

  bool onlyScrollUpdateNotification(Notification notification) {
    log.v(notification);
    _setScrollablePositionAndScrollDirection(notification);

    if (notification is ScrollUpdateNotification) {
      return true;
    } else {
      return false;
    }
  }

  void _setScrollablePositionAndScrollDirection(Notification notification) {
    if (notification is ScrollStartNotification) {
      globalPosition = notification.dragDetails!.globalPosition;
      localPosition = notification.dragDetails!.localPosition;
    } else if (notification is UserScrollNotification) {
      scrollDirection = notification.direction;
    }
  }

  List<Interaction> scrollInteractions(
    ScrollableDescription scrollableDescription,
    List<Interaction> viewInteractions,
  ) {
    lastScrollEvent = scrollableDescription;

    _reactiveScrollable.currentScrollableDescription = scrollableDescription;

    final affectedInteractions = _reactiveScrollable
        .filterAffectedInteractionsByScrollable(viewInteractions);

    final scrolledInteractions = _reactiveScrollable
        .moveInteractionsWithScrollable(affectedInteractions);

    return viewInteractions.replaceInteractions(scrolledInteractions);
  }

  ScrollableDescription notificationToScrollableDescription(
      Notification notification) {
    log.v(notification);

    return ScrollableDescription.fromNotification(
      globalPosition: globalPosition!,
      localPosition: localPosition!,
      metrics: (notification as ScrollUpdateNotification).metrics,
      scrollDirection: scrollDirection!,
    );
  }

  Interaction syncInteractionWithScrollable(Interaction interaction) {
    if (lastScrollEvent != null) {
      final scrollInteractionOrEmpty =
          scrollInteractions(lastScrollEvent!, [interaction]);
      return scrollInteractionOrEmpty.isNotEmpty
          ? scrollInteractionOrEmpty.first
          : interaction;
    } else {
      return interaction;
    }
  }
}

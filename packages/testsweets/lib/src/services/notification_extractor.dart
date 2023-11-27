import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:testsweets/src/app/logger.dart';
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

  Interaction syncInteractionWithScrollable(Interaction interaction);
}

class NotificationExtractorImp implements NotificationExtractor {
  final log = getLogger('NotificationExtractorImp');
  final _reactiveScrollable = locator<ReactiveScrollable>();

  ScrollDirection? scrollDirection;
  Offset? globalPosition;
  Offset? localPosition;

  ScrollableDescription? lastScrollEvent;
  @override
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

  @override
  List<Interaction> scrollInteractions(
      ScrollableDescription scrollableDescription,
      List<Interaction> viewInteractions) {
    lastScrollEvent = scrollableDescription;

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
    log.v(notification);

    return ScrollableDescription.fromNotification(
      globalPosition: globalPosition!,
      localPosition: localPosition!,
      metrics: (notification as ScrollUpdateNotification).metrics,
      scrollDirection: scrollDirection!,
    );
  }

  @override
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

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:testsweets/testsweets.dart';

abstract class NotificationExtractor {
  ScrollableDescription toScrollableDescription(
      ScrollUpdateNotification notification);
  void setScrollDirection(UserScrollNotification scrollUpdateNotification);
  void setGlobalAndLocalOffsets(ScrollStartNotification notification);
}

class NotificationExtractorImp implements NotificationExtractor {
  ScrollDirection? scrollDirection;
  Offset? globalPosition;
  Offset? localPosition;

  @override
  ScrollableDescription toScrollableDescription(
      ScrollUpdateNotification scrollUpdateNotification) {
    return ScrollableDescription.fromNotification(
        globalPosition: globalPosition!,
        localPosition: localPosition!,
        metrics: scrollUpdateNotification.metrics,
        scrollDirection: scrollDirection!);
  }

  @override
  void setGlobalAndLocalOffsets(
      ScrollStartNotification scrollStartNotification) {
    globalPosition = scrollStartNotification.dragDetails!.globalPosition;
    localPosition = scrollStartNotification.dragDetails!.localPosition;
  }

  @override
  void setScrollDirection(UserScrollNotification userScrollNotification) {
    scrollDirection = userScrollNotification.direction;
  }
}

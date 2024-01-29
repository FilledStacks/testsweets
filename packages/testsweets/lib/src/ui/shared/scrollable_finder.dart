import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testsweets/src/app/logger.dart';
import 'package:testsweets/src/models/serializable_rect.dart';

import '../../models/scrollable_description.dart';

class ScrollableFinder {
  final log = getLogger('ScrollableFinder');

  Iterable<ScrollableDescription> getAllScrollableDescriprionsOnScreen() {
    final scrollablesOnScreen =
        find.byType(Scrollable).hitTestable().evaluate();

    log.v('scrollablesOnScreen: $scrollablesOnScreen');
    final extractedScrollableDescriptions = scrollablesOnScreen
        .map((item) {
          try {
            RenderBox renderBox = item.findRenderObject() as RenderBox;

            log.v('RenderBox: $renderBox');
            Offset globalPostion = renderBox.localToGlobal(Offset.zero);

            log.v('globalPosition: $globalPostion');

            final position = (item.widget as Scrollable).controller?.position;

            if (position != null) {
              final scrollExtentByPixels = position.pixels;
              final maxScrollExtentByPixels = position.maxScrollExtent;
              final axis = position.axis;
              final rect = SerializableRect.fromPoints(
                  globalPostion,
                  globalPostion.translate(
                    renderBox.size.width,
                    renderBox.size.height,
                  ));

              return ScrollableDescription(
                  axis: axis,
                  rect: rect,
                  scrollExtentByPixels: scrollExtentByPixels,
                  maxScrollExtentByPixels: maxScrollExtentByPixels);
            } else {
              log.v(
                'scroll controller is null, how are we gonna get past this?',
              );
            }
          } catch (e) {
            log.e(e);
            return null;
          }
        })
        .where((element) => element != null)
        .cast<ScrollableDescription>();

    log.i('extractedScrollableDescriptions: $extractedScrollableDescriptions');

    return extractedScrollableDescriptions;
  }
}

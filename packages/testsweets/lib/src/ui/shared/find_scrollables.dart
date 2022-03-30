import 'package:flutter/material.dart';
import 'package:testsweets/src/app/logger.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:flutter_test/flutter_test.dart';

abstract class FindScrollables {
  Iterable<Element>? foundedElements;
  void searchForScrollableElements();
  Iterable<ScrollableDescription> convertElementsToScrollDescriptions();
}

class FindScrollablesImp implements FindScrollables {
  final log = getLogger('FindScrollables');

  Iterable<Element>? foundedElements;

  @override
  void searchForScrollableElements() {
    foundedElements = find.byType(Scrollable).hitTestable().evaluate();
  }

  @override
  Iterable<ScrollableDescription> convertElementsToScrollDescriptions() {
    if (foundedElements == null) {
      log.e('foundedElements is null');
      return [];
    }
    log.v('foundedElements: $foundedElements');
    final extractedScrollableDescriptions = foundedElements!
        .map((item) {
          try {
            RenderBox renderBox = item.findRenderObject() as RenderBox;

            Offset globalPostion = renderBox.localToGlobal(Offset.zero);
            final position =
                (item.widget as Scrollable).controller!.positions.first;

            final scrollExtentByPixels = position.pixels;
            final maxScrollExtentByPixels = position.maxScrollExtent;
            final axis = position.axis;
            final rect = SerializableRect.fromPoints(
                globalPostion,
                globalPostion.translate(
                    renderBox.size.width, renderBox.size.height));

            return ScrollableDescription(
                axis: axis,
                rect: rect,
                scrollExtentByPixels: scrollExtentByPixels,
                maxScrollExtentByPixels: maxScrollExtentByPixels);
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

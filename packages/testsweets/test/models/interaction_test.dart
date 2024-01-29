import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/models/interaction.dart';
import 'package:testsweets/src/models/widget_position.dart';

void main() {
  group('InteractionTest -', () {
    group('updatePosition -', () {
      test(
          'When called with a position that does not match the current active size, should add a new position with new x,y and set it to active',
          () {
        var interaction = Interaction(
          viewName: '',
          originalViewName: '',
          widgetType: WidgetType.general,
          widgetPositions: [
            WidgetPosition(
              x: 10,
              y: 10,
              capturedDeviceWidth: 10,
              capturedDeviceHeight: 20,
              orientation: Orientation.portrait,
              active: true,
            )
          ],
        );

        final updatedInteraction = interaction.updatePosition(
          x: 11,
          y: 11,
          currentWidth: 11,
          currentHeight: 20,
          orientation: Orientation.portrait,
        );

        expect(updatedInteraction.widgetPositions.length, 2);
        expect(updatedInteraction.widgetPositions.last.active, true);
        expect(updatedInteraction.widgetPositions.last.capturedDeviceWidth, 11);
        expect(
            updatedInteraction.widgetPositions.last.capturedDeviceHeight, 20);
        expect(updatedInteraction.widgetPositions.first.active, false);
      });

      test(
          'When called with a position that match the current active size, not add new position, and update renderPosition',
          () {
        var interaction = Interaction(
          viewName: '',
          originalViewName: '',
          widgetType: WidgetType.general,
          widgetPositions: [
            WidgetPosition(
              x: 10,
              y: 10,
              capturedDeviceWidth: 10,
              capturedDeviceHeight: 20,
              orientation: Orientation.portrait,
              active: true,
            )
          ],
        );

        final updatedInteraction = interaction.updatePosition(
          x: 11,
          y: 11,
          currentWidth: 10,
          currentHeight: 20,
          orientation: Orientation.portrait,
        );

        expect(updatedInteraction.widgetPositions.length, 1);
        expect(updatedInteraction.widgetPositions.first.active, true);
        expect(updatedInteraction.widgetPositions.first.x, 11);
        expect(updatedInteraction.widgetPositions.first.y, 11);
      });

      test(
          'When called with a position that match that has match in the list, but not active, should add new position, and set to active',
          () {
        var interaction = Interaction(
          viewName: '',
          originalViewName: '',
          widgetType: WidgetType.general,
          widgetPositions: [
            WidgetPosition(
              x: 10,
              y: 10,
              capturedDeviceWidth: 10,
              capturedDeviceHeight: 20,
              orientation: Orientation.portrait,
              active: true,
            ),
            WidgetPosition(
              x: 20,
              y: 20,
              capturedDeviceWidth: 20,
              capturedDeviceHeight: 40,
              orientation: Orientation.portrait,
            ),
          ],
        );

        final updatedInteraction = interaction.updatePosition(
          x: 11,
          y: 11,
          currentWidth: 12,
          currentHeight: 15,
          orientation: Orientation.portrait,
        );

        expect(updatedInteraction.widgetPositions.length, 3);
        expect(updatedInteraction.widgetPositions.last.active, true);
        expect(updatedInteraction.widgetPositions.last.x, 11);
        expect(updatedInteraction.widgetPositions.last.y, 11);
      });
    });

    group('migrate -', () {
      test(
          'When called with model that has v1 capturedSizes, and no matching, should have widgetPosition with matching size after migrate',
          () {
        var interaction = Interaction(
          viewName: '',
          originalViewName: '',
          widgetType: WidgetType.general,
          // ignore: deprecated_member_use_from_same_package
          position: WidgetPosition(
            x: 10,
            y: 10,
            capturedDeviceWidth: 10,
            capturedDeviceHeight: 20,
          ),
        );

        interaction = interaction.migrate();

        expect(interaction.widgetPositions.length, 1);
        expect(interaction.widgetPositions.first.x, 10);
        expect(interaction.widgetPositions.first.y, 10);
        expect(interaction.widgetPositions.first.capturedDeviceWidth, 10);
        expect(interaction.widgetPositions.first.capturedDeviceHeight, 20);
      });

      test(
          'When called with model that has v1 capturedSizes, and matching, should not add an additional device details entry',
          () {
        var interaction = Interaction(
            viewName: '',
            originalViewName: '',
            widgetType: WidgetType.general,
            // ignore: deprecated_member_use_from_same_package
            position: WidgetPosition(
              x: 10,
              y: 10,
              capturedDeviceWidth: 10,
              capturedDeviceHeight: 20,
            ),
            widgetPositions: [
              WidgetPosition(
                x: 10,
                y: 10,
                capturedDeviceWidth: 10,
                capturedDeviceHeight: 20,
                orientation: Orientation.portrait,
              )
            ]);

        interaction = interaction.migrate();

        expect(interaction.widgetPositions.length, 1);
      });

      test(
          'When called with model that has v1 capturedSizes, and non matching deiceBucket, should not add a new additional device details entry',
          () {
        var interaction = Interaction(
            viewName: '',
            originalViewName: '',
            widgetType: WidgetType.general,
            // ignore: deprecated_member_use_from_same_package
            position: WidgetPosition(
              x: 10,
              y: 10,
              capturedDeviceWidth: 10,
              capturedDeviceHeight: 15,
            ),
            widgetPositions: [
              WidgetPosition(
                x: 10,
                y: 10,
                capturedDeviceWidth: 10,
                capturedDeviceHeight: 20,
                orientation: Orientation.portrait,
              )
            ]);

        interaction = interaction.migrate();

        expect(interaction.widgetPositions.length, 2);
      });
    });

    group('setActivePosition -', () {
      test('When called with only one widgetPostion, should set it to true',
          () {
        var interaction = Interaction(
          viewName: '',
          originalViewName: '',
          widgetType: WidgetType.general,
          widgetPositions: [
            WidgetPosition(
              x: 10,
              y: 10,
              capturedDeviceWidth: 10,
              capturedDeviceHeight: 20,
              orientation: Orientation.portrait,
            )
          ],
        );

        interaction = interaction.setActivePosition(
          size: Size.zero,
          orientation: Orientation.portrait,
        );

        expect(interaction.widgetPositions.first.active, true);
      });

      test(
          'When called with portrait, and has two positions of differen orientations, should set portrait orientation to active',
          () {
        var interaction = Interaction(
          viewName: '',
          originalViewName: '',
          widgetType: WidgetType.general,
          widgetPositions: [
            WidgetPosition(
              x: 10,
              y: 10,
              capturedDeviceWidth: 10,
              capturedDeviceHeight: 20,
              orientation: Orientation.portrait,
            ),
            WidgetPosition(
              x: 10,
              y: 10,
              capturedDeviceWidth: 10,
              capturedDeviceHeight: 20,
              orientation: Orientation.landscape,
            ),
          ],
        );

        interaction = interaction.setActivePosition(
          size: Size(10, 20),
          orientation: Orientation.portrait,
        );

        expect(interaction.widgetPositions.first.active, true);
      });

      test(
          'When called with portrait, and has three positions of in portrait, should set closest matching one to active',
          () {
        var interaction = Interaction(
          viewName: '',
          originalViewName: '',
          widgetType: WidgetType.general,
          widgetPositions: [
            WidgetPosition(
              x: 10,
              y: 10,
              capturedDeviceWidth: 1,
              capturedDeviceHeight: 2,
              orientation: Orientation.portrait,
            ),
            WidgetPosition(
              x: 10,
              y: 10,
              capturedDeviceWidth: 5,
              capturedDeviceHeight: 10,
              orientation: Orientation.portrait,
            ),
            WidgetPosition(
              x: 10,
              y: 10,
              capturedDeviceWidth: 10,
              capturedDeviceHeight: 20,
              orientation: Orientation.portrait,
            ),
          ],
        );

        interaction = interaction.setActivePosition(
          size: Size(2, 2),
          orientation: Orientation.portrait,
        );

        expect(interaction.widgetPositions.first.active, true);
      });
    });
  });
}

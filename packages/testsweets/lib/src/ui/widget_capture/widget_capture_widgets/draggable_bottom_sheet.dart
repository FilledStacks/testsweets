import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:testsweets/src/enums/capture_widget_enum.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets/widget_circle.dart';
import 'package:provider/provider.dart';
import 'widget_card.dart';

class DraggableBottomSheet extends StatefulWidget {
  const DraggableBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<DraggableBottomSheet> createState() => _DraggableBottomSheetState();
}

class _DraggableBottomSheetState extends State<DraggableBottomSheet> {
  late SolidController solidController;
  @override
  void initState() {
    solidController = SolidController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WidgetCaptureViewModel>();

    return SolidBottomSheet(
      controller: solidController,
      headerBar: SvgPicture.asset(
        'packages/testsweets/assets/svgs/up_arrow_handle.svg',
      ),
      minHeight: 0,
      maxHeight: 125,
      toggleVisibilityOnTap: true,
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Text('Select the widget type to add',
                  textAlign: TextAlign.left, style: tsMedium()),
            ),
            SizedBox(
              height: 82,
              child: ListView(
                padding: const EdgeInsets.all(16),
                itemExtent: 136,
                scrollDirection: Axis.horizontal,
                children: [
                  WidgetCard(
                      onTap: model.onWidgetTypeSelected,
                      widgetCircle: WidgetCircle(
                        widgetType: WidgetType.touchable,
                      )),
                  WidgetCard(
                      onTap: model.onWidgetTypeSelected,
                      widgetCircle: WidgetCircle(
                        widgetType: WidgetType.scrollable,
                      )),
                  WidgetCard(
                      onTap: model.onWidgetTypeSelected,
                      widgetCircle: WidgetCircle(
                        widgetType: WidgetType.input,
                      )),
                ],
              ),
            ),
          ],
        ),
        decoration: kdBlackRoundedEdgeDecoration,
      ),
    );
  }
}

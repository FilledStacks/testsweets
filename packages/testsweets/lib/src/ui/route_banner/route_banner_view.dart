import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/ui/route_banner/route_banner_viewmodel.dart';
import 'package:testsweets/src/ui/shared/route_banner.dart';

class RouteBannerView extends StatelessWidget {
  final bool isCaptured;
  final Function()? onLongPress;
  const RouteBannerView({
    Key? key,
    required this.isCaptured,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Show the current route name and whether its captured or not
    return ViewModelBuilder<RouteBannerViewmodel>.reactive(
      builder: (context, model, _) => Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onLongPress: onLongPress,
          child: RouteBanner(
            isCaptured: isCaptured,
            routeName: model.currentViewName,
          ),
        ),
      ),
      viewModelBuilder: () => RouteBannerViewmodel(),
    );
  }
}

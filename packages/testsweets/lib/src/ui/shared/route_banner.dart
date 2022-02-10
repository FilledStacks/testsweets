import 'package:flutter/material.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';

import 'app_colors.dart';

class RouteBanner extends StatelessWidget {
  final String routeName;
  final bool isCaptured;
  const RouteBanner(
      {Key? key, required this.routeName, this.isCaptured = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SafeArea(
        child: Opacity(
          opacity: 0.4,
          child: Container(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            decoration: kdRouteNameDecoration.copyWith(
              border: isCaptured
                  ? Border.all(
                      width: 3,
                      color: kcPrimaryPurple,
                    )
                  : null,
            ),
            child: Text(
              routeName,
              style: tsSmallBold().copyWith(color: kcSubtext),
            ),
          ),
        ),
      ),
    );
  }
}
